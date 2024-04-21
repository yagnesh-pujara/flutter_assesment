// To parse this JSON data, do
//
//     final verifyOtpResponse = verifyOtpResponseFromJson(jsonString);

import 'dart:convert';

VerifyOtpResponse verifyOtpResponseFromJson(String str) =>
    VerifyOtpResponse.fromJson(json.decode(str));

String verifyOtpResponseToJson(VerifyOtpResponse data) =>
    json.encode(data.toJson());

class VerifyOtpResponse {
  bool? status;
  String? message;
  Data? data;

  VerifyOtpResponse({
    this.status,
    this.message,
    this.data,
  });

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) =>
      VerifyOtpResponse(
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
  String? phone;
  DateTime? phoneVerifiedAt;
  String? accessToken;
  String? tokenType;
  int? expiresIn;

  Data({
    this.profileStatus,
    this.role,
    this.phone,
    this.phoneVerifiedAt,
    this.accessToken,
    this.tokenType,
    this.expiresIn,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        profileStatus: json["profile_status"],
        role: json["role"],
        phone: json["phone"],
        phoneVerifiedAt: json["phone_verified_at"] == null
            ? null
            : DateTime.parse(json["phone_verified_at"]),
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
      );

  Map<String, dynamic> toJson() => {
        "profile_status": profileStatus,
        "role": role,
        "phone": phone,
        "phone_verified_at": phoneVerifiedAt?.toIso8601String(),
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_in": expiresIn,
      };
}
