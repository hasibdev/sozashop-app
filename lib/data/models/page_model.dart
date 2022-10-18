import 'models_barrel.dart';

class PageModel {
  PageModel({
    required this.name,
    required this.label,
    required this.value,
    required this.fields,
    this.actions,
  });

  String name;
  String label;
  bool value;
  List<ActionModel> fields;
  List<ActionModel>? actions;

  PageModel copyWith({
    String? name,
    String? label,
    bool? value,
    List<ActionModel>? fields,
    List<ActionModel>? actions,
  }) =>
      PageModel(
        name: name ?? this.name,
        label: label ?? this.label,
        value: value ?? this.value,
        fields: fields ?? this.fields,
        actions: actions ?? this.actions,
      );

  factory PageModel.fromRawJson(String str) =>
      PageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PageModel.fromJson(Map<String, dynamic> json) => PageModel(
        name: json["name"],
        label: json["label"],
        value: json["value"],
        fields: json["fields"] == null
            ? []
            : List<ActionModel>.from(
                json["fields"].map((x) => ActionModel.fromJson(x))),
        actions: json["actions"] == null
            ? []
            : List<ActionModel>.from(
                json["actions"].map((x) => ActionModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "label": label,
        "value": value,
        "fields": List<dynamic>.from(fields.map((x) => x.toJson())),
        "actions": List<dynamic>.from(actions?.map((x) => x.toJson()) ?? []),
      };
}
