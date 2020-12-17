class LabeledLatLng {
  LabeledLatLng({
    this.label,
    this.lat,
    this.lng,
  });

  String label;
  double lat;
  double lng;

  factory LabeledLatLng.fromJson(Map<String, dynamic> json) => LabeledLatLng(
        label: json["label"],
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "lat": lat,
        "lng": lng,
      };
}
