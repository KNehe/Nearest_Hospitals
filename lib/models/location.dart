import 'package:nearest_hospitals/models/labelled_latlng.dart';

class Location {
  Location({
    this.address,
    this.lat,
    this.lng,
    this.labeledLatLngs,
    this.distance,
    this.cc,
    this.city,
    this.state,
    this.country,
    this.formattedAddress,
    this.postalCode,
    this.crossStreet,
  });

  String address;
  double lat;
  double lng;
  List<LabeledLatLng> labeledLatLngs;
  int distance;
  String cc;
  String city;
  String state;
  String country;
  List<String> formattedAddress;
  String postalCode;
  String crossStreet;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        address: json["address"] == null ? null : json["address"],
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
        labeledLatLngs: List<LabeledLatLng>.from(
            json["labeledLatLngs"].map((x) => LabeledLatLng.fromJson(x))),
        distance: json["distance"],
        cc: json["cc"],
        city: json["city"] == null ? null : json["city"],
        state: json["state"] == null ? null : json["state"],
        country: json["country"],
        formattedAddress:
            List<String>.from(json["formattedAddress"].map((x) => x)),
        postalCode: json["postalCode"] == null ? null : json["postalCode"],
        crossStreet: json["crossStreet"] == null ? null : json["crossStreet"],
      );

  Map<String, dynamic> toJson() => {
        "address": address == null ? null : address,
        "lat": lat,
        "lng": lng,
        "labeledLatLngs":
            List<dynamic>.from(labeledLatLngs.map((x) => x.toJson())),
        "distance": distance,
        "cc": cc,
        "city": city == null ? null : city,
        "state": state == null ? null : state,
        "country": country,
        "formattedAddress": List<dynamic>.from(formattedAddress.map((x) => x)),
        "postalCode": postalCode == null ? null : postalCode,
        "crossStreet": crossStreet == null ? null : crossStreet,
      };
}
