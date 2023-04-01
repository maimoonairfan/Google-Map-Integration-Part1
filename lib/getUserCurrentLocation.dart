import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetCurrentUserLocation extends StatefulWidget {
  const GetCurrentUserLocation({super.key});

  @override
  State<GetCurrentUserLocation> createState() => _GetCurrentUserLocationState();
}

class _GetCurrentUserLocationState extends State<GetCurrentUserLocation> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition kgooglemap = CameraPosition(
      target: LatLng(24.91956408237602, 67.0573471078485), zoom: 14.474);

  List<Marker> _marker = [];
  final List<Marker> _list = [
    // Marker(
    //     markerId: MarkerId('1'),
    //     position: LatLng(24.91956408237602, 67.0573471078485),
    //     infoWindow: InfoWindow(title: 'My current location')),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadLocationData();
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value) {
      print("error");
    });
    return await Geolocator.getCurrentPosition();
  }

  loadLocationData() {
    getUserCurrentLocation().then((value) async {
      print('My current location');
      print(value.latitude.toString() + "" + value.longitude.toString());

      _marker.add(Marker(
          markerId: MarkerId('2'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: InfoWindow(title: 'My current Location')));
      CameraPosition cameraPosition = CameraPosition(
          target: LatLng(value.latitude, value.longitude), zoom: 14);
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
            initialCameraPosition: kgooglemap,
            markers: Set<Marker>.of(_marker),
            mapType: MapType.normal,
            compassEnabled: false,
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.local_activity),
      ),
    );
  }
}
