import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

class LoginResponse {
  final bool? status;
  final String? message;
  final Cleanerdata? cleanerdata;

  LoginResponse({
    this.status,
    this.message,
    this.cleanerdata,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    status: json["status"],
    message: json["message"],
    cleanerdata: json["cleanerdata"] == null ? null : Cleanerdata.fromJson(json["cleanerdata"]),
  );
}

class Cleanerdata {
  final String? id;
  final String? name;
  final String? mobile;
  final String? password;
  final String? token;
  final String? lastloginIp;
  final DateTime? lastlogin;
  final String? status;
  final DateTime? dateAdded;

  Cleanerdata({
    this.id,
    this.name,
    this.mobile,
    this.password,
    this.token,
    this.lastloginIp,
    this.lastlogin,
    this.status,
    this.dateAdded,
  });

  factory Cleanerdata.fromJson(Map<String, dynamic> json) => Cleanerdata(
    id: json["id"],
    name: json["name"],
    mobile: json["mobile"],
    password: json["password"],
    token: json["token"],
    lastloginIp: json["lastlogin_ip"],
    lastlogin: json["lastlogin"] == null ? null : DateTime.parse(json["lastlogin"]),
    status: json["status"],
    dateAdded: json["date_added"] == null ? null : DateTime.parse(json["date_added"]),
  );
}
