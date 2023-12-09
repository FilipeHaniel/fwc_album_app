import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fwc_album_app/app/core/exceptions/repository_exception.dart';
import 'package:fwc_album_app/app/core/rest/custom_dio.dart';
import 'package:fwc_album_app/app/models/groups_stickers.dart';
import 'package:fwc_album_app/app/repositories/stickers/stickers_repository.dart';

class StickersRepositoryImpl implements StickersRepository {
  final CustomDio _dio;

  StickersRepositoryImpl({required CustomDio dio}) : _dio = dio;

  @override
  Future<List<GroupsStickers>> getMyAlbum() async {
    try {
      final result = await _dio.auth().get('/api/countries');

      return result.data
          .map<GroupsStickers>((g) => GroupsStickers.fromMap(g))
          .toList();
    } on DioException catch (e, s) {
      log('Erro ao  buscar álbum do usuário', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar album do usuário');
    }
  }
}
