import 'dart:convert';

import 'package:sozashop_app/data/models/currency_data_model.dart';
import 'package:sozashop_app/data/models/customer_model.dart';
import 'package:sozashop_app/data/models/media_model.dart';

class CurrencySettingsModel {
  CurrencySettingsModel({
    required this.id,
    required this.clientId,
    required this.type,
    required this.data,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    this.customer,
    required this.primaryMediaUrl,
    required this.media,
  });

  final int id;
  final int clientId;
  final String type;
  final CurrencyDataModel data;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final CustomerModel? customer;
  final String primaryMediaUrl;
  final List<MediaModel> media;

  CurrencySettingsModel copyWith({
    int? id,
    int? clientId,
    String? type,
    CurrencyDataModel? data,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    CustomerModel? customer,
    String? primaryMediaUrl,
    List<MediaModel>? media,
  }) =>
      CurrencySettingsModel(
        id: id ?? this.id,
        clientId: clientId ?? this.clientId,
        type: type ?? this.type,
        data: data ?? this.data,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        customer: customer ?? this.customer,
        primaryMediaUrl: primaryMediaUrl ?? this.primaryMediaUrl,
        media: media ?? this.media,
      );

  factory CurrencySettingsModel.fromRawJson(String str) =>
      CurrencySettingsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CurrencySettingsModel.fromJson(Map<String, dynamic> json) =>
      CurrencySettingsModel(
        id: json["id"],
        clientId: json["clientId"],
        type: json["type"],
        data: CurrencyDataModel.fromJson(json["data"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        customer: json["customer"] == null
            ? null
            : CustomerModel.fromJson(json["customer"]),
        primaryMediaUrl: json["primaryMediaUrl"],
        media: List<MediaModel>.from(
            json["media"].map((x) => MediaModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "clientId": clientId,
        "type": type,
        "data": data.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
        "customer": customer?.toJson(),
        "primaryMediaUrl": primaryMediaUrl,
        "media": List<dynamic>.from(media.map((x) => x.toJson())),
      };
}
