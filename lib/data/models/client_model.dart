import 'models_barrel.dart';

class ClientModel {
  ClientModel({
    required this.id,
    required this.packageId,
    required this.readableId,
    required this.industryId,
    required this.moduleId,
    required this.firstName,
    required this.lastName,
    required this.shopName,
    required this.fields,
    required this.email,
    required this.mobile,
    required this.totalPaid,
    required this.totalWithdraw,
    required this.balance,
    required this.bkashWithdrawCharge,
    required this.nagadWithdrawCharge,
    required this.paypallWithdrawCharge,
    required this.stripeWithdrawCharge,
    required this.status,
    required this.isVerified,
    required this.rememberToken,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.name,
    required this.industryName,
    required this.imageUrl,
    required this.nidFrontUrl,
    required this.nidBackUrl,
    required this.countryName,
    required this.module,
    required this.industry,
    required this.media,
    required this.transactions,
    required this.package,
  });

  final int id;
  final int packageId;
  final String readableId;
  final int industryId;
  final int moduleId;
  final String firstName;
  final String lastName;
  final String shopName;
  final List<FieldModel>? fields;
  final String email;
  final String mobile;
  final int totalPaid;
  final int totalWithdraw;
  final int balance;
  final int bkashWithdrawCharge;
  final int nagadWithdrawCharge;
  final int paypallWithdrawCharge;
  final int stripeWithdrawCharge;
  final String status;
  final bool isVerified;
  final dynamic rememberToken;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final String name;
  final String industryName;
  final String imageUrl;
  final String nidFrontUrl;
  final String nidBackUrl;
  final String countryName;
  final ModuleModel module;
  final IndustryModel industry;
  final List<MediaModel> media;
  final List<dynamic> transactions;
  final PackageModel package;

  ClientModel copyWith({
    int? id,
    int? packageId,
    String? readableId,
    int? industryId,
    int? moduleId,
    String? firstName,
    String? lastName,
    String? shopName,
    List<FieldModel>? fields,
    String? email,
    String? mobile,
    int? totalPaid,
    int? totalWithdraw,
    int? balance,
    int? bkashWithdrawCharge,
    int? nagadWithdrawCharge,
    int? paypallWithdrawCharge,
    int? stripeWithdrawCharge,
    String? status,
    bool? isVerified,
    dynamic rememberToken,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    String? name,
    String? industryName,
    String? imageUrl,
    String? nidFrontUrl,
    String? nidBackUrl,
    String? countryName,
    ModuleModel? module,
    IndustryModel? industry,
    List<MediaModel>? media,
    List<dynamic>? transactions,
    PackageModel? package,
  }) =>
      ClientModel(
        id: id ?? this.id,
        packageId: packageId ?? this.packageId,
        readableId: readableId ?? this.readableId,
        industryId: industryId ?? this.industryId,
        moduleId: moduleId ?? this.moduleId,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        shopName: shopName ?? this.shopName,
        fields: fields ?? this.fields,
        email: email ?? this.email,
        mobile: mobile ?? this.mobile,
        totalPaid: totalPaid ?? this.totalPaid,
        totalWithdraw: totalWithdraw ?? this.totalWithdraw,
        balance: balance ?? this.balance,
        bkashWithdrawCharge: bkashWithdrawCharge ?? this.bkashWithdrawCharge,
        nagadWithdrawCharge: nagadWithdrawCharge ?? this.nagadWithdrawCharge,
        paypallWithdrawCharge:
            paypallWithdrawCharge ?? this.paypallWithdrawCharge,
        stripeWithdrawCharge: stripeWithdrawCharge ?? this.stripeWithdrawCharge,
        status: status ?? this.status,
        isVerified: isVerified ?? this.isVerified,
        rememberToken: rememberToken ?? this.rememberToken,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        name: name ?? this.name,
        industryName: industryName ?? this.industryName,
        imageUrl: imageUrl ?? this.imageUrl,
        nidFrontUrl: nidFrontUrl ?? this.nidFrontUrl,
        nidBackUrl: nidBackUrl ?? this.nidBackUrl,
        countryName: countryName ?? this.countryName,
        module: module ?? this.module,
        industry: industry ?? this.industry,
        media: media ?? this.media,
        transactions: transactions ?? this.transactions,
        package: package ?? this.package,
      );

  factory ClientModel.fromRawJson(String str) =>
      ClientModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
        id: json["id"],
        packageId: json["packageId"],
        readableId: json["readableId"],
        industryId: json["industryId"],
        moduleId: json["moduleId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        shopName: json["shopName"],
        fields: List<FieldModel>.from(
            (json["fields"] ?? []).map((x) => FieldModel.fromJson(x))),
        email: json["email"],
        mobile: json["mobile"],
        totalPaid: json["totalPaid"],
        totalWithdraw: json["totalWithdraw"],
        balance: json["balance"],
        bkashWithdrawCharge: json["bkashWithdrawCharge"],
        nagadWithdrawCharge: json["nagadWithdrawCharge"],
        paypallWithdrawCharge: json["paypallWithdrawCharge"],
        stripeWithdrawCharge: json["stripeWithdrawCharge"],
        status: json["status"],
        isVerified: json["isVerified"],
        rememberToken: json["rememberToken"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        name: json["name"],
        industryName: json["industryName"],
        imageUrl: json["imageUrl"],
        nidFrontUrl: json["nidFrontUrl"],
        nidBackUrl: json["nidBackUrl"],
        countryName: json["countryName"],
        module: ModuleModel.fromJson(json["module"]),
        industry: IndustryModel.fromJson(json["industry"]),
        media: List<MediaModel>.from(
            json["media"].map((x) => MediaModel.fromJson(x))),
        transactions: List<dynamic>.from(json["transactions"].map((x) => x)),
        package: PackageModel.fromJson(json["package"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "packageId": packageId,
        "readableId": readableId,
        "industryId": industryId,
        "moduleId": moduleId,
        "firstName": firstName,
        "lastName": lastName,
        "shopName": shopName,
        "fields": fields,
        "email": email,
        "mobile": mobile,
        "totalPaid": totalPaid,
        "totalWithdraw": totalWithdraw,
        "balance": balance,
        "bkashWithdrawCharge": bkashWithdrawCharge,
        "nagadWithdrawCharge": nagadWithdrawCharge,
        "paypallWithdrawCharge": paypallWithdrawCharge,
        "stripeWithdrawCharge": stripeWithdrawCharge,
        "status": status,
        "isVerified": isVerified,
        "rememberToken": rememberToken,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
        "name": name,
        "industryName": industryName,
        "imageUrl": imageUrl,
        "nidFrontUrl": nidFrontUrl,
        "nidBackUrl": nidBackUrl,
        "countryName": countryName,
        "module": module.toJson(),
        "industry": industry.toJson(),
        "media": List<dynamic>.from(media.map((x) => x.toJson())),
        "transactions": List<dynamic>.from(transactions.map((x) => x)),
        "package": package.toJson(),
      };
}
