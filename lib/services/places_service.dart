import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:nearest_hospitals/constants/error_messages.dart';
import 'package:nearest_hospitals/customError/fault.dart';
import 'package:nearest_hospitals/models/venue.dart';

class PlacesService {
  static final PlacesService _placesService = PlacesService._internal();

  factory PlacesService() {
    return _placesService;
  }
  PlacesService._internal();

  getNearestPlaces(
    String venueId,
    String clientId,
    String clientSecret,
    String apiVersion,
    String lat,
    String long,
    String query,
    String radius,
  ) async {
    String venueSearchEndPoint =
        "https://api.foursquare.com/v2/venues/$venueId?client_id=$clientId&client_secret=$clientSecret&v=$apiVersion&ll=$lat,$long&query=$query&radius=$radius";
    try {
      var response = await http.get(venueSearchEndPoint);
      var venue = venueFromJson(response.body);
      return venue;
    } on SocketException {
      throw Fault(message: NO_INTERNET_CONNECTION);
    } on HttpException {
      throw Fault(message: CAN_NOT_REACH_SERVER);
    }
  }
}
