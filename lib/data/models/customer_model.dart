import 'dart:convert';

class CustomerModel {
  CustomerModel({
    required this.id,
    required this.clientId,
    required this.name,
    required this.mobile,
    required this.password,
    required this.email,
    required this.address,
    required this.openingBalance,
    required this.totalAmount,
    required this.paidAmount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.totalDue,
    required this.clientName,
    required this.shopName,
  });

  final int id;
  final int clientId;
  final String name;
  final dynamic mobile;
  final dynamic password;
  final dynamic email;
  final dynamic address;
  final num openingBalance;
  final num totalAmount;
  final num paidAmount;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final num totalDue;
  final String clientName;
  final String shopName;

  CustomerModel copyWith({
    int? id,
    int? clientId,
    String? name,
    dynamic mobile,
    dynamic password,
    dynamic email,
    dynamic address,
    num? openingBalance,
    num? totalAmount,
    num? paidAmount,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    num? totalDue,
    String? clientName,
    String? shopName,
  }) =>
      CustomerModel(
        id: id ?? this.id,
        clientId: clientId ?? this.clientId,
        name: name ?? this.name,
        mobile: mobile ?? this.mobile,
        password: password ?? this.password,
        email: email ?? this.email,
        address: address ?? this.address,
        openingBalance: openingBalance ?? this.openingBalance,
        totalAmount: totalAmount ?? this.totalAmount,
        paidAmount: paidAmount ?? this.paidAmount,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        totalDue: totalDue ?? this.totalDue,
        clientName: clientName ?? this.clientName,
        shopName: shopName ?? this.shopName,
      );

  factory CustomerModel.fromRawJson(String str) =>
      CustomerModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
        id: json["id"],
        clientId: json["clientId"],
        name: json["name"],
        mobile: json["mobile"],
        password: json["password"],
        email: json["email"],
        address: json["address"],
        openingBalance: json["openingBalance"],
        totalAmount: json["totalAmount"],
        paidAmount: json["paidAmount"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        totalDue: json["totalDue"],
        clientName: json["clientName"],
        shopName: json["shopName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "clientId": clientId,
        "name": name,
        "mobile": mobile,
        "password": password,
        "email": email,
        "address": address,
        "openingBalance": openingBalance,
        "totalAmount": totalAmount,
        "paidAmount": paidAmount,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
        "totalDue": totalDue,
        "clientName": clientName,
        "shopName": shopName,
      };
}
