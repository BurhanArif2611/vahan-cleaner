import 'dart:convert';

AddVahanResponse addVahanResponseFromJson(String str) => AddVahanResponse.fromJson(json.decode(str));

class AddVahanResponse {
  final bool? status;
  final String? message;

  AddVahanResponse({
    this.status,
    this.message,
  });

  factory AddVahanResponse.fromJson(Map<String, dynamic> json) => AddVahanResponse(
    status: json["status"],
    message: json["message"],
  );
}
