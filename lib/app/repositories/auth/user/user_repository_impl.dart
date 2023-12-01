import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fwc_album_app/app/core/exceptions/repository_exception.dart';
import 'package:fwc_album_app/app/core/rest/custom_dio.dart';
import 'package:fwc_album_app/app/models/user_model.dart';
import 'package:fwc_album_app/app/repositories/auth/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final CustomDio _customDio;

  UserRepositoryImpl({required CustomDio customDio}) : _customDio = customDio;

  @override
  Future<UserModel> getMe() async {
    try {
      final result = await _customDio.auth().get('/api/me');

      return UserModel.fromMap(result.data);
    } on DioException catch (e, s) {
      log('Erro ao buscar dados do usuário logado', error: e, stackTrace: s);

      throw RepositoryException(
          message: 'Erro ao buscar dados do usuário logado');
    }
  }
}
