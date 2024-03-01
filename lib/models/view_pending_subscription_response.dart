import 'dart:convert';

ViewPendingSubscriptionResponse viewSubscriptionResponseFromJson(String str) => ViewPendingSubscriptionResponse.fromJson(json.decode(str));

String viewSubscriptionResponseToJson(ViewPendingSubscriptionResponse data) => json.encode(data.toJson());

class ViewPendingSubscriptionResponse {
  final bool? status;
  final List<Vahan>? vahans;
  final String? baseurl;
  final Stats? stats;

  ViewPendingSubscriptionResponse({
    this.status,
    this.vahans,
    this.baseurl,
    this.stats,
  });

  ViewPendingSubscriptionResponse copyWith({
    bool? status,
    List<Vahan>? vahans,
    String? baseurl,
    Stats? stats,
  }) =>
      ViewPendingSubscriptionResponse(
        status: status ?? this.status,
        vahans: vahans ?? this.vahans,
        baseurl: baseurl ?? this.baseurl,
        stats: stats ?? this.stats,
      );

  factory ViewPendingSubscriptionResponse.fromJson(Map<String, dynamic> json) => ViewPendingSubscriptionResponse(
    status: json["status"],
    vahans: json["vahans"] == null ? [] : List<Vahan>.from(json["vahans"]!.map((x) => Vahan.fromJson(x))),
    baseurl: json["baseurl"],
    stats: json["stats"] == null ? null : Stats.fromJson(json["stats"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "vahans": vahans == null ? [] : List<dynamic>.from(vahans!.map((x) => x.toJson())),
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

  Stats copyWith({
    int? balance,
    int? todaysEarning,
  }) =>
      Stats(
        balance: balance ?? this.balance,
        todaysEarning: todaysEarning ?? this.todaysEarning,
      );

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
    balance: json["balance"],
    todaysEarning: json["todays_earning"],
  );

  Map<String, dynamic> toJson() => {
    "balance": balance,
    "todays_earning": todaysEarning,
  };
}

class Vahan {
  final String? subscriptionId;
  final String? name;
  final String? flat_info;
  final String? brand;
  final String? model;
  final String? regNumber;
  final String? parkingLocation;
  final String? image;
  final String? readyTime;
  final String? points;

  Vahan({
    this.subscriptionId,
    this.name,
    this.flat_info,
    this.brand,
    this.model,
    this.regNumber,
    this.parkingLocation,
    this.image,
    this.readyTime,
    this.points,
  });

  Vahan copyWith({
    String? subscriptionId,
    String? name,
    String? flat_info,
    String? brand,
    String? model,
    String? regNumber,
    String? parkingLocation,
    String? image,
    String? readyTime,
    String? points,
  }) =>
      Vahan(
        subscriptionId: subscriptionId ?? this.subscriptionId,
        name: name ?? this.name,
        flat_info: flat_info ?? this.flat_info,
        brand: brand ?? this.brand,
        model: model ?? this.model,
        regNumber: regNumber ?? this.regNumber,
        parkingLocation: parkingLocation ?? this.parkingLocation,
        image: image ?? this.image,
        readyTime: readyTime ?? this.readyTime,
        points: points ?? this.points,
      );

  factory Vahan.fromJson(Map<String, dynamic> json) => Vahan(
    subscriptionId: json["subscription_id"],
    name: json["name"],
    flat_info: json["flat_info"],
    brand: json["brand"],
    model: json["model"],
    regNumber: json["reg_number"],
    parkingLocation: json["parking_location"],
    image: json["image"],
    readyTime: json["ready_time"],
    points: json["points"],
  );

  Map<String, dynamic> toJson() => {
    "subscription_id": subscriptionId,
    "name": name,
    "flat_info": flat_info,
    "brand": brand,
    "model": model,
    "reg_number": regNumber,
    "parking_location": parkingLocation,
    "image": image,
    "ready_time": readyTime,
    "points": points,
  };
}
