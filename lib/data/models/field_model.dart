import 'models_barrel.dart';

class FieldModel {
  FieldModel({
    required this.id,
    required this.name,
    required this.label,
    required this.pages,
  });

  int id;
  String name;
  String label;
  List<PageModel> pages;

  FieldModel copyWith({
    int? id,
    String? name,
    String? label,
    List<PageModel>? pages,
  }) =>
      FieldModel(
        id: id ?? this.id,
        name: name ?? this.name,
        label: label ?? this.label,
        pages: pages ?? this.pages,
      );

  factory FieldModel.fromRawJson(String str) =>
      FieldModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FieldModel.fromJson(Map<String, dynamic> json) => FieldModel(
        id: json["id"],
        name: json["name"],
        label: json["label"],
        pages: List<PageModel>.from(
            json["pages"].map((x) => PageModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "label": label,
        "pages": List<dynamic>.from(pages.map((x) => x.toJson())),
      };
}
