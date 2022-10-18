import 'package:sozashop_app/data/models/models_barrel.dart';

class CountryModel {
  CountryModel({
    required this.id,
    required this.name,
    required this.code,
    required this.currency,
    required this.currencyCode,
    required this.currencySymbol,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String code;
  String currency;
  String currencyCode;
  String currencySymbol;
  DateTime createdAt;
  DateTime updatedAt;

  CountryModel copyWith({
    int? id,
    String? name,
    String? code,
    String? currency,
    String? currencyCode,
    String? currencySymbol,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      CountryModel(
        id: id ?? this.id,
        name: name ?? this.name,
        code: code ?? this.code,
        currency: currency ?? this.currency,
        currencyCode: currencyCode ?? this.currencyCode,
        currencySymbol: currencySymbol ?? this.currencySymbol,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory CountryModel.fromRawJson(String str) =>
      CountryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        currency: json["currency"],
        currencyCode: json["currencyCode"],
        currencySymbol: json["currencySymbol"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "currency": currency,
        "currencyCode": currencyCode,
        "currencySymbol": currencySymbol,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
