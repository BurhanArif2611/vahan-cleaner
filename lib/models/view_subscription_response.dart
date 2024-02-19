import 'dart:convert';

ViewSubscriptionResponse viewSubscriptionResponseFromJson(String str) => ViewSubscriptionResponse.fromJson(json.decode(str));

String viewSubscriptionResponseToJson(ViewSubscriptionResponse data) => json.encode(data.toJson());

class ViewSubscriptionResponse {
  final bool? status;
  final List<Vahan>? vahans;
  final String? baseurl;

  ViewSubscriptionResponse({
    this.status,
    this.vahans,
    this.baseurl,
  });

  factory ViewSubscriptionResponse.fromJson(Map<String, dynamic> json) => ViewSubscriptionResponse(
    status: json["status"],
    vahans: json["vahans"] == null ? [] : List<Vahan>.from(json["vahans"]!.map((x) => Vahan.fromJson(x))),
    baseurl: json["baseurl"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "vahans": vahans == null ? [] : List<dynamic>.from(vahans!.map((x) => x.toJson())),
    "baseurl": baseurl,
  };
}

class Vahan {
  final String? subscriptionId;
  final String? name;
  final String? brand;
  final String? model;
  final String? regNumber;
  final String? parkingLocation;
  final String? image;

  Vahan({
    this.subscriptionId,
    this.name,
    this.brand,
    this.model,
    this.regNumber,
    this.parkingLocation,
    this.image,
  });

  factory Vahan.fromJson(Map<String, dynamic> json) => Vahan(
    subscriptionId: json["subscription_id"],
    name: json["name"],
    brand: json["brand"],
    model: json["model"],
    regNumber: json["reg_number"],
    parkingLocation: json["parking_location"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "subscription_id": subscriptionId,
    "name": name,
    "brand": brand,
    "model": model,
    "reg_number": regNumber,
    "parking_location": parkingLocation,
    "image": image,
  };
}
