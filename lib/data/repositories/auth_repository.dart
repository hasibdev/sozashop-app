import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sozashop_app/core/core.dart';
import 'package:sozashop_app/data/models/environment.dart';
import 'package:sozashop_app/data/repositories/secure_storage.dart';

class AuthRepository {
  AuthRepository._private();
  static final AuthRepository instance = AuthRepository._private();

  final String mainUrl = Environment.apiUrl;

  final String _tokenKey = 'token';
  final storage = SecureStorage();

  // find token
  Future<bool> hasToken() async {
    var value = await storage.readSecureData(_tokenKey);
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  // read token
  Future<dynamic> readToken() async {
    var value = await storage.readSecureData(_tokenKey);
    return value;
  }

  // save token
  Future<void> saveToken(String token) async {
    await storage.writeSecureData(_tokenKey, token);
  }

  // delete token
  Future<void> deleteToken(String token) async {
    await storage.deleteSecureData(_tokenKey);
  }

  // login
  Future login(String email, password) async {
    http.Response response = await http.post(
      Uri.parse(mainUrl + Strings.loginUrl),
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
      headers: headers,
    );
    var data = jsonDecode(response.body);
    print(data);
    print("expires_in >>>>> ${data['expires_in']}");
    if (response.statusCode == 200) {
      return data;
    }
  }

  // logout
  Future logout() async {
    try {
      http.Response response = await http.post(
        Uri.parse(mainUrl + Strings.logoutUrl),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data['message'];
      }
      print('Logged out');
    } catch (e) {
      print(e);
    }
  }

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // register
  Future register(
      String shopName,
      int moduleId,
      int industryId,
      String firstName,
      String lastName,
      dynamic mobile,
      String email,
      String password,
      String passwordConfirmation) async {
    // try {
    http.Response response = await http.post(
      Uri.parse(mainUrl + Strings.registerUrl),
      body: jsonEncode({
        'shopName': shopName,
        'moduleId': moduleId,
        'firstName': firstName,
        'lastName': lastName,
        'industryId': industryId,
        'mobile': mobile,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      }),
      headers: headers,
    );

    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return response.statusCode;
    }
  }
}
