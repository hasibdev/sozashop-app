import 'models_barrel.dart';

class PivotModel {
  PivotModel({
    required this.modelId,
    required this.roleId,
    required this.modelType,
  });

  final int modelId;
  final int roleId;
  final String modelType;

  PivotModel copyWith({
    int? modelId,
    int? roleId,
    String? modelType,
  }) =>
      PivotModel(
        modelId: modelId ?? this.modelId,
        roleId: roleId ?? this.roleId,
        modelType: modelType ?? this.modelType,
      );

  factory PivotModel.fromRawJson(String str) =>
      PivotModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PivotModel.fromJson(Map<String, dynamic> json) => PivotModel(
        modelId: json["model_id"],
        roleId: json["role_id"],
        modelType: json["model_type"],
      );

  Map<String, dynamic> toJson() => {
        "model_id": modelId,
        "role_id": roleId,
        "model_type": modelType,
      };
}
