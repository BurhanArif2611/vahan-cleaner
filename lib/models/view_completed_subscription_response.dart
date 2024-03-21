import 'dart:convert';

ViewCompletedSubscriptionResponse viewCompletedSubscriptionResponseFromJson(String str) => ViewCompletedSubscriptionResponse.fromJson(json.decode(str));

String viewCompletedSubscriptionResponseToJson(ViewCompletedSubscriptionResponse data) => json.encode(data.toJson());

class ViewCompletedSubscriptionResponse {
  final bool? status;
  final List<CompleteVahan>? completeVahans;
  final String? baseurl;
  final Stats? stats;

  ViewCompletedSubscriptionResponse({
    this.status,
    this.completeVahans,
    this.baseurl,
    this.stats,
  });

  factory ViewCompletedSubscriptionResponse.fromJson(Map<String, dynamic> json) => ViewCompletedSubscriptionResponse(
    status: json["status"],
    completeVahans: json["vahans"] == null ? [] : List<CompleteVahan>.from(json["vahans"]!.map((x) => CompleteVahan.fromJson(x))),
    baseurl: json["baseurl"],
    stats: json["stats"] == null ? null : Stats.fromJson(json["stats"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "vahans": completeVahans == null ? [] : List<dynamic>.from(completeVahans!.map((x) => x.toJson())),
    "baseurl": baseurl,
    "stats": stats?.toJson(),
  };
}

class Stats {
  final int? balance;
  final int? todaysEarning;

  Stats({
    this.balance,
    this.todaysEarning,
  });

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
    balance: json["balance"],
    todaysEarning: json["todays_earning"],
  );

  Map<String, dynamic> toJson() => {
    "balance": balance,
    "todays_earning": todaysEarning,
  };
}

class CompleteVahan {
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
  final String? mode;

  CompleteVahan({
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
    this.mode,
  });

  factory CompleteVahan.fromJson(Map<String, dynamic> json) => CompleteVahan(
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
    mode: json["mode"],
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
    "mode": mode,
  };
}
