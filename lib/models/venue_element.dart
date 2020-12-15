import 'package:nearest_hospitals/models/category.dart';
import 'package:nearest_hospitals/models/location.dart';

class VenueElement {
  VenueElement({
    this.id,
    this.name,
    this.location,
    this.categories,
    this.referralId,
    this.hasPerk,
  });

  String id;
  String name;
  Location location;
  List<Category> categories;
  String referralId;
  bool hasPerk;

  factory VenueElement.fromJson(Map<String, dynamic> json) => VenueElement(
        id: json["id"],
        name: json["name"],
        location: Location.fromJson(json["location"]),
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        referralId: json["referralId"],
        hasPerk: json["hasPerk"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "location": location.toJson(),
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "referralId": referralId,
        "hasPerk": hasPerk,
      };
}
