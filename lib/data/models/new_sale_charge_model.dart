import 'dart:convert';

class NewSaleChargeModel {
  int chargeAmount;
  int chargeId;
  NewSaleChargeModel({
    required this.chargeAmount,
    required this.chargeId,
  });

  NewSaleChargeModel copyWith({
    int? chargeAmount,
    int? chargeId,
  }) {
    return NewSaleChargeModel(
      chargeAmount: chargeAmount ?? this.chargeAmount,
      chargeId: chargeId ?? this.chargeId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chargeAmount': chargeAmount,
      'chargeId': chargeId,
    };
  }

  factory NewSaleChargeModel.fromMap(Map<String, dynamic> map) {
    return NewSaleChargeModel(
      chargeAmount: map['chargeAmount']?.toInt() ?? 0,
      chargeId: map['chargeId']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory NewSaleChargeModel.fromJson(String source) =>
      NewSaleChargeModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'NewSaleChargeModel(chargeAmount: $chargeAmount, chargeId: $chargeId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewSaleChargeModel &&
        other.chargeAmount == chargeAmount &&
        other.chargeId == chargeId;
  }

  @override
  int get hashCode => chargeAmount.hashCode ^ chargeId.hashCode;
}
