import 'dart:convert';

class Supplier {
  Supplier({
    required this.data,
  });

  final List<SupplierModel> data;

  Supplier copyWith({
    List<SupplierModel>? data,
  }) =>
      Supplier(
        data: data ?? this.data,
      );

  factory Supplier.fromRawJson(String str) =>
      Supplier.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Supplier.fromJson(Map<String, dynamic> json) => Supplier(
        data: List<SupplierModel>.from(
            json["data"].map((x) => SupplierModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SupplierModel {
  SupplierModel({
    required this.id,
    this.clientId,
    required this.name,
    required this.mobile,
    this.telephone,
    this.email,
    this.fax,
    this.vatNumber,
    this.openingBalance,
    this.totalAmount,
    this.paidAmount,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.purchaseInvoicesCount,
    this.totalDue,
    this.totalInvoice,
    this.totalPurchase,
  });

  final int id;
  final int? clientId;
  final String name;
  final String mobile;
  final String? telephone;
  final String? email;
  final String? fax;
  final String? vatNumber;
  final int? openingBalance;
  final int? totalAmount;
  final int? paidAmount;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final int? purchaseInvoicesCount;
  final int? totalDue;
  final int? totalInvoice;
  final int? totalPurchase;

  SupplierModel copyWith({
    int? id,
    int? clientId,
    String? name,
    String? mobile,
    String? telephone,
    String? email,
    String? fax,
    String? vatNumber,
    int? openingBalance,
    int? totalAmount,
    int? paidAmount,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    int? purchaseInvoicesCount,
    int? totalDue,
    int? totalInvoice,
    int? totalPurchase,
  }) =>
      SupplierModel(
        id: id ?? this.id,
        clientId: clientId ?? this.clientId,
        name: name ?? this.name,
        mobile: mobile ?? this.mobile,
        telephone: telephone ?? this.telephone,
        email: email ?? this.email,
        fax: fax ?? this.fax,
        vatNumber: vatNumber ?? this.vatNumber,
        openingBalance: openingBalance ?? this.openingBalance,
        totalAmount: totalAmount ?? this.totalAmount,
        paidAmount: paidAmount ?? this.paidAmount,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        purchaseInvoicesCount:
            purchaseInvoicesCount ?? this.purchaseInvoicesCount,
        totalDue: totalDue ?? this.totalDue,
        totalInvoice: totalInvoice ?? this.totalInvoice,
        totalPurchase: totalPurchase ?? this.totalPurchase,
      );

  factory SupplierModel.fromRawJson(String str) =>
      SupplierModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SupplierModel.fromJson(Map<String, dynamic> json) => SupplierModel(
        id: json["id"],
        clientId: json["clientId"],
        name: json["name"],
        mobile: json["mobile"],
        telephone: json["telephone"] ?? '',
        email: json["email"] ?? '',
        fax: json["fax"] ?? '',
        vatNumber: json["vatNumber"] ?? '',
        openingBalance: json["openingBalance"] ?? '',
        totalAmount: json["totalAmount"],
        paidAmount: json["paidAmount"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        purchaseInvoicesCount: json["purchaseInvoicesCount"],
        totalDue: json["totalDue"],
        totalInvoice: json["totalInvoice"],
        totalPurchase: json["totalPurchase"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "clientId": clientId,
        "name": name,
        "mobile": mobile,
        "telephone": telephone,
        "email": email,
        "fax": fax,
        "vatNumber": vatNumber,
        "openingBalance": openingBalance,
        "totalAmount": totalAmount,
        "paidAmount": paidAmount,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "purchaseInvoicesCount": purchaseInvoicesCount,
        "totalDue": totalDue,
        "totalInvoice": totalInvoice,
        "totalPurchase": totalPurchase,
      };
}
