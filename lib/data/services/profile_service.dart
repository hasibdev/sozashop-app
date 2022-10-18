import 'dart:io';

import 'package:dio/dio.dart';

import '../http/dio_client.dart';

class ProfileService {
  final DioClient _dioClient = DioClient();

  // get profile
  Future getProfile() async {
    var response = await _dioClient.get(endPoint: "/profile");
    return response["data"];
  }

  // update profile
  updateProfile(String firstName, String lastName, String email,
      String countryName, String industryName, File? photo) async {
    FormData formData = FormData();
    if (photo == null) {
      formData = FormData.fromMap({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'countryName': countryName,
        'industryName': industryName,
      });
    } else {
      formData = FormData.fromMap({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'countryName': countryName,
        'industryName': industryName,
        'photo': await MultipartFile.fromFile(photo.path),
      });
    }
    Response response = await _dioClient.post(
      endPoint: '/profile',
      data: formData,
    );
    return response;
  }

  // get Config
  Future getConfig() async {
    Response response = await _dioClient.post(endPoint: "/users/config");
    return response.data;
  }

  // get Notifications
  Future getNotifications() async {
    var response = await _dioClient.get(endPoint: "/user/notifications");
    return response["data"];
  }
}
