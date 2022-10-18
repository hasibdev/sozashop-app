import 'dart:convert';

class PaymentModel {
  PaymentModel({
    required this.id,
    required this.clientId,
    required this.saleInvoiceId,
    required this.amount,
    required this.method,
    required this.isWalletPayment,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.paymentAt,
  });

  final int id;
  final int clientId;
  final int saleInvoiceId;
  final int amount;
  final String method;
  final bool isWalletPayment;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final String paymentAt;

  PaymentModel copyWith({
    int? id,
    int? clientId,
    int? saleInvoiceId,
    int? amount,
    String? method,
    bool? isWalletPayment,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    String? paymentAt,
  }) =>
      PaymentModel(
        id: id ?? this.id,
        clientId: clientId ?? this.clientId,
        saleInvoiceId: saleInvoiceId ?? this.saleInvoiceId,
        amount: amount ?? this.amount,
        method: method ?? this.method,
        isWalletPayment: isWalletPayment ?? this.isWalletPayment,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        paymentAt: paymentAt ?? this.paymentAt,
      );

  factory PaymentModel.fromRawJson(String str) =>
      PaymentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        id: json["id"],
        clientId: json["clientId"],
        saleInvoiceId: json["saleInvoiceId"],
        amount: json["amount"],
        method: json["method"],
        isWalletPayment: json["isWalletPayment"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        paymentAt: json["paymentAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "clientId": clientId,
        "saleInvoiceId": saleInvoiceId,
        "amount": amount,
        "method": method,
        "isWalletPayment": isWalletPayment,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
        "paymentAt": paymentAt,
      };
}
