import 'package:sozashop_app/data/repositories/user_local_repositiory.dart';

import '../data/models/profile_model.dart';

final UserLocalRepository _userLocalRepository = UserLocalRepository();

class UserDetails {
  static ProfileModel? user;

  factory UserDetails() => UserDetails._internal();
  UserDetails._internal();

  static Future<void> getUser() async {
    var jsonUser = await _userLocalRepository.readUser();
    // ignore: await_only_futures
    user = await ProfileModel.fromRawJson(jsonUser);
    print(
        'Got the user >>>>>>>>> ${user?.userLastLogin}-${user?.userLastLogin.hashCode}');
  }
}
