// To parse this JSON data, do
//
//     final studentLoginResponse = studentLoginResponseFromJson(jsonString);

import 'dart:convert';

UserLoginResponse studentLoginResponseFromJson(String str) =>
    UserLoginResponse.fromJson(json.decode(str));

String studentLoginResponseToJson(UserLoginResponse data) =>
    json.encode(data.toJson());

class UserLoginResponse {
  bool? status;
  String? message;
  Data? data;

  UserLoginResponse({
    this.status,
    this.message,
    this.data,
  });

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) =>
      UserLoginResponse(
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
  int? id;
  dynamic name;
  dynamic email;
  int? countryId;
  String? phone;
  dynamic phoneVerifiedAt;
  dynamic avatar;
  dynamic approvedAt;
  dynamic detailsType;
  dynamic detailsId;
  int? profileStatusId;
  int? reviewCount;
  String? reviewRating;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.name,
    this.email,
    this.countryId,
    this.phone,
    this.phoneVerifiedAt,
    this.avatar,
    this.approvedAt,
    this.detailsType,
    this.detailsId,
    this.profileStatusId,
    this.reviewCount,
    this.reviewRating,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        countryId: json["country_id"],
        phone: json["phone"],
        phoneVerifiedAt: json["phone_verified_at"],
        avatar: json["avatar"],
        approvedAt: json["approved_at"],
        detailsType: json["details_type"],
        detailsId: json["details_id"],
        profileStatusId: json["profile_status_id"],
        reviewCount: json["review_count"],
        reviewRating: json["review_rating"],
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
        "email": email,
        "country_id": countryId,
        "phone": phone,
        "phone_verified_at": phoneVerifiedAt,
        "avatar": avatar,
        "approved_at": approvedAt,
        "details_type": detailsType,
        "details_id": detailsId,
        "profile_status_id": profileStatusId,
        "review_count": reviewCount,
        "review_rating": reviewRating,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
