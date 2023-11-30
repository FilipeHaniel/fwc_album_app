import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:fwc_album_app/app/core/config/env/env.dart';
import 'package:fwc_album_app/app/core/rest/interceptors/auth_interceptor.dart';

class CustomDio extends DioForNative {
  final _authInterceptor = AuthInterceptor();

  CustomDio()
      : super(BaseOptions(
          baseUrl: Env.i['backend_base_url'] ?? '',
          connectTimeout: const Duration(milliseconds: 5000),
          receiveTimeout: const Duration(milliseconds: 60000),
        )) {
    interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      requestHeader: true,
    ));
  }

  /// Para adicionar o interceptor que é responsável
  /// por fazer autenticação
  CustomDio auth() {
    interceptors.add(_authInterceptor);

    return this;
  }

  /// Remover interceptor
  CustomDio unAuth() {
    interceptors.remove(_authInterceptor);

    return this;
  }
}
