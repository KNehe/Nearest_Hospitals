import 'package:nearest_hospitals/models/icon.dart';

class Category {
  Category({
    this.id,
    this.name,
    this.pluralName,
    this.shortName,
    this.icon,
    this.primary,
  });

  String id;
  String name;
  String pluralName;
  String shortName;
  Icon icon;
  bool primary;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        pluralName: json["pluralName"],
        shortName: json["shortName"],
        icon: Icon.fromJson(json["icon"]),
        primary: json["primary"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "pluralName": pluralName,
        "shortName": shortName,
        "icon": icon.toJson(),
        "primary": primary,
      };
}
