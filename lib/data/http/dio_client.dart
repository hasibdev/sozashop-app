import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/data/http/dio_interceptors.dart';
import 'package:sozashop_app/data/models/environment.dart';
import 'package:sozashop_app/data/repositories/auth_repository.dart';
import 'package:sozashop_app/data/repositories/secure_storage.dart';
import 'package:sozashop_app/logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:sozashop_app/logic/bloc/login_bloc/login_bloc.dart';
import 'package:sozashop_app/presentation/screens/auth_screens/login_screen.dart';

AuthRepository authRepository = AuthRepository.instance;
AuthenticationBloc authenticationBloc =
    AuthenticationBloc(authRepository: authRepository);

class DioClient {
  final Dio _dio = Dio();
  final apiUrl = Environment.apiUrl;
  final storage = SecureStorage();
  DioInterceptors dioInterceptors = DioInterceptors();

  LoginBloc loginBloc = LoginBloc(
      authRepository: authRepository, authenticationBloc: authenticationBloc);

  final Map<String, String> _headers = <String, String>{
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Get request
  Future<dynamic> get({required String endPoint}) async {
    final fullUrl = apiUrl + endPoint;
    var value = await authRepository.readToken();
    _headers['Authorization'] = 'Bearer $value';
    try {
      _dio.interceptors.add(dioInterceptors);
      final Response response = await _dio.get(
        fullUrl,
        options: Options(headers: _headers),
      );
      // debugPrint(response.toString());

      return response.data;
    } on DioError catch (e) {
      _dio.interceptors.add(dioInterceptors);
      debugPrint('debug ${e.response?.statusCode}');
      if (e.response?.statusCode == 401) {
        // loginBloc.add(LoggingOut());
        return BlocProvider.value(
          value: LoginBloc(
              authRepository: authRepository,
              authenticationBloc: authenticationBloc)
            ..add(LoggingOut()),
          child: LoginScreen(),
        );
      }
      throw Exception(e);
    }
  }

  // Post request
  Future post({dynamic endPoint, dynamic data}) async {
    final fullUrl = apiUrl + endPoint;
    var value = await authRepository.readToken();
    _headers['Authorization'] = 'Bearer $value';

    try {
      final Response response = await _dio.post(
        fullUrl,
        data: data,
        options: Options(headers: _headers),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      }
      print('e.response?.statusCode ${response.statusCode}');
    } on DioError catch (e) {
      print('e.response?.statusCode ${e.response?.statusCode}');
      if (e.response?.statusCode == 401) {
        // loginBloc.add(LoggingOut());
        print('whatttttttttttttttt');
        BlocProvider.value(
          value: LoginBloc(
              authRepository: authRepository,
              authenticationBloc: authenticationBloc)
            ..add(LoggingOut()),
          child: LoginScreen(),
        );
        return LoginScreen();
        // @override
        // Widget build(BuildContext context) {
        //   Navigator.pushNamedAndRemoveUntil(
        //       context, AppRouter.home, (route) => false);
        //   return BlocProvider.value(
        //     value: BlocProvider.of<LoginBloc>(context)..add(LoggingOut()),
        //     child: const MainScreen(),
        //   );
        // }

        // Navigator.pushNamedAndRemoveUntil(
        //     context, newRouteName, (route) => false);
        // return BlocProvider.value(
        //   value: LoginBloc(
        //       authRepository: authRepository,
        //       authenticationBloc: authenticationBloc)
        //     ..add(LoggingOut()),
        //   child: const MainScreen(),
        // );
      }
      return e.response;
    }
  }

  // Update request
  Future update({dynamic endPoint, dynamic data}) async {
    final fullUrl = apiUrl + endPoint;
    var value = await authRepository.readToken();
    _headers['Authorization'] = 'Bearer $value';
    try {
      final Response response = await _dio.put(
        fullUrl,
        data: data,
        options: Options(headers: _headers),
      );
      // debugPrint(response.toString());
      return response;
    } on DioError catch (e) {
      debugPrint(e.message);
      // throw Exception('Failed to update data');
      return e.response;
    }
  }

  // delete request
  Future delete({dynamic endPoint}) async {
    final fullUrl = apiUrl + endPoint;
    var value = await authRepository.readToken();
    _headers['Authorization'] = 'Bearer $value';

    try {
      final Response response = await _dio.delete(
        fullUrl,
        options: Options(headers: _headers),
      );
      debugPrint(response.toString());
      return response;
    } on DioError catch (e) {
      debugPrint(e.message);
      return e.response;
      // throw Exception('Failed to delete data');
    }
  }
}
