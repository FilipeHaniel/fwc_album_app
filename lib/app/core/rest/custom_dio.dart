import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:fwc_album_app/app/core/config/env/env.dart';

class CustomDio extends DioForNative {
  CustomDio()
      : super(BaseOptions(
          baseUrl: Env.i['backend_base_url'] ?? '',
          connectTimeout: const Duration(milliseconds: 5000),
          receiveTimeout: const Duration(milliseconds: 60000),
        )) {
    interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  /// Para adicionar o interceptor que é responsável
  /// por fazer autenticação
  CustomDio auth() {
    return this;
  }

  /// Remover interceptor
  CustomDio unAuth() {
    return this;
  }
}
