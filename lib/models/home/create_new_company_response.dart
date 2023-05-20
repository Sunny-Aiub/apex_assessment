// To parse this JSON data, do
//
//     final createNewCompanyResponse = createNewCompanyResponseFromJson(jsonString);

import 'dart:convert';

CreateNewCompanyResponse createNewCompanyResponseFromJson(String str) => CreateNewCompanyResponse.fromJson(json.decode(str));

String createNewCompanyResponseToJson(CreateNewCompanyResponse data) => json.encode(data.toJson());

class CreateNewCompanyResponse {
  String? statusCode;
  String? statusMessage;

  CreateNewCompanyResponse({
    this.statusCode,
    this.statusMessage,
  });

  factory CreateNewCompanyResponse.fromJson(Map<String, dynamic> json) => CreateNewCompanyResponse(
    statusCode: json["status_code"],
    statusMessage: json["status_message"],
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "status_message": statusMessage,
  };
}
