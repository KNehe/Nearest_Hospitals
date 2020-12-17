import 'package:nearest_hospitals/models/venue_element.dart';

class Response {
  Response({
    this.venues,
  });

  List<VenueElement> venues;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        venues: List<VenueElement>.from(
            json["venues"].map((x) => VenueElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "venues": List<dynamic>.from(venues.map((x) => x.toJson())),
      };
}
