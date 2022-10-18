import 'models_barrel.dart';

// enum UnitName { PICES, KG }

// final unitNameValues = EnumValues({"kg": UnitName.KG, "pices": UnitName.PICES});

class UnitModel {
  UnitModel({
    required this.id,
    required this.clientId,
    required this.name,
    required this.code,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    this.pivot,
  });

  final int id;
  final int clientId;
  final String name;
  final String code;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final ProductPivotModel? pivot;

  UnitModel copyWith({
    int? id,
    int? clientId,
    String? name,
    String? code,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    ProductPivotModel? pivot,
  }) =>
      UnitModel(
        id: id ?? this.id,
        clientId: clientId ?? this.clientId,
        name: name ?? this.name,
        code: code ?? this.code,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        pivot: pivot ?? this.pivot,
      );

  factory UnitModel.fromRawJson(String str) =>
      UnitModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UnitModel.fromJson(Map<String, dynamic> json) => UnitModel(
        id: json["id"],
        clientId: json["clientId"],
        name: json["name"],
        code: json["code"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        pivot: json["pivot"] != null
            ? ProductPivotModel.fromJson(json["pivot"])
            : json["pivot"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "clientId": clientId,
        "name": name,
        "code": code,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
        "pivot": pivot?.toJson() ?? pivot,
      };
}
