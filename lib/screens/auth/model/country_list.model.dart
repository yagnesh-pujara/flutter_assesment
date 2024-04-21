// To parse this JSON data, do
//
//     final countryList = countryListFromJson(jsonString);

import 'dart:convert';

CountryListResponse countryListFromJson(String str) =>
    CountryListResponse.fromJson(json.decode(str));

String countryListToJson(CountryListResponse data) =>
    json.encode(data.toJson());

class CountryListResponse {
  bool? status;
  String? message;
  List<Country>? data;

  CountryListResponse({
    this.status,
    this.message,
    this.data,
  });

  factory CountryListResponse.fromJson(Map<String, dynamic> json) =>
      CountryListResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Country>.from(json["data"]!.map((x) => Country.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Country {
  int? id;
  String? name;
  String? code;
  String? telCode;
  String? timezone;
  String? flag;
  DateTime? createdAt;
  DateTime? updatedAt;

  Country({
    this.id,
    this.name,
    this.code,
    this.telCode,
    this.timezone,
    this.flag,
    this.createdAt,
    this.updatedAt,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        telCode: json["tel_code"],
        timezone: json["timezone"],
        flag: json["flag"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "tel_code": telCode,
        "timezone": timezone,
        "flag": flag,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
