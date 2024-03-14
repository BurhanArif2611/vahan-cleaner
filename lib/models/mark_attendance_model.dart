import 'dart:convert';

MarkAttendanceModel markAttendanceModelFromJson(String str) => MarkAttendanceModel.fromJson(json.decode(str));

String markAttendanceModelToJson(MarkAttendanceModel data) => json.encode(data.toJson());

class MarkAttendanceModel {
  final bool? status;
  final String? message;

  MarkAttendanceModel({
    this.status,
    this.message,
  });

  factory MarkAttendanceModel.fromJson(Map<String, dynamic> json) => MarkAttendanceModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}