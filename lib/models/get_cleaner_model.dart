import 'dart:convert';

GetCleanerModel getCleanerModelFromJson(String str) => GetCleanerModel.fromJson(json.decode(str));

class GetCleanerModel {
  final bool? status;
  final List<Cleaner>? cleaners;

  GetCleanerModel({
    this.status,
    this.cleaners,
  });

  factory GetCleanerModel.fromJson(Map<String, dynamic> json) => GetCleanerModel(
    status: json["status"],
    cleaners: json["cleaners"] == null ? [] : List<Cleaner>.from(json["cleaners"]!.map((x) => Cleaner.fromJson(x))),
  );
}

class Cleaner {
  final String? id;
  final String? name;

  Cleaner({
    this.id,
    this.name,
  });

  factory Cleaner.fromJson(Map<String, dynamic> json) => Cleaner(
    id: json["id"],
    name: json["name"],
  );
}
