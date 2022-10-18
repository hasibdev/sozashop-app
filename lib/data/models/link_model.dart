import 'dart:convert';

class LinkModel {
  LinkModel({
    this.url,
    required this.label,
    required this.active,
  });

  final String? url;
  final String label;
  final bool active;

  LinkModel copyWith({
    String? url,
    String? label,
    bool? active,
  }) =>
      LinkModel(
        url: url ?? this.url,
        label: label ?? this.label,
        active: active ?? this.active,
      );

  factory LinkModel.fromRawJson(String str) =>
      LinkModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LinkModel.fromJson(Map<String, dynamic> json) => LinkModel(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
