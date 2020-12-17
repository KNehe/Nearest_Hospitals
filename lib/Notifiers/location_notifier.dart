import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nearest_hospitals/services/location_service.dart';
import 'package:nearest_hospitals/customError/fault.dart';

class LocationNotifier extends ChangeNotifier {
  LocationService _locationService = LocationService();

  Position _currentPosition;

  Fault _error;

  bool _isLoading = true;

  Position get getCurrentPosition => _currentPosition;

  Fault get getError => _error;

  bool get isLoading => _isLoading;

  setPosition(Position position) {
    _currentPosition = position;
  }

  setError(Fault error) {
    _error = error;
    notifyListeners();
  }

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future checkLocationPermissions() async {
    try {
      Position position = await _locationService.checkLocationPermissions();
      setPosition(position);
    } on Fault catch (e) {
      setError(e);
    }
    setLoading(false);
  }
}
