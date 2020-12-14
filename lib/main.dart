import 'package:flutter/material.dart';
import 'package:nearest_hospitals/Notifiers/location_notifier.dart';
import 'package:nearest_hospitals/screens/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(NearestHospitals());
}

class NearestHospitals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LocationNotifier())
      ],
      child: MaterialApp(
        title: 'Nearest Hospitals app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Home(),
      ),
    );
  }
}
