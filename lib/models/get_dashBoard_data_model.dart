import 'dart:convert';

DashBoardDataModel dashBoardDataModelFromJson(String str) => DashBoardDataModel.fromJson(json.decode(str));

class DashBoardDataModel {
  final bool? status;
  final Data? data;

  DashBoardDataModel({
    this.status,
    this.data,
  });

  factory DashBoardDataModel.fromJson(Map<String, dynamic> json) => DashBoardDataModel(
    status: json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  final Attendance? attendance;
  final Stats? stats;

  Data({
    this.attendance,
    this.stats,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    attendance: json["attendance"] == null ? null : Attendance.fromJson(json["attendance"]),
    stats: json["stats"] == null ? null : Stats.fromJson(json["stats"]),
  );
}

class Attendance {
  final String? inTime;
  final String? outTime;

  Attendance({
    this.inTime,
    this.outTime,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
    inTime: json["in_time"],
    outTime: json["out_time"],
  );
}

class Stats {
  final int? balance;
  final int? todaysEarning;
  final int? thismonthEarning;
  final int? target;
  final String? acheived;

  Stats({
    this.balance,
    this.todaysEarning,
    this.thismonthEarning,
    this.target,
    this.acheived,
  });

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
    balance: json["balance"],
    todaysEarning: json["todays_earning"],
    thismonthEarning: json["thismonth_earning"],
    target: json["target"],
    acheived: json["acheived"],
  );
}
