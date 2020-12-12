import 'package:flutter/material.dart';
import 'package:nearest_hospitals/screens/home.dart';

void main() {
  runApp(NearestHospitals());
}

class NearestHospitals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nearest Hospitals app',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}
