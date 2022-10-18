import 'dart:convert';

import 'link_model.dart';

class MetaModel {
  MetaModel({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  final int currentPage;
  final int from;
  final int lastPage;
  final List<LinkModel> links;
  final String path;
  final int perPage;
  final int to;
  final int total;

  MetaModel copyWith({
    int? currentPage,
    int? from,
    int? lastPage,
    List<LinkModel>? links,
    String? path,
    int? perPage,
    int? to,
    int? total,
  }) =>
      MetaModel(
        currentPage: currentPage ?? this.currentPage,
        from: from ?? this.from,
        lastPage: lastPage ?? this.lastPage,
        links: links ?? this.links,
        path: path ?? this.path,
        perPage: perPage ?? this.perPage,
        to: to ?? this.to,
        total: total ?? this.total,
      );

  factory MetaModel.fromRawJson(String str) =>
      MetaModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MetaModel.fromJson(Map<String, dynamic> json) => MetaModel(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        links: List<LinkModel>.from(
            json["links"].map((x) => LinkModel.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
      };
}
