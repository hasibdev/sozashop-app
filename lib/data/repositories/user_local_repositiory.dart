import 'package:sozashop_app/data/repositories/secure_storage.dart';

class UserLocalRepository {
  final String _userKey = 'user';
  final storage = SecureStorage();

  // read user
  Future<dynamic> readUser() async {
    var value = await storage.readSecureData(_userKey);
    return value;
  }

  // save user
  Future<void> saveUser(String user) async {
    await storage.writeSecureData(_userKey, user);
  }

  // delete user
  Future<void> deleteUser(String user) async {
    await storage.deleteSecureData(_userKey);
  }
}
