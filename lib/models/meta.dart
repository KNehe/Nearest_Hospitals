class Meta {
  Meta({
    this.code,
    this.requestId,
  });

  int code;
  String requestId;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        code: json["code"],
        requestId: json["requestId"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "requestId": requestId,
      };
}
