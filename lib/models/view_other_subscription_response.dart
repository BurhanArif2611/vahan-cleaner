import 'dart:convert';

OtherSubscriptionModel otherSubscriptionModelFromJson(String str) => OtherSubscriptionModel.fromJson(json.decode(str));

String otherSubscriptionModelToJson(OtherSubscriptionModel data) => json.encode(data.toJson());

class OtherSubscriptionModel {
  final bool? status;
  final List<OthersVahan>? vahans;
  final String? baseurl;
  final OthersStats? stats;

  OtherSubscriptionModel({
    this.status,
    this.vahans,
    this.baseurl,
    this.stats,
  });

  factory OtherSubscriptionModel.fromJson(Map<String, dynamic> json) => OtherSubscriptionModel(
    status: json["status"],
    vahans: json["vahans"] == null ? [] : List<OthersVahan>.from(json["vahans"]!.map((x) => OthersVahan.fromJson(x))),
    baseurl: json["baseurl"],
    stats: json["stats"] == null ? null : OthersStats.fromJson(json["stats"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "vahans": vahans == null ? [] : List<dynamic>.from(vahans!.map((x) => x.toJson())),
    "baseurl": baseurl,
    "stats": stats?.toJson(),
  };
}

class OthersStats {
  final int? balance;
  final int? todaysEarning;

  OthersStats({
    this.balance,
    this.todaysEarning,
  });

  factory OthersStats.fromJson(Map<String, dynamic> json) => OthersStats(
    balance: json["balance"],
    todaysEarning: json["todays_earning"],
  );

  Map<String, dynamic> toJson() => {
    "balance": balance,
    "todays_earning": todaysEarning,
  };
}

class OthersVahan {
  final String? subscriptionId;
  final String? name;
  final String? brand;
  final String? model;
  final String? regNumber;
  final String? parkingLocation;
  final String? image;
  final String? readyTime;
  final String? flatInfo;
  final String? points;

  OthersVahan({
    this.subscriptionId,
    this.name,
    this.brand,
    this.model,
    this.regNumber,
    this.parkingLocation,
    this.image,
    this.readyTime,
    this.flatInfo,
    this.points,
  });

  factory OthersVahan.fromJson(Map<String, dynamic> json) => OthersVahan(
    subscriptionId: json["subscription_id"],
    name: json["name"],
    brand: json["brand"],
    model: json["model"],
    regNumber: json["reg_number"],
    parkingLocation: json["parking_location"],
    image: json["image"],
    readyTime: json["ready_time"],
    flatInfo: json["flat_info"],
    points: json["points"],
  );

  Map<String, dynamic> toJson() => {
    "subscription_id": subscriptionId,
    "name": name,
    "brand": brand,
    "model": model,
    "reg_number": regNumber,
    "parking_location": parkingLocation,
    "image": image,
    "ready_time": readyTime,
    "flat_info": flatInfo,
    "points": points,
  };
}
