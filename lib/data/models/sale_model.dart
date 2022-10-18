import 'dart:convert';

import 'package:sozashop_app/data/models/charge_model.dart';
import 'package:sozashop_app/data/models/customer_model.dart';
import 'package:sozashop_app/data/models/models_barrel.dart';
import 'package:sozashop_app/data/models/payment_model.dart';
import 'package:sozashop_app/data/models/sale_item_model.dart';
import 'package:sozashop_app/data/models/user_model.dart';

class Sale {
  Sale({
    required this.data,
  });

  final List<SaleModel> data;

  Sale copyWith({
    List<SaleModel>? data,
  }) =>
      Sale(
        data: data ?? this.data,
      );

  factory Sale.fromRawJson(String str) => Sale.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Sale.fromJson(Map<String, dynamic> json) => Sale(
        data: List<SaleModel>.from(
            json["data"].map((x) => SaleModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SaleModel {
  SaleModel({
    required this.id,
    required this.invoiceNo,
    required this.clientId,
    required this.customerId,
    required this.date,
    required this.dueDate,
    required this.totalDiscount,
    required this.totalCharge,
    required this.totalCost,
    required this.totalAmount,
    required this.grandTotal,
    required this.paidAmount,
    required this.note,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.returnInvoicesCount,
    required this.createdAtFormatted,
    required this.customerName,
    required this.totalDue,
    required this.profit,
    required this.dueDateFormatted,
    required this.invoiceDateFormatted,
    required this.updatedAtFormatted,
    required this.clientName,
    required this.shopName,
    required this.creator,
    required this.user,
    required this.customer,
    required this.charges,
    required this.saleItems,
    required this.payments,
  });

  final int id;
  final String invoiceNo;
  final int clientId;
  final int customerId;
  final DateTime date;
  final DateTime dueDate;
  final num totalDiscount;
  final num totalCharge;
  final num totalCost;
  final num totalAmount;
  final num grandTotal;
  final num paidAmount;
  final dynamic note;
  final String status;
  final int createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final int returnInvoicesCount;
  final String createdAtFormatted;
  final String customerName;
  final num totalDue;
  final num profit;
  final String dueDateFormatted;
  final String invoiceDateFormatted;
  final String updatedAtFormatted;
  final String clientName;
  final String shopName;
  final String creator;
  final UserModel user;
  final CustomerModel customer;
  final List<ChargeModel>? charges;
  final List<SaleItemModel>? saleItems;
  final List<PaymentModel>? payments;

  SaleModel copyWith({
    int? id,
    String? invoiceNo,
    int? clientId,
    int? customerId,
    DateTime? date,
    DateTime? dueDate,
    num? totalDiscount,
    num? totalCharge,
    num? totalCost,
    num? totalAmount,
    num? grandTotal,
    num? paidAmount,
    dynamic note,
    String? status,
    int? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    int? returnInvoicesCount,
    String? createdAtFormatted,
    String? customerName,
    num? totalDue,
    num? profit,
    String? dueDateFormatted,
    String? invoiceDateFormatted,
    String? updatedAtFormatted,
    String? clientName,
    String? shopName,
    String? creator,
    UserModel? user,
    CustomerModel? customer,
    List<ChargeModel>? charges,
    List<SaleItemModel>? saleItems,
    List<PaymentModel>? payments,
  }) =>
      SaleModel(
        id: id ?? this.id,
        invoiceNo: invoiceNo ?? this.invoiceNo,
        clientId: clientId ?? this.clientId,
        customerId: customerId ?? this.customerId,
        date: date ?? this.date,
        dueDate: dueDate ?? this.dueDate,
        totalDiscount: totalDiscount ?? this.totalDiscount,
        totalCharge: totalCharge ?? this.totalCharge,
        totalCost: totalCost ?? this.totalCost,
        totalAmount: totalAmount ?? this.totalAmount,
        grandTotal: grandTotal ?? this.grandTotal,
        paidAmount: paidAmount ?? this.paidAmount,
        note: note ?? this.note,
        status: status ?? this.status,
        createdBy: createdBy ?? this.createdBy,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        returnInvoicesCount: returnInvoicesCount ?? this.returnInvoicesCount,
        createdAtFormatted: createdAtFormatted ?? this.createdAtFormatted,
        customerName: customerName ?? this.customerName,
        totalDue: totalDue ?? this.totalDue,
        profit: profit ?? this.profit,
        dueDateFormatted: dueDateFormatted ?? this.dueDateFormatted,
        invoiceDateFormatted: invoiceDateFormatted ?? this.invoiceDateFormatted,
        updatedAtFormatted: updatedAtFormatted ?? this.updatedAtFormatted,
        clientName: clientName ?? this.clientName,
        shopName: shopName ?? this.shopName,
        creator: creator ?? this.creator,
        user: user ?? this.user,
        customer: customer ?? this.customer,
        charges: charges ?? this.charges,
        saleItems: saleItems ?? this.saleItems,
        payments: payments ?? this.payments,
      );

  factory SaleModel.fromRawJson(String str) =>
      SaleModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SaleModel.fromJson(Map<String, dynamic> json) => SaleModel(
        id: json["id"],
        invoiceNo: json["invoiceNo"],
        clientId: json["clientId"],
        customerId: json["customerId"],
        date: DateTime.parse(json["date"]),
        dueDate: DateTime.parse(json["dueDate"]),
        totalDiscount: json["totalDiscount"],
        totalCharge: json["totalCharge"],
        totalCost: json["totalCost"],
        totalAmount: json["totalAmount"],
        grandTotal: json["grandTotal"],
        paidAmount: json["paidAmount"],
        note: json["note"],
        status: json["status"],
        createdBy: json["createdBy"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        returnInvoicesCount: json["returnInvoicesCount"],
        createdAtFormatted: json["createdAtFormatted"],
        customerName: json["customerName"],
        totalDue: json["totalDue"],
        profit: json["profit"],
        dueDateFormatted: json["dueDateFormatted"],
        invoiceDateFormatted: json["invoiceDateFormatted"],
        updatedAtFormatted: json["updatedAtFormatted"],
        clientName: json["clientName"],
        shopName: json["shopName"],
        creator: json["creator"],
        user: UserModel.fromJson(json["user"]),
        customer: CustomerModel.fromJson(json["customer"]),
        charges: json["charges"] == null
            ? null
            : List<ChargeModel>.from(
                json["charges"].map((x) => ChargeModel.fromJson(x))),
        saleItems: json["saleItems"] == null
            ? null
            : List<SaleItemModel>.from(
                json["saleItems"].map((x) => SaleItemModel.fromJson(x))),
        payments: json["payments"] == null
            ? null
            : List<PaymentModel>.from(
                json["payments"].map((x) => PaymentModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "invoiceNo": invoiceNo,
        "clientId": clientId,
        "customerId": customerId,
        "date": date.toIso8601String(),
        "dueDate": dueDate.toIso8601String(),
        "totalDiscount": totalDiscount,
        "totalCharge": totalCharge,
        "totalCost": totalCost,
        "totalAmount": totalAmount,
        "grandTotal": grandTotal,
        "paidAmount": paidAmount,
        "note": note,
        "status": status,
        "createdBy": createdBy,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
        "returnInvoicesCount": returnInvoicesCount,
        "createdAtFormatted": createdAtFormatted,
        "customerName": customerName,
        "totalDue": totalDue,
        "profit": profit,
        "dueDateFormatted": dueDateFormatted,
        "invoiceDateFormatted": invoiceDateFormatted,
        "updatedAtFormatted": updatedAtFormatted,
        "clientName": clientName,
        "shopName": shopName,
        "creator": creator,
        "user": user.toJson(),
        "customer": customer.toJson(),
        "charges": charges == null
            ? null
            : List<dynamic>.from(charges!.map((x) => x.toJson())),
        "saleItems": saleItems == null
            ? null
            : List<dynamic>.from(saleItems!.map((x) => x.toJson())),
        "payments": payments == null
            ? null
            : List<dynamic>.from(payments!.map((x) => x.toJson())),
      };
}
