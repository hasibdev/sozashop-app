import 'models_barrel.dart';

class UserModel {
  UserModel({
    required this.id,
    required this.clientId,
    required this.firstName,
    required this.lastName,
    required this.designation,
    required this.email,
    required this.emailVerifiedAt,
    required this.lastLogin,
    required this.mobile,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.type,
    required this.name,
    required this.userLastLogin,
    required this.availableRoles,
    required this.profilePhotoUrl,
    required this.roles,
    required this.permissions,
    required this.media,
  });

  final int id;
  final int clientId;
  final String firstName;
  final String lastName;
  final dynamic designation;
  final String email;
  final dynamic emailVerifiedAt;
  final DateTime lastLogin;
  final String mobile;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final String type;
  final String name;
  final String userLastLogin;
  final String availableRoles;
  final String profilePhotoUrl;
  final List<RoleModel> roles;
  final List<dynamic> permissions;
  final List<MediaModel> media;

  UserModel copyWith({
    int? id,
    int? clientId,
    String? firstName,
    String? lastName,
    dynamic designation,
    String? email,
    dynamic emailVerifiedAt,
    DateTime? lastLogin,
    String? mobile,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    String? type,
    String? name,
    String? userLastLogin,
    String? availableRoles,
    String? profilePhotoUrl,
    List<RoleModel>? roles,
    List<dynamic>? permissions,
    List<MediaModel>? media,
  }) =>
      UserModel(
        id: id ?? this.id,
        clientId: clientId ?? this.clientId,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        designation: designation ?? this.designation,
        email: email ?? this.email,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        lastLogin: lastLogin ?? this.lastLogin,
        mobile: mobile ?? this.mobile,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        type: type ?? this.type,
        name: name ?? this.name,
        userLastLogin: userLastLogin ?? this.userLastLogin,
        availableRoles: availableRoles ?? this.availableRoles,
        profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
        roles: roles ?? this.roles,
        permissions: permissions ?? this.permissions,
        media: media ?? this.media,
      );

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        clientId: json["clientId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        designation: json["designation"],
        email: json["email"],
        emailVerifiedAt: json["emailVerifiedAt"],
        lastLogin: DateTime.parse(json["lastLogin"]),
        mobile: json["mobile"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        type: json["type"],
        name: json["name"],
        userLastLogin: json["userLastLogin"],
        availableRoles: json["availableRoles"],
        profilePhotoUrl: json["profilePhotoUrl"],
        roles: List<RoleModel>.from(
            json["roles"].map((x) => RoleModel.fromJson(x))),
        permissions: List<dynamic>.from(json["permissions"].map((x) => x)),
        media: List<MediaModel>.from(
            json["media"].map((x) => MediaModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "clientId": clientId,
        "firstName": firstName,
        "lastName": lastName,
        "designation": designation,
        "email": email,
        "emailVerifiedAt": emailVerifiedAt,
        "lastLogin": lastLogin.toIso8601String(),
        "mobile": mobile,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
        "type": type,
        "name": name,
        "userLastLogin": userLastLogin,
        "availableRoles": availableRoles,
        "profilePhotoUrl": profilePhotoUrl,
        "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
        "permissions": List<dynamic>.from(permissions.map((x) => x)),
        "media": List<dynamic>.from(media.map((x) => x.toJson())),
      };
}
