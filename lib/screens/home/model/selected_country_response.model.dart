// To parse this JSON data, do
//
//     final selectedCountryResponse = selectedCountryResponseFromJson(jsonString);

import 'dart:convert';

SelectedCountryResponse selectedCountryResponseFromJson(String str) => SelectedCountryResponse.fromJson(json.decode(str));

String selectedCountryResponseToJson(SelectedCountryResponse data) => json.encode(data.toJson());

class SelectedCountryResponse {
  bool? status;
  String? message;
  Data? data;

  SelectedCountryResponse({
    this.status,
    this.message,
    this.data,
  });

  factory SelectedCountryResponse.fromJson(Map<String, dynamic> json) => SelectedCountryResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  String? profileStatus;
  String? role;
  String? selectedCountry;

  Data({
    this.profileStatus,
    this.role,
    this.selectedCountry,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        profileStatus: json["profile_status"],
        role: json["role"],
        selectedCountry: json["selected_country"],
      );

  Map<String, dynamic> toJson() => {
        "profile_status": profileStatus,
        "role": role,
        "selected_country": selectedCountry,
      };
}
