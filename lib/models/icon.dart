class Icon {
  Icon({
    this.prefix,
    this.suffix,
  });

  String prefix;
  String suffix;

  factory Icon.fromJson(Map<String, dynamic> json) => Icon(
        prefix: json["prefix"],
        suffix: json["suffix"],
      );

  Map<String, dynamic> toJson() => {
        "prefix": prefix,
        "suffix": suffix,
      };
}
