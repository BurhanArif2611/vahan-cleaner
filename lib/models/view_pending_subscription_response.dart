import 'dart:convert';

ViewPendingSubscriptionResponse viewSubscriptionResponseFromJson(String str) => ViewPendingSubscriptionResponse.fromJson(json.decode(str));

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
  final String? flatInfo;
  final String? locationName;
  final String? brand;
  final String? model;
  final String? regNumber;
  final String? parkingLocation;
  final String? image;
  final String? readyTime;
  final String? points;
  final String mode = "";

  Vahan({
    this.subscriptionId,
    this.name,
    this.flatInfo,
    this.locationName,
    this.brand,
    this.model,
    this.regNumber,
    this.parkingLocation,
    this.image,
    this.readyTime,
    this.points,
  });

  factory Vahan.fromJson(Map<String, dynamic> json) => Vahan(
    subscriptionId: json["subscription_id"],
    name: json["name"],
    flatInfo: json["flat_info"],
    locationName: json["location_name"],
    brand: json["brand"],
    model: json["model"],
    regNumber: json["reg_number"],
    parkingLocation: json["parking_location"],
    image: json["image"],
    readyTime: json["ready_time"],
    points: json["points"],
  );
}
