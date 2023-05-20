// To parse this JSON data, do
//
//     final companyListResponse = companyListResponseFromJson(jsonString);

import 'dart:convert';

CompanyListResponse companyListResponseFromJson(String str) => CompanyListResponse.fromJson(json.decode(str));

String companyListResponseToJson(CompanyListResponse data) => json.encode(data.toJson());

class CompanyListResponse {
  String? statusCode;
  String? statusMessage;
  CompanyList? companyList;

  CompanyListResponse({
    this.statusCode,
    this.statusMessage,
    this.companyList,
  });

  factory CompanyListResponse.fromJson(Map<String, dynamic> json) => CompanyListResponse(
    statusCode: json["status_code"],
    statusMessage: json["status_message"],
    companyList: json["company_list"] == null ? null : CompanyList.fromJson(json["company_list"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "status_message": statusMessage,
    "company_list": companyList?.toJson(),
  };
}

class CompanyList {
  int? currentPage;
  List<CompanyItemModel>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  CompanyList({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory CompanyList.fromJson(Map<String, dynamic> json) => CompanyList(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<CompanyItemModel>.from(json["data"]!.map((x) => CompanyItemModel.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class CompanyItemModel {
  int? id;
  String? companyName;
  String? email;
  String? password;
  String? phone;
  DateTime? createdAt;
  DateTime? updatedAt;

  CompanyItemModel({
    this.id,
    this.companyName,
    this.email,
    this.password,
    this.phone,
    this.createdAt,
    this.updatedAt,
  });

  factory CompanyItemModel.fromJson(Map<String, dynamic> json) => CompanyItemModel(
    id: json["id"],
    companyName: json["company_name"],
    email: json["email"],
    password: json["password"],
    phone: json["phone"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "company_name": companyName,
    "email": email,
    "password": password,
    "phone": phone,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
