import 'dart:convert';

MarkInAttendanceModel markInAttendanceModelFromJson(String str) => MarkInAttendanceModel.fromJson(json.decode(str));

String markInAttendanceModelToJson(MarkInAttendanceModel data) => json.encode(data.toJson());

class MarkInAttendanceModel {
  final bool? status;
  final String? message;

  MarkInAttendanceModel({
    this.status,
    this.message,
  });

  factory MarkInAttendanceModel.fromJson(Map<String, dynamic> json) => MarkInAttendanceModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}