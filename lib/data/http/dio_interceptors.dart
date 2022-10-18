import 'package:dio/dio.dart';

import 'package:sozashop_app/data/repositories/auth_repository.dart';

class DioInterceptors extends Interceptor {
  AuthRepository authRepository = AuthRepository.instance;

  @override
  // ignore: unnecessary_overrides
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // print('REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  // ignore: unnecessary_overrides
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // print(
    //     'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    // print(
    //     'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');

    switch (err.type) {
      case DioErrorType.connectTimeout:
        {}
        break;
      case DioErrorType.sendTimeout:
        {}
        break;
      case DioErrorType.receiveTimeout:
        {}
        break;
      case DioErrorType.response:
        if (err.response?.statusCode == 401) {}
        break;
      case DioErrorType.cancel:
        {}
        break;
      case DioErrorType.other:
        {}
        break;
      // default:
    }
    super.onError(err, handler);
  }
}

// enum DioErrorType {
//   /// It occurs when url is opened timeout.
//   connectTimeout,

//   /// It occurs when url is sent timeout.
//   sendTimeout,

//   ///It occurs when receiving timeout.
//   receiveTimeout,

//   /// When the server response, but with a incorrect status, such as 404, 503...
//   response,

//   /// When the request is cancelled, dio will throw a error with this type.
//   cancel,

//   /// Default error type, Some other Error. In this case, you can
//   /// use the DioError.error if it is not null.
//   other,
// }
