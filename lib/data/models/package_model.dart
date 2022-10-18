import 'models_barrel.dart';

class PackageModel {
  PackageModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.type,
    required this.recommended,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  final int id;
  final String name;
  final int price;
  final List<DescriptionModel> description;
  final String type;
  final bool recommended;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;

  PackageModel copyWith({
    int? id,
    String? name,
    int? price,
    List<DescriptionModel>? description,
    String? type,
    bool? recommended,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
  }) =>
      PackageModel(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        description: description ?? this.description,
        type: type ?? this.type,
        recommended: recommended ?? this.recommended,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
      );

  factory PackageModel.fromRawJson(String str) =>
      PackageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PackageModel.fromJson(Map<String, dynamic> json) => PackageModel(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        description: List<DescriptionModel>.from(
            json["description"].map((x) => DescriptionModel.fromJson(x))),
        type: json["type"],
        recommended: json["recommended"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "description": List<dynamic>.from(description.map((x) => x.toJson())),
        "type": type,
        "recommended": recommended,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
      };
}
