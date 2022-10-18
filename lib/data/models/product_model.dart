import 'models_barrel.dart';

class Product {
  Product({
    required this.data,
    // required this.links,
    // required this.meta,
  });

  final List<ProductModel> data;
  // final LinksModel links;
  // final MetaModel meta;

  Product copyWith({
    List<ProductModel>? data,
    // LinksModel? links,
    // MetaModel? meta,
  }) =>
      Product(
        data: data ?? this.data,
        // links: links ?? this.links,
        // meta: meta ?? this.meta,
      );

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        data: List<ProductModel>.from(
            json["data"].map((x) => ProductModel.fromJson(x))),
        // links: LinksModel.fromJson(json["links"]),
        // meta: MetaModel.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        // "links": links.toJson(),
        // "meta": meta.toJson(),
      };
}

class ProductModel {
  final int id;
  final int clientId;
  final String name;
  final dynamic code;
  final dynamic brand;
  final dynamic storeIn;
  final dynamic size;
  final dynamic color;
  final int? categoryId;
  final int totalQuantity;
  final int? alertQuantity;
  final int totalPurchaseAmount;
  final int totalSellingAmount;
  final double totalSaleAmount;
  final int totalReturnAmount;
  final dynamic description;
  final int unitId;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final int saleItemsCount;
  final int returnItemsCount;
  final String unitName;
  final String categoryName;
  final int totalAmount;
  final String imageUrl;
  final String clientName;
  final String shopName;
  final int totalSaleItem;
  final int totalReturnItem;
  final List<UnitModel>? purchaseUnits;
  final List<UnitModel>? sellingUnits;
  final CategoryModel category;
  final UnitModel unit;
  final List<dynamic> media;

  ProductModel({
    required this.id,
    required this.clientId,
    required this.name,
    this.code,
    this.brand,
    this.storeIn,
    this.size,
    this.color,
    this.categoryId,
    required this.totalQuantity,
    this.alertQuantity,
    required this.totalPurchaseAmount,
    required this.totalSellingAmount,
    required this.totalSaleAmount,
    required this.totalReturnAmount,
    required this.description,
    required this.unitId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.saleItemsCount,
    required this.returnItemsCount,
    required this.unitName,
    required this.categoryName,
    required this.totalAmount,
    required this.imageUrl,
    required this.clientName,
    required this.shopName,
    required this.totalSaleItem,
    required this.totalReturnItem,
    this.purchaseUnits,
    this.sellingUnits,
    required this.category,
    required this.unit,
    required this.media,
  });

  ProductModel copyWith({
    int? id,
    int? clientId,
    String? name,
    dynamic code,
    dynamic brand,
    dynamic storeIn,
    dynamic size,
    dynamic color,
    int? categoryId,
    int? totalQuantity,
    int? alertQuantity,
    int? totalPurchaseAmount,
    int? totalSellingAmount,
    double? totalSaleAmount,
    int? totalReturnAmount,
    dynamic description,
    int? unitId,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    int? saleItemsCount,
    int? returnItemsCount,
    String? unitName,
    String? categoryName,
    int? totalAmount,
    String? imageUrl,
    String? clientName,
    String? shopName,
    int? totalSaleItem,
    int? totalReturnItem,
    List<UnitModel>? purchaseUnits,
    List<UnitModel>? sellingUnits,
    CategoryModel? category,
    UnitModel? unit,
    List<dynamic>? media,
  }) =>
      ProductModel(
        id: id ?? this.id,
        clientId: clientId ?? this.clientId,
        name: name ?? this.name,
        code: code ?? this.code,
        brand: brand ?? this.brand,
        storeIn: storeIn ?? this.storeIn,
        size: size ?? this.size,
        color: color ?? this.color,
        categoryId: categoryId ?? this.categoryId,
        totalQuantity: totalQuantity ?? this.totalQuantity,
        alertQuantity: alertQuantity ?? this.alertQuantity,
        totalPurchaseAmount: totalPurchaseAmount ?? this.totalPurchaseAmount,
        totalSellingAmount: totalSellingAmount ?? this.totalSellingAmount,
        totalSaleAmount: totalSaleAmount ?? this.totalSaleAmount,
        totalReturnAmount: totalReturnAmount ?? this.totalReturnAmount,
        description: description ?? this.description,
        unitId: unitId ?? this.unitId,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        saleItemsCount: saleItemsCount ?? this.saleItemsCount,
        returnItemsCount: returnItemsCount ?? this.returnItemsCount,
        unitName: unitName ?? this.unitName,
        categoryName: categoryName ?? this.categoryName,
        totalAmount: totalAmount ?? this.totalAmount,
        imageUrl: imageUrl ?? this.imageUrl,
        clientName: clientName ?? this.clientName,
        shopName: shopName ?? this.shopName,
        totalSaleItem: totalSaleItem ?? this.totalSaleItem,
        totalReturnItem: totalReturnItem ?? this.totalReturnItem,
        purchaseUnits: purchaseUnits ?? this.purchaseUnits,
        sellingUnits: sellingUnits ?? this.sellingUnits,
        category: category ?? this.category,
        unit: unit ?? this.unit,
        media: media ?? this.media,
      );

  factory ProductModel.fromRawJson(String str) =>
      ProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        clientId: json["clientId"],
        name: json["name"],
        code: json["code"] ?? "",
        brand: json["brand"] ?? "",
        storeIn: json["storeIn"] ?? "",
        size: json["size"] ?? "",
        color: json["color"] ?? "",
        categoryId: json["categoryId"],
        totalQuantity: json["totalQuantity"],
        alertQuantity: json["alertQuantity"],
        totalPurchaseAmount: json["totalPurchaseAmount"],
        totalSellingAmount: json["totalSellingAmount"],
        totalSaleAmount: json["totalSaleAmount"].toDouble(),
        totalReturnAmount: json["totalReturnAmount"],
        description: json["description"],
        unitId: json["unitId"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        saleItemsCount: json["saleItemsCount"],
        returnItemsCount: json["returnItemsCount"],
        unitName: json["unitName"],
        categoryName: json["categoryName"],
        totalAmount: json["totalAmount"],
        imageUrl: json["imageUrl"],
        clientName: json["clientName"],
        shopName: json["shopName"],
        totalSaleItem: json["totalSaleItem"],
        totalReturnItem: json["totalReturnItem"],
        purchaseUnits: List<UnitModel>.from(
            json["purchaseUnits"].map((x) => UnitModel.fromJson(x))),
        sellingUnits: List<UnitModel>.from(
            json["sellingUnits"].map((x) => UnitModel.fromJson(x))),
        category: CategoryModel.fromJson(json["category"]),
        unit: UnitModel.fromJson(json["unit"]),
        media: List<dynamic>.from(json["media"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "clientId": clientId,
        "name": name,
        "code": code,
        "brand": brand,
        "storeIn": storeIn,
        "size": size,
        "color": color,
        "categoryId": categoryId,
        "totalQuantity": totalQuantity,
        "alertQuantity": alertQuantity,
        "totalPurchaseAmount": totalPurchaseAmount,
        "totalSellingAmount": totalSellingAmount,
        "totalSaleAmount": totalSaleAmount,
        "totalReturnAmount": totalReturnAmount,
        "description": description,
        "unitId": unitId,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
        "saleItemsCount": saleItemsCount,
        "returnItemsCount": returnItemsCount,
        "unitName": unitName,
        "categoryName": categoryName,
        "totalAmount": totalAmount,
        "imageUrl": imageUrl,
        "clientName": clientName,
        "shopName": shopName,
        "totalSaleItem": totalSaleItem,
        "totalReturnItem": totalReturnItem,
        "purchaseUnits":
            List<dynamic>.from(purchaseUnits?.map((x) => x.toJson()) ?? []),
        "sellingUnits":
            List<dynamic>.from(sellingUnits?.map((x) => x.toJson()) ?? []),
        "category": category.toJson(),
        "unit": unit.toJson(),
        "media": List<dynamic>.from(media.map((x) => x)),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap;
    return reverseMap;
  }
}
