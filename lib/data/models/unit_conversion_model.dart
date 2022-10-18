// To parse this JSON data, do
//
//     final unitConversion = unitConversionFromJson(jsonString);

import 'dart:convert';

import 'package:sozashop_app/data/models/unit_model.dart';

class UnitConversion {
  UnitConversion({
    required this.data,
  });

  final List<UnitConversionModel> data;

  UnitConversion copyWith({
    List<UnitConversionModel>? data,
  }) =>
      UnitConversion(
        data: data ?? this.data,
      );

  factory UnitConversion.fromRawJson(String str) =>
      UnitConversion.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UnitConversion.fromJson(Map<String, dynamic> json) => UnitConversion(
        data: List<UnitConversionModel>.from(
            json["data"].map((x) => UnitConversionModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class UnitConversionModel {
  UnitConversionModel({
    required this.id,
    required this.baseUnitId,
    required this.unitId,
    required this.unitOperator,
    required this.value,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.unitName,
    required this.baseUnitName,
    required this.unit,
    required this.baseUnit,
  });

  final int id;
  final int baseUnitId;
  final int unitId;
  final String unitOperator;
  final String value;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final String unitName;
  final String baseUnitName;
  final UnitModel unit;
  final UnitModel baseUnit;

  UnitConversionModel copyWith({
    int? id,
    int? baseUnitId,
    int? unitId,
    String? datumOperator,
    String? value,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    String? unitName,
    String? baseUnitName,
    UnitModel? unit,
    UnitModel? baseUnit,
  }) =>
      UnitConversionModel(
        id: id ?? this.id,
        baseUnitId: baseUnitId ?? this.baseUnitId,
        unitId: unitId ?? this.unitId,
        unitOperator: datumOperator ?? unitOperator,
        value: value ?? this.value,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        unitName: unitName ?? this.unitName,
        baseUnitName: baseUnitName ?? this.baseUnitName,
        unit: unit ?? this.unit,
        baseUnit: baseUnit ?? this.baseUnit,
      );

  factory UnitConversionModel.fromRawJson(String str) =>
      UnitConversionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UnitConversionModel.fromJson(Map<String, dynamic> json) =>
      UnitConversionModel(
        id: json["id"],
        baseUnitId: json["baseUnitId"],
        unitId: json["unitId"],
        unitOperator: json["operator"],
        value: json["value"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        unitName: json["unitName"],
        baseUnitName: json["baseUnitName"],
        unit: UnitModel.fromJson(json["unit"]),
        baseUnit: UnitModel.fromJson(json["baseUnit"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "baseUnitId": baseUnitId,
        "unitId": unitId,
        "operator": unitOperator,
        "value": value,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
        "unitName": unitName,
        "baseUnitName": baseUnitName,
        "unit": unit.toJson(),
        "baseUnit": baseUnit.toJson(),
      };
}
