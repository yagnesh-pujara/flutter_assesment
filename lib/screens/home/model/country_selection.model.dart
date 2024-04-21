// To parse this JSON data, do
//
//     final selectCountryResponse = selectCountryResponseFromJson(jsonString);

import 'dart:convert';

SelectCountryResponse selectCountryResponseFromJson(String str) =>
    SelectCountryResponse.fromJson(json.decode(str));

String selectCountryResponseToJson(SelectCountryResponse data) =>
    json.encode(data.toJson());

class SelectCountryResponse {
  bool? status;
  String? message;
  Data? data;

  SelectCountryResponse({
    this.status,
    this.message,
    this.data,
  });

  factory SelectCountryResponse.fromJson(Map<String, dynamic> json) =>
      SelectCountryResponse(
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
  dynamic selectedCountry;
  List<Country>? countries;

  Data({
    this.profileStatus,
    this.role,
    this.selectedCountry,
    this.countries,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        profileStatus: json["profile_status"],
        role: json["role"],
        selectedCountry: json["selected_country"],
        countries: json["countries"] == null
            ? []
            : List<Country>.from(
                json["countries"]!.map((x) => Country.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "profile_status": profileStatus,
        "role": role,
        "selected_country": selectedCountry,
        "countries": countries == null
            ? []
            : List<dynamic>.from(countries!.map((x) => x.toJson())),
      };
}

class Country {
  int? id;
  String? name;
  String? flag;
  String? image;

  Country({
    this.id,
    this.name,
    this.flag,
    this.image,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        name: json["name"],
        flag: json["flag"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "flag": flag,
        "image": image,
      };
}
