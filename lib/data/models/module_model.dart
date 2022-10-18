import 'models_barrel.dart';

class ModuleModel {
  ModuleModel({
    required this.id,
    required this.industryId,
    required this.countryId,
    required this.fields,
    required this.bkashWithdrawCharge,
    required this.nagadWithdrawCharge,
    required this.paypallWithdrawCharge,
    required this.stripeWithdrawCharge,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.countryName,
    required this.countryCode,
    required this.country,
  });

  int id;
  int industryId;
  int countryId;
  List<FieldModel> fields;
  int bkashWithdrawCharge;
  int nagadWithdrawCharge;
  int paypallWithdrawCharge;
  int stripeWithdrawCharge;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String countryName;
  String countryCode;
  CountryModel country;

  ModuleModel copyWith({
    int? id,
    int? industryId,
    int? countryId,
    List<FieldModel>? fields,
    int? bkashWithdrawCharge,
    int? nagadWithdrawCharge,
    int? paypallWithdrawCharge,
    int? stripeWithdrawCharge,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    String? countryName,
    String? countryCode,
    CountryModel? country,
  }) =>
      ModuleModel(
        id: id ?? this.id,
        industryId: industryId ?? this.industryId,
        countryId: countryId ?? this.countryId,
        fields: fields ?? this.fields,
        bkashWithdrawCharge: bkashWithdrawCharge ?? this.bkashWithdrawCharge,
        nagadWithdrawCharge: nagadWithdrawCharge ?? this.nagadWithdrawCharge,
        paypallWithdrawCharge:
            paypallWithdrawCharge ?? this.paypallWithdrawCharge,
        stripeWithdrawCharge: stripeWithdrawCharge ?? this.stripeWithdrawCharge,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        countryName: countryName ?? this.countryName,
        countryCode: countryCode ?? this.countryCode,
        country: country ?? this.country,
      );

  factory ModuleModel.fromRawJson(String str) =>
      ModuleModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModuleModel.fromJson(Map<String, dynamic> json) => ModuleModel(
        id: json["id"],
        industryId: json["industryId"],
        countryId: json["countryId"],
        fields: List<FieldModel>.from(
            json["fields"].map((x) => FieldModel.fromJson(x))),
        bkashWithdrawCharge: json["bkashWithdrawCharge"],
        nagadWithdrawCharge: json["nagadWithdrawCharge"],
        paypallWithdrawCharge: json["paypallWithdrawCharge"],
        stripeWithdrawCharge: json["stripeWithdrawCharge"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        countryName: json["countryName"],
        countryCode: json["countryCode"],
        country: CountryModel.fromJson(json["country"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "industryId": industryId,
        "countryId": countryId,
        "fields": List<dynamic>.from(fields.map((x) => x.toJson())),
        "bkashWithdrawCharge": bkashWithdrawCharge,
        "nagadWithdrawCharge": nagadWithdrawCharge,
        "paypallWithdrawCharge": paypallWithdrawCharge,
        "stripeWithdrawCharge": stripeWithdrawCharge,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
        "countryName": countryName,
        "countryCode": countryCode,
        "country": country.toJson(),
      };
}
