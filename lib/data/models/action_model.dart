import 'dart:convert';

class ActionModel {
  ActionModel({
    required this.name,
    required this.label,
    required this.value,
  });

  final String name;
  final String label;
  final bool value;

  ActionModel copyWith({
    String? name,
    String? label,
    bool? value,
  }) =>
      ActionModel(
        name: name ?? this.name,
        label: label ?? this.label,
        value: value ?? this.value,
      );

  factory ActionModel.fromRawJson(String str) =>
      ActionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ActionModel.fromJson(Map<String, dynamic> json) => ActionModel(
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
