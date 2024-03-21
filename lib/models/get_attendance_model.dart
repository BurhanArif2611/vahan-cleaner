import 'dart:convert';

GetAttendanceModel getAttendanceModelFromJson(String str) => GetAttendanceModel.fromJson(json.decode(str));

class GetAttendanceModel {
  final bool? status;
  final List<Attendance>? attendance;

  GetAttendanceModel({
    this.status,
    this.attendance,
  });

  factory GetAttendanceModel.fromJson(Map<String, dynamic> json) => GetAttendanceModel(
    status: json["status"],
    attendance: json["attendance"] == null ? [] : List<Attendance>.from(json["attendance"]!.map((x) => Attendance.fromJson(x))),
  );
}

class Attendance {
  final String? id;
  final String? cleanerId;
  final String? date;
  final String? inTime;
  final String? outTime;
  final String? latitude;
  final String? longitude;
  final String? createdAt;
  final String? updatedAt;

  Attendance({
    this.id,
    this.cleanerId,
    this.date,
    this.inTime,
    this.outTime,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
    id: json["id"],
    cleanerId: json["cleaner_id"],
    date: json["date"],
    inTime: json["in_time"],
    outTime: json["out_time"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );
}
