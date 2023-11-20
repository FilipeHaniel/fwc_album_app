import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fwc_album_app/app/core/exceptions/repository_exception.dart';
import 'package:fwc_album_app/app/core/exceptions/unauthorized_exception.dart';
import 'package:fwc_album_app/app/core/rest/custom_dio.dart';
import 'package:fwc_album_app/app/models/register_user_model.dart';
import 'package:fwc_album_app/app/repositories/auth/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final CustomDio _dio;

  AuthRepositoryImpl({required CustomDio dio}) : _dio = dio;

  @override
  Future<String> login(
      {required String email, required String password}) async {
    try {
      final result = await _dio.post('/api/auth', data: {
        'email': email,
        'password': password,
      });

      final accessToken = result.data['access_token'];

      if (accessToken == null) {
        throw UnauthorizedException();
      }

      return accessToken;
    } on DioException catch (e, s) {
      log('Erro ao realizar login', error: e, stackTrace: s);

      final errorCode = e.response?.statusCode;

      if (errorCode == 401) {
        throw UnauthorizedException();
      }

      throw RepositoryException(message: 'Erro ao realizar login $errorCode');
    }
  }

  @override
  Future<void> logout() {
    throw UnimplementedError();
  }

  @override
  Future<void> register(RegisterUserModel registerModel) async {
    try {
      await _dio.unAuth().post(
            '/api/register',
            data: registerModel.toMap(),
          );
    } on DioException catch (e, s) {
      log('Erro ao registrar usuário', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao registrar usuário');
    }
  }
}
