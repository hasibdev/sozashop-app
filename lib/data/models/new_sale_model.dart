import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:sozashop_app/data/models/new_sale_charge_model.dart';
import 'package:sozashop_app/data/models/new_sale_item_model.dart';

class NewSaleModel {
  List<NewSaleChargeModel> charges;
  int customerId;
  DateTime? date;
  DateTime? dueDate;
  String? discountType;
  String? paidAmount;
  String? paymentMethod;
  String? note;
  num? totalDiscount;
  List<NewSaleItemModel> saleItems;
  NewSaleModel({
    required this.charges,
    required this.customerId,
    this.date,
    this.dueDate,
    this.discountType,
    this.paidAmount,
    this.paymentMethod,
    this.totalDiscount,
    this.note,
    required this.saleItems,
  });

  NewSaleModel copyWith({
    List<NewSaleChargeModel>? charges,
    int? customerId,
    DateTime? date,
    DateTime? dueDate,
    String? discountType,
    String? paidAmount,
    String? paymentMethod,
    String? note,
    int? totalDiscount,
    List<NewSaleItemModel>? saleItems,
  }) {
    return NewSaleModel(
      charges: charges ?? this.charges,
      customerId: customerId ?? this.customerId,
      date: date ?? this.date,
      dueDate: dueDate ?? this.dueDate,
      discountType: discountType ?? this.discountType,
      paidAmount: paidAmount ?? this.paidAmount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      totalDiscount: totalDiscount ?? this.totalDiscount,
      note: note ?? this.note,
      saleItems: saleItems ?? this.saleItems,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'charges': charges.map((x) => x.toMap()).toList(),
      'customerId': customerId,
      'date': date?.millisecondsSinceEpoch,
      'dueDate': dueDate?.millisecondsSinceEpoch,
      'discountType': discountType,
      'note': note,
      'paidAmount': paidAmount,
      'paymentMethod': paymentMethod,
      'totalDiscount': totalDiscount,
      'saleItems': saleItems.map((x) => x.toMap()).toList(),
    };
  }

  factory NewSaleModel.fromMap(Map<String, dynamic> map) {
    return NewSaleModel(
      charges: List<NewSaleChargeModel>.from(
          map['charges']?.map((x) => NewSaleChargeModel.fromMap(x))),
      customerId: map['customerId']?.toInt() ?? 0,
      date: map['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['date'])
          : null,
      dueDate: map['dueDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dueDate'])
          : null,
      discountType: map['discountType'],
      paidAmount: map['paidAmount'],
      paymentMethod: map['paymentMethod'],
      note: map['note'],
      totalDiscount: map['totalDiscount']?.toInt(),
      saleItems: List<NewSaleItemModel>.from(
          map['saleItems']?.map((x) => NewSaleItemModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory NewSaleModel.fromJson(String source) =>
      NewSaleModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NewSaleModel(charges: $charges, customerId: $customerId, date: $date, dueDate: $dueDate, discountType: $discountType, paidAmount: $paidAmount, paymentMethod: $paymentMethod, note: $note, totalDiscount: $totalDiscount, saleItems: $saleItems)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewSaleModel &&
        listEquals(other.charges, charges) &&
        other.customerId == customerId &&
        other.date == date &&
        other.dueDate == dueDate &&
        other.discountType == discountType &&
        other.note == note &&
        other.paidAmount == paidAmount &&
        other.paymentMethod == paymentMethod &&
        other.totalDiscount == totalDiscount &&
        listEquals(other.saleItems, saleItems);
  }

  @override
  int get hashCode {
    return charges.hashCode ^
        customerId.hashCode ^
        date.hashCode ^
        dueDate.hashCode ^
        discountType.hashCode ^
        note.hashCode ^
        paidAmount.hashCode ^
        paymentMethod.hashCode ^
        totalDiscount.hashCode ^
        saleItems.hashCode;
  }
}
