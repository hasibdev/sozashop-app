import 'dart:convert';

class ProductPivotModel {
  ProductPivotModel({
    required this.productId,
    required this.unitId,
  });

  final int productId;
  final int unitId;

  ProductPivotModel copyWith({
    int? productId,
    int? unitId,
  }) =>
      ProductPivotModel(
        productId: productId ?? this.productId,
        unitId: unitId ?? this.unitId,
      );

  factory ProductPivotModel.fromRawJson(String str) =>
      ProductPivotModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductPivotModel.fromJson(Map<String, dynamic> json) =>
      ProductPivotModel(
        productId: json["product_id"],
        unitId: json["unit_id"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "unit_id": unitId,
      };
}
