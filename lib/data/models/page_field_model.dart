import 'models_barrel.dart';

class PageFieldModel {
  PageFieldModel({
    required this.name,
    required this.label,
    required this.value,
  });

  final String name;
  final String label;
  final bool value;

  PageFieldModel copyWith({
    String? name,
    String? label,
    bool? value,
  }) =>
      PageFieldModel(
        name: name ?? this.name,
        label: label ?? this.label,
        value: value ?? this.value,
      );

  factory PageFieldModel.fromRawJson(String str) =>
      PageFieldModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PageFieldModel.fromJson(Map<String, dynamic> json) => PageFieldModel(
        name: json["name"],
        label: json["label"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "label": label,
        "value": value,
      };
}
