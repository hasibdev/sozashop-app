import 'dart:convert';

class CurrencyDataModel {
  CurrencyDataModel({
    required this.currencyCode,
    required this.currencyName,
    required this.currencySymbol,
  });

  final String currencyCode;
  final String currencyName;
  final String currencySymbol;

  CurrencyDataModel copyWith({
    String? currencyCode,
    String? currencyName,
    String? currencySymbol,
  }) =>
      CurrencyDataModel(
        currencyCode: currencyCode ?? this.currencyCode,
        currencyName: currencyName ?? this.currencyName,
        currencySymbol: currencySymbol ?? this.currencySymbol,
      );

  factory CurrencyDataModel.fromRawJson(String str) =>
      CurrencyDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CurrencyDataModel.fromJson(Map<String, dynamic> json) =>
      CurrencyDataModel(
        currencyCode: json["currency_code"],
        currencyName: json["currency_name"],
        currencySymbol: json["currency_symbol"],
      );

  Map<String, dynamic> toJson() => {
        "currency_code": currencyCode,
        "currency_name": currencyName,
        "currency_symbol": currencySymbol,
      };
}
