import 'models_barrel.dart';

class RoleModel {
  RoleModel({
    required this.id,
    required this.clientId,
    required this.name,
    required this.displayName,
    required this.guardName,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
    required this.permissions,
  });

  final int id;
  final int clientId;
  final String name;
  final dynamic displayName;
  final String guardName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final PivotModel pivot;
  final List<dynamic> permissions;

  RoleModel copyWith({
    int? id,
    int? clientId,
    String? name,
    dynamic displayName,
    String? guardName,
    DateTime? createdAt,
    DateTime? updatedAt,
    PivotModel? pivot,
    List<dynamic>? permissions,
  }) =>
      RoleModel(
        id: id ?? this.id,
        clientId: clientId ?? this.clientId,
        name: name ?? this.name,
        displayName: displayName ?? this.displayName,
        guardName: guardName ?? this.guardName,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        pivot: pivot ?? this.pivot,
        permissions: permissions ?? this.permissions,
      );

  factory RoleModel.fromRawJson(String str) =>
      RoleModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
        id: json["id"],
        clientId: json["client_id"],
        name: json["name"],
        displayName: json["display_name"],
        guardName: json["guard_name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pivot: PivotModel.fromJson(json["pivot"]),
        permissions: List<dynamic>.from(json["permissions"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "client_id": clientId,
        "name": name,
        "display_name": displayName,
        "guard_name": guardName,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "pivot": pivot.toJson(),
        "permissions": List<dynamic>.from(permissions.map((x) => x)),
      };
}
