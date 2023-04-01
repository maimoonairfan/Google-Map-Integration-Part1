import 'package:flutter/material.dart';
import 'package:map_app/getUserCurrentLocation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.amberAccent
      ),
      home: GetCurrentUserLocation(),
    );
  }
}
