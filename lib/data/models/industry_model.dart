import 'models_barrel.dart';

Industry industryFromJson(String str) => Industry.fromJson(json.decode(str));

String industryToJson(Industry data) => json.encode(data.toJson());

class Industry {
  Industry({
    required this.data,
  });

  List<IndustryModel> data;

  factory Industry.fromJson(Map<String, dynamic> json) => Industry(
        data: List<IndustryModel>.from(
            json["data"].map((x) => IndustryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class IndustryModel {
  int id;
  String name;
  String? description;
  String status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  int? totalClient;
  List<ModuleModel> modules;

  IndustryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    required this.totalClient,
    required this.modules,
  });

  IndustryModel copyWith({
    int? id,
    String? name,
    String? status,
    String? description,
    int? totalClient,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    List<ModuleModel>? modules,
  }) {
    return IndustryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      description: description ?? this.description,
      totalClient: totalClient ?? this.totalClient,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      modules: modules ?? this.modules,
    );
  }

  factory IndustryModel.fromRawJson(String str) =>
      IndustryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory IndustryModel.fromJson(Map<String, dynamic> json) => IndustryModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        totalClient: json["totalClient"],
        modules: List<ModuleModel>.from(
            json["modules"].map((x) => ModuleModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description ?? '',
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "totalClient": totalClient,
        "modules": List<dynamic>.from(modules.map((x) => x.toJson())),
      };

  static List<IndustryModel> listFromJson(List<dynamic> list) =>
      List<IndustryModel>.from(list.map((e) => IndustryModel.fromJson(e)));
}
