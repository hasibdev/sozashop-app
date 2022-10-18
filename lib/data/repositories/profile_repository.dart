import 'package:dio/dio.dart';
import 'package:sozashop_app/data/models/config_model.dart';
import 'package:sozashop_app/data/models/models_barrel.dart';
import 'package:sozashop_app/data/services/profile_service.dart';

enum EnumType {
  activeStatus,
  notificationType,
  settingType,
  invoiceStatus,
  paymentMethod,
  paymentable,
  loanType,
  discountType,
  chargeType,
  chargedBy,
  accountType,
  serviceType,
  openStatus,
  priority,
}

class ProfileRepository {
  ProfileService profileService = ProfileService();
  // ProfileRepository({
  //   required this.profileService,
  // });
  static final ProfileRepository _singleton = ProfileRepository._internal();
  factory ProfileRepository() {
    return _singleton;
  }
  ProfileRepository._internal();

  Config? config;

  Future<ProfileModel> getProfile() async {
    final profileRaw = await profileService.getProfile();
    ProfileModel profile = ProfileModel.fromJson(profileRaw);
    return profile;
  }

  Future updateProfile({
    required firstName,
    required lastName,
    required email,
    required countryName,
    required industryName,
    required photo,
  }) async {
    Response res = await profileService.updateProfile(
      firstName,
      lastName,
      email,
      countryName,
      industryName,
      photo,
    );
    return res;
  }

  // get config
  Future getConfig() async {
    final raw = await profileService.getConfig();
    config = Config.fromJson(raw);
    return config;
  }

  List<OptionModel>? getConfigEnums({required EnumType type}) {
    List<OptionModel>? configEnum;
    if (config == null) {
      getConfig();
    }
    if (config != null) {
      configEnum = (config?.options.entries
          .firstWhere((element) => element.key == type.name)
          .value
          .map((e) => e))?.toList();
    }
    return configEnum;
  }
}
