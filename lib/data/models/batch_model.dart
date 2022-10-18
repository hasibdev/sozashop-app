import 'package:sozashop_app/data/models/models_barrel.dart';

class Batch {
  Batch({
    required this.data,
  });

  final List<BatchModel> data;

  Batch copyWith({
    List<BatchModel>? data,
  }) =>
      Batch(
        data: data ?? this.data,
      );

  factory Batch.fromRawJson(String str) => Batch.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Batch.fromJson(Map<String, dynamic> json) => Batch(
        data: List<BatchModel>.from(
            json["data"].map((x) => BatchModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class BatchModel {
  BatchModel({
    required this.id,
    required this.clientId,
    required this.productId,
    required this.name,
    required this.purchaseRate,
    required this.sellingRate,
    required this.quantity,
    required this.totalPurchaseRate,
    required this.totalSellingRate,
    required this.unitId,
    required this.mfgDate,
    required this.expDate,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.unitName,
    required this.productName,
    required this.productColor,
    required this.productCode,
    required this.categoryName,
    required this.totalSale,
    required this.totalCost,
    required this.profit,
    required this.unit,
    required this.product,
  });

  final int id;
  final int clientId;
  final int productId;
  final String name;
  final num purchaseRate;
  final num sellingRate;
  final num quantity;
  final num totalPurchaseRate;
  final num totalSellingRate;
  final int unitId;
  final dynamic mfgDate;
  final dynamic expDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final String unitName;
  final String productName;
  final dynamic productColor;
  final dynamic productCode;
  final String categoryName;
  final num totalSale;
  final num totalCost;
  final num profit;
  final UnitModel unit;
  final ProductModel product;

  BatchModel copyWith({
    int? id,
    int? clientId,
    int? productId,
    String? name,
    num? purchaseRate,
    num? sellingRate,
    num? quantity,
    num? totalPurchaseRate,
    num? totalSellingRate,
    int? unitId,
    dynamic mfgDate,
    dynamic expDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    String? unitName,
    String? productName,
    dynamic productColor,
    dynamic productCode,
    String? categoryName,
    num? totalSale,
    num? totalCost,
    num? profit,
    UnitModel? unit,
    ProductModel? product,
  }) =>
      BatchModel(
        id: id ?? this.id,
        clientId: clientId ?? this.clientId,
        productId: productId ?? this.productId,
        name: name ?? this.name,
        purchaseRate: purchaseRate ?? this.purchaseRate,
        sellingRate: sellingRate ?? this.sellingRate,
        quantity: quantity ?? this.quantity,
        totalPurchaseRate: totalPurchaseRate ?? this.totalPurchaseRate,
        totalSellingRate: totalSellingRate ?? this.totalSellingRate,
        unitId: unitId ?? this.unitId,
        mfgDate: mfgDate ?? this.mfgDate,
        expDate: expDate ?? this.expDate,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        unitName: unitName ?? this.unitName,
        productName: productName ?? this.productName,
        productColor: productColor ?? this.productColor,
        productCode: productCode ?? this.productCode,
        categoryName: categoryName ?? this.categoryName,
        totalSale: totalSale ?? this.totalSale,
        totalCost: totalCost ?? this.totalCost,
        profit: profit ?? this.profit,
        unit: unit ?? this.unit,
        product: product ?? this.product,
      );

  factory BatchModel.fromRawJson(String str) =>
      BatchModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BatchModel.fromJson(Map<String, dynamic> json) => BatchModel(
        id: json["id"],
        clientId: json["clientId"],
        productId: json["productId"],
        name: json["name"],
        purchaseRate: json["purchaseRate"],
        sellingRate: json["sellingRate"],
        quantity: json["quantity"],
        totalPurchaseRate: json["totalPurchaseRate"],
        totalSellingRate: json["totalSellingRate"],
        unitId: json["unitId"],
        mfgDate: json["mfgDate"],
        expDate: json["expDate"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        unitName: json["unitName"],
        productName: json["productName"],
        productColor: json["productColor"],
        productCode: json["productCode"],
        categoryName: json["categoryName"],
        totalSale: json["totalSale"],
        totalCost: json["totalCost"],
        profit: json["profit"],
        unit: UnitModel.fromJson(json["unit"]),
        product: ProductModel.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "clientId": clientId,
        "productId": productId,
        "name": name,
        "purchaseRate": purchaseRate,
        "sellingRate": sellingRate,
        "quantity": quantity,
        "totalPurchaseRate": totalPurchaseRate,
        "totalSellingRate": totalSellingRate,
        "unitId": unitId,
        "mfgDate": mfgDate,
        "expDate": expDate,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
        "unitName": unitName,
        "productName": productName,
        "productColor": productColor,
        "productCode": productCode,
        "categoryName": categoryName,
        "totalSale": totalSale,
        "totalCost": totalCost,
        "profit": profit,
        "unit": unit.toJson(),
        "product": product.toJson(),
      };
}
