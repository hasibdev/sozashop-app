// To parse this JSON data, do
//
//     final sale = saleFromJson(jsonString);

import 'package:sozashop_app/data/models/batch_model.dart';
import 'package:sozashop_app/data/models/models_barrel.dart';
import 'package:sozashop_app/data/models/sale_model.dart';

class SaleItemModel {
  SaleItemModel({
    required this.id,
    required this.invoiceId,
    required this.productId,
    required this.batchId,
    required this.rate,
    required this.quantity,
    required this.discount,
    required this.discountType,
    required this.totalDiscount,
    required this.amount,
    required this.cost,
    required this.unitId,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.profit,
    required this.productName,
    required this.unitName,
    required this.purchaseRate,
    required this.sellingRate,
    required this.invoiceNo,
    required this.batch,
    required this.product,
    required this.unit,
    required this.invoice,
  });

  final int id;
  final int invoiceId;
  final int productId;
  final int batchId;
  final int rate;
  final int quantity;
  final num discount;
  final String discountType;
  final num totalDiscount;
  final num amount;
  final num cost;
  final int unitId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final num profit;
  final String productName;
  final String unitName;
  final num purchaseRate;
  final num sellingRate;
  final String invoiceNo;
  final BatchModel batch;
  final ProductModel product;
  final UnitModel unit;
  final SaleModel invoice;

  SaleItemModel copyWith({
    int? id,
    int? invoiceId,
    int? productId,
    int? batchId,
    int? rate,
    int? quantity,
    num? discount,
    String? discountType,
    num? totalDiscount,
    num? amount,
    num? cost,
    int? unitId,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    num? profit,
    String? productName,
    String? unitName,
    num? purchaseRate,
    num? sellingRate,
    String? invoiceNo,
    BatchModel? batch,
    ProductModel? product,
    UnitModel? unit,
    SaleModel? invoice,
  }) =>
      SaleItemModel(
        id: id ?? this.id,
        invoiceId: invoiceId ?? this.invoiceId,
        productId: productId ?? this.productId,
        batchId: batchId ?? this.batchId,
        rate: rate ?? this.rate,
        quantity: quantity ?? this.quantity,
        discount: discount ?? this.discount,
        discountType: discountType ?? this.discountType,
        totalDiscount: totalDiscount ?? this.totalDiscount,
        amount: amount ?? this.amount,
        cost: cost ?? this.cost,
        unitId: unitId ?? this.unitId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        profit: profit ?? this.profit,
        productName: productName ?? this.productName,
        unitName: unitName ?? this.unitName,
        purchaseRate: purchaseRate ?? this.purchaseRate,
        sellingRate: sellingRate ?? this.sellingRate,
        invoiceNo: invoiceNo ?? this.invoiceNo,
        batch: batch ?? this.batch,
        product: product ?? this.product,
        unit: unit ?? this.unit,
        invoice: invoice ?? this.invoice,
      );

  factory SaleItemModel.fromRawJson(String str) =>
      SaleItemModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SaleItemModel.fromJson(Map<String, dynamic> json) => SaleItemModel(
        id: json["id"],
        invoiceId: json["invoiceId"],
        productId: json["productId"],
        batchId: json["batchId"],
        rate: json["rate"],
        quantity: json["quantity"],
        discount: json["discount"],
        discountType: json["discountType"],
        totalDiscount: json["totalDiscount"],
        amount: json["amount"],
        cost: json["cost"],
        unitId: json["unitId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        profit: json["profit"],
        productName: json["productName"],
        unitName: json["unitName"],
        purchaseRate: json["purchaseRate"],
        sellingRate: json["sellingRate"],
        invoiceNo: json["invoiceNo"],
        batch: BatchModel.fromJson(json["batch"]),
        product: ProductModel.fromJson(json["product"]),
        unit: UnitModel.fromJson(json["unit"]),
        invoice: SaleModel.fromJson(json["invoice"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "invoiceId": invoiceId,
        "productId": productId,
        "batchId": batchId,
        "rate": rate,
        "quantity": quantity,
        "discount": discount,
        "discountType": discountType,
        "totalDiscount": totalDiscount,
        "amount": amount,
        "cost": cost,
        "unitId": unitId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
        "profit": profit,
        "productName": productName,
        "unitName": unitName,
        "purchaseRate": purchaseRate,
        "sellingRate": sellingRate,
        "invoiceNo": invoiceNo,
        "batch": batch.toJson(),
        "product": product.toJson(),
        "unit": unit.toJson(),
        "invoice": invoice.toJson(),
      };
}
