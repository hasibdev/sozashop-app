import 'dart:convert';

class ChargeModel {
  ChargeModel({
    required this.id,
    this.invoiceId,
    required this.chargeId,
    required this.chargeAmount,
    required this.totalCharge,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.chargeType,
    required this.chargeName,
    required this.charge,
  });

  final int id;
  final int? invoiceId;
  final int chargeId;
  final int chargeAmount;
  final double totalCharge;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final String chargeType;
  final String chargeName;
  final ChargeDetailModel charge;

  ChargeModel copyWith({
    int? id,
    int? invoiceId,
    int? chargeId,
    int? chargeAmount,
    double? totalCharge,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    String? chargeType,
    String? chargeName,
    ChargeDetailModel? charge,
  }) =>
      ChargeModel(
        id: id ?? this.id,
        invoiceId: invoiceId ?? this.invoiceId,
        chargeId: chargeId ?? this.chargeId,
        chargeAmount: chargeAmount ?? this.chargeAmount,
        totalCharge: totalCharge ?? this.totalCharge,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        chargeType: chargeType ?? this.chargeType,
        chargeName: chargeName ?? this.chargeName,
        charge: charge ?? this.charge,
      );

  factory ChargeModel.fromRawJson(String str) =>
      ChargeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChargeModel.fromJson(Map<String, dynamic> json) => ChargeModel(
        id: json["id"],
        // ignore: prefer_if_null_operators
        invoiceId: json["invoiceId"] == null ? null : json["invoiceId"],
        chargeId: json["chargeId"],
        chargeAmount: json["chargeAmount"],
        totalCharge: json["totalCharge"].toDouble(),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        chargeType: json["chargeType"],
        chargeName: json["chargeName"],
        charge: ChargeDetailModel.fromJson(json["charge"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "invoiceId": invoiceId,
        "chargeId": chargeId,
        "chargeAmount": chargeAmount,
        "totalCharge": totalCharge,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
        "chargeType": chargeType,
        "chargeName": chargeName,
        "charge": charge.toJson(),
      };
}

class ChargeDetailModel {
  ChargeDetailModel({
    required this.id,
    required this.clientId,
    required this.name,
    required this.type,
    required this.chargedBy,
    required this.amount,
    required this.totalAmount,
    required this.profitable,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.invoiceChargesCount,
    required this.totalInvoice,
  });

  final int id;
  final int clientId;
  final String name;
  final String type;
  final String chargedBy;
  final int amount;
  final double totalAmount;
  final int profitable;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final int invoiceChargesCount;
  final int totalInvoice;

  ChargeDetailModel copyWith({
    int? id,
    int? clientId,
    String? name,
    String? type,
    String? chargedBy,
    int? amount,
    double? totalAmount,
    int? profitable,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    int? invoiceChargesCount,
    int? totalInvoice,
  }) =>
      ChargeDetailModel(
        id: id ?? this.id,
        clientId: clientId ?? this.clientId,
        name: name ?? this.name,
        type: type ?? this.type,
        chargedBy: chargedBy ?? this.chargedBy,
        amount: amount ?? this.amount,
        totalAmount: totalAmount ?? this.totalAmount,
        profitable: profitable ?? this.profitable,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        invoiceChargesCount: invoiceChargesCount ?? this.invoiceChargesCount,
        totalInvoice: totalInvoice ?? this.totalInvoice,
      );

  factory ChargeDetailModel.fromRawJson(String str) =>
      ChargeDetailModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChargeDetailModel.fromJson(Map<String, dynamic> json) =>
      ChargeDetailModel(
        id: json["id"],
        clientId: json["clientId"],
        name: json["name"],
        type: json["type"],
        chargedBy: json["chargedBy"],
        amount: json["amount"],
        totalAmount: json["totalAmount"].toDouble(),
        profitable: json["profitable"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        invoiceChargesCount: json["invoiceChargesCount"],
        totalInvoice: json["totalInvoice"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "clientId": clientId,
        "name": name,
        "type": type,
        "chargedBy": chargedBy,
        "amount": amount,
        "totalAmount": totalAmount,
        "profitable": profitable,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
        "invoiceChargesCount": invoiceChargesCount,
        "totalInvoice": totalInvoice,
      };
}
