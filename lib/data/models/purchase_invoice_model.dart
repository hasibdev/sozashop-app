// To parse this JSON data, do
//
//     final purchaseInvoice = purchaseInvoiceFromJson(jsonString);

import 'package:sozashop_app/data/models/supplier_model.dart';
import 'package:sozashop_app/data/models/user_model.dart';

import 'models_barrel.dart';

class PurchaseInvoice {
  PurchaseInvoice({
    required this.data,
  });

  final List<PurchaseInvoiceModel>? data;

  PurchaseInvoice copyWith({
    List<PurchaseInvoiceModel>? data,
  }) =>
      PurchaseInvoice(
        data: data ?? this.data,
      );

  factory PurchaseInvoice.fromRawJson(String str) =>
      PurchaseInvoice.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PurchaseInvoice.fromJson(Map<String, dynamic> json) =>
      PurchaseInvoice(
        data: List<PurchaseInvoiceModel>.from(
            json["data"].map((x) => PurchaseInvoiceModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class PurchaseInvoiceModel {
  PurchaseInvoiceModel({
    required this.id,
    required this.clientId,
    required this.supplierId,
    required this.invoiceNo,
    required this.date,
    required this.totalAmount,
    required this.paidAmount,
    required this.note,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.supplierName,
    required this.totalDue,
    required this.totalSellingAmount,
    required this.profit,
    required this.creator,
    required this.purchaseItems,
    required this.user,
    required this.supplier,
  });

  final int id;
  final int clientId;
  final int supplierId;
  final String invoiceNo;
  final String date;
  final int totalAmount;
  final int paidAmount;
  final dynamic note;
  final String status;
  final int createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final String supplierName;
  final int totalDue;
  final int totalSellingAmount;
  final int profit;
  final String creator;
  final List<dynamic> purchaseItems;
  final UserModel user;
  final SupplierModel supplier;

  PurchaseInvoiceModel copyWith({
    int? id,
    int? clientId,
    int? supplierId,
    String? invoiceNo,
    String? date,
    int? totalAmount,
    int? paidAmount,
    dynamic note,
    String? status,
    int? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    String? supplierName,
    int? totalDue,
    int? totalSellingAmount,
    int? profit,
    String? creator,
    List<dynamic>? purchaseItems,
    UserModel? user,
    SupplierModel? supplier,
  }) =>
      PurchaseInvoiceModel(
        id: id ?? this.id,
        clientId: clientId ?? this.clientId,
        supplierId: supplierId ?? this.supplierId,
        invoiceNo: invoiceNo ?? this.invoiceNo,
        date: date ?? this.date,
        totalAmount: totalAmount ?? this.totalAmount,
        paidAmount: paidAmount ?? this.paidAmount,
        note: note ?? this.note,
        status: status ?? this.status,
        createdBy: createdBy ?? this.createdBy,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        supplierName: supplierName ?? this.supplierName,
        totalDue: totalDue ?? this.totalDue,
        totalSellingAmount: totalSellingAmount ?? this.totalSellingAmount,
        profit: profit ?? this.profit,
        creator: creator ?? this.creator,
        purchaseItems: purchaseItems ?? this.purchaseItems,
        user: user ?? this.user,
        supplier: supplier ?? this.supplier,
      );

  factory PurchaseInvoiceModel.fromRawJson(String str) =>
      PurchaseInvoiceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PurchaseInvoiceModel.fromJson(Map<String, dynamic> json) =>
      PurchaseInvoiceModel(
        id: json["id"],
        clientId: json["clientId"],
        supplierId: json["supplierId"],
        invoiceNo: json["invoiceNo"],
        date: json["date"],
        totalAmount: json["totalAmount"],
        paidAmount: json["paidAmount"],
        note: json["note"],
        status: json["status"],
        createdBy: json["createdBy"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        supplierName: json["supplierName"],
        totalDue: json["totalDue"],
        totalSellingAmount: json["totalSellingAmount"],
        profit: json["profit"],
        creator: json["creator"],
        purchaseItems: List<dynamic>.from(json["purchaseItems"].map((x) => x)),
        user: UserModel.fromJson(json["user"]),
        supplier: SupplierModel.fromJson(json["supplier"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "clientId": clientId,
        "supplierId": supplierId,
        "invoiceNo": invoiceNo,
        "date": date,
        "totalAmount": totalAmount,
        "paidAmount": paidAmount,
        "note": note,
        "status": status,
        "createdBy": createdBy,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
        "supplierName": supplierName,
        "totalDue": totalDue,
        "totalSellingAmount": totalSellingAmount,
        "profit": profit,
        "creator": creator,
        "purchaseItems": List<dynamic>.from(purchaseItems.map((x) => x)),
        "user": user.toJson(),
        "supplier": supplier.toJson(),
      };
}
