import 'dart:convert';

class LinksModel {
  LinksModel({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  final String? first;
  final String? last;
  final dynamic? prev;
  final String? next;

  LinksModel copyWith({
    String? first,
    String? last,
    dynamic prev,
    String? next,
  }) =>
      LinksModel(
        first: first ?? this.first,
        last: last ?? this.last,
        prev: prev ?? this.prev,
        next: next ?? this.next,
      );

  factory LinksModel.fromRawJson(String str) =>
      LinksModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LinksModel.fromJson(Map<String, dynamic> json) => LinksModel(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };
}
