// To parse this JSON data, do
//
//     final resendErrorResponse = resendErrorResponseFromJson(jsonString);

import 'dart:convert';

ResendErrorResponse resendErrorResponseFromJson(String str) => ResendErrorResponse.fromJson(json.decode(str));

String resendErrorResponseToJson(ResendErrorResponse data) => json.encode(data.toJson());

class ResendErrorResponse {
  bool? status;
  String? message;
  List<String>? data;

  ResendErrorResponse({
    this.status,
    this.message,
    this.data,
  });

  factory ResendErrorResponse.fromJson(Map<String, dynamic> json) => ResendErrorResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<String>.from(json["data"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
      };
}
