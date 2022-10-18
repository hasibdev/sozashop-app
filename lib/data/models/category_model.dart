import 'dart:convert';

import 'package:intl/intl.dart';

class Category {
  Category({
    required this.data,
  });

  final List<CategoryModel> data;

  Category copyWith({
    List<CategoryModel>? data,
  }) =>
      Category(
        data: data ?? this.data,
      );

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        data: List<CategoryModel>.from(
            json["data"].map((x) => CategoryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CategoryModel {
  final int id;
  final int clientId;
  final String name;
  final num? totalSaleAmount;
  final num? totalReturnAmount;
  final String? description;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final num? productsCount;
  final String clientName;
  final String shopName;
  final num totalProduct;
  bool isSelected;

  CategoryModel({
    required this.id,
    required this.clientId,
    required this.name,
    this.description,
    required this.status,
    this.totalSaleAmount,
    this.totalReturnAmount,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.productsCount,
    required this.clientName,
    required this.shopName,
    required this.totalProduct,
    this.isSelected = false,
  });

  CategoryModel copyWith({
    int? id,
    int? clientId,
    String? name,
    num? totalSaleAmount,
    num? totalReturnAmount,
    String? description,
    String? status,
    dynamic createdAt,
    dynamic updatedAt,
    dynamic deletedAt,
    num? productsCount,
    String? clientName,
    String? shopName,
    num? totalProduct,
    bool? isSelected,
  }) =>
      CategoryModel(
        id: id ?? this.id,
        clientId: clientId ?? this.clientId,
        name: name ?? this.name,
        totalSaleAmount: totalSaleAmount ?? this.totalSaleAmount,
        totalReturnAmount: totalReturnAmount ?? this.totalReturnAmount,
        description: description ?? this.description,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        productsCount: productsCount ?? this.productsCount,
        clientName: clientName ?? this.clientName,
        shopName: shopName ?? this.shopName,
        totalProduct: totalProduct ?? this.totalProduct,
        isSelected: isSelected ?? this.isSelected,
      );

  factory CategoryModel.fromRawJson(String str) =>
      CategoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        clientId: json["clientId"],
        name: json["name"] ?? '',
        totalSaleAmount: json["totalSaleAmount"],
        totalReturnAmount: json["totalReturnAmount"] ?? 0,
        description: json["description"] ?? '',
        status: json["status"] ?? '',
        createdAt: (json["createdAt"] != null)
            ? DateTime.parse(DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                .parse(json["createdAt"])
                .toString())
            : null,
        updatedAt: (json["updatedAt"] != null)
            ? DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                .parse(json["updatedAt"] ?? '')
            : null,
        deletedAt: json["deletedAt"],
        productsCount: json["productsCount"] ?? 0,
        clientName: json["clientName"] ?? '',
        shopName: json["shopName"] ?? '',
        totalProduct: json["totalProduct"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "clientId": clientId,
        "name": name,
        "totalSaleAmount": totalSaleAmount,
        "totalReturnAmount": totalReturnAmount,
        "description": description,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "productsCount": productsCount,
        "clientName": clientName,
        "shopName": shopName,
        "totalProduct": totalProduct,
      };

  static List<CategoryModel> listFromJson(List<dynamic> list) =>
      List<CategoryModel>.from(
          list.map((item) => CategoryModel.fromJson(item)));

  @override
  String toString() {
    return 'CategoryModel(id: $id, clientId: $clientId, name: $name, totalSaleAmount: $totalSaleAmount, totalReturnAmount: $totalReturnAmount, description: $description, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, productsCount: $productsCount, clientName: $clientName, shopName: $shopName, totalProduct: $totalProduct, isSelected: $isSelected)';
  }
}
