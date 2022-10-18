import 'dart:convert';

class NewSaleItemModel {
  int? productId;
  int? batchId;
  dynamic rate;
  dynamic quantity;
  int? unitId;
  num? discount;
  String? discountType;
  num? amount;
  dynamic itemKey;

  NewSaleItemModel({
    this.productId,
    this.batchId,
    this.rate,
    this.quantity,
    this.unitId,
    this.discount,
    this.discountType,
    this.amount,
    this.itemKey,
  });

  NewSaleItemModel copyWith({
    int? productId,
    int? batchId,
    dynamic rate,
    dynamic quantity,
    int? unitId,
    num? discount,
    String? discountType,
    num? amount,
    dynamic itemKey,
  }) {
    return NewSaleItemModel(
      productId: productId ?? this.productId,
      batchId: batchId ?? this.batchId,
      rate: rate ?? this.rate,
      quantity: quantity ?? this.quantity,
      unitId: unitId ?? this.unitId,
      discount: discount ?? this.discount,
      discountType: discountType ?? this.discountType,
      amount: amount ?? this.amount,
      itemKey: itemKey ?? this.itemKey,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'batchId': batchId,
      'rate': rate,
      'quantity': quantity,
      'unitId': unitId,
      'discount': discount,
      'discountType': discountType,
      'amount': amount,
    };
  }

  factory NewSaleItemModel.fromMap(Map<String, dynamic> map) {
    return NewSaleItemModel(
      productId: map['productId']?.toInt(),
      batchId: map['batchId']?.toInt(),
      // ignore: unnecessary_null_in_if_null_operators
      rate: map['rate'] ?? null,
      // ignore: unnecessary_null_in_if_null_operators
      quantity: map['quantity'] ?? null,
      unitId: map['unitId']?.toInt(),
      discount: map['discount'],
      discountType: map['discountType'],
      amount: map['amount'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NewSaleItemModel.fromJson(String source) =>
      NewSaleItemModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NewSaleItemModal(productId: $productId, batchId: $batchId, rate: $rate, quantity: $quantity, unitId: $unitId, discount: $discount, discountType: $discountType, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewSaleItemModel &&
        other.productId == productId &&
        other.batchId == batchId &&
        other.rate == rate &&
        other.quantity == quantity &&
        other.unitId == unitId &&
        other.discount == discount &&
        other.discountType == discountType &&
        other.amount == amount;
  }

  @override
  int get hashCode {
    return productId.hashCode ^
        batchId.hashCode ^
        rate.hashCode ^
        quantity.hashCode ^
        unitId.hashCode ^
        discount.hashCode ^
        discountType.hashCode ^
        amount.hashCode;
  }
}
