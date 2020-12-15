import 'dart:convert';
import 'package:nearest_hospitals/models/meta.dart';
import 'package:nearest_hospitals/models/response.dart';

Venue venueFromJson(String str) => Venue.fromJson(json.decode(str));

String venueToJson(Venue data) => json.encode(data.toJson());

class Venue {
  Venue({
    this.meta,
    this.response,
  });

  Meta meta;
  Response response;

  factory Venue.fromJson(Map<String, dynamic> json) => Venue(
        meta: Meta.fromJson(json["meta"]),
        response: Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta.toJson(),
        "response": response.toJson(),
      };
}
