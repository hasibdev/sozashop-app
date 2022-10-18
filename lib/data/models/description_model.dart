import 'models_barrel.dart';

class DescriptionModel {
  DescriptionModel({
    required this.description,
  });

  final String description;

  DescriptionModel copyWith({
    String? description,
  }) =>
      DescriptionModel(
        description: description ?? this.description,
      );

  factory DescriptionModel.fromRawJson(String str) =>
      DescriptionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DescriptionModel.fromJson(Map<String, dynamic> json) =>
      DescriptionModel(
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
      };
}
