import 'dart:developer';

import 'package:fwc_album_app/app/core/exceptions/unauthorized_exception.dart';
import 'package:fwc_album_app/app/pages/auth/login/presenter/login_presenter.dart';
import 'package:fwc_album_app/app/pages/auth/login/view/login_view.dart';
import 'package:fwc_album_app/app/services/login/login_service.dart';

class LoginPresenterImpl implements LoginPresenter {
  final LoginService _loginService;

  late final LoginView _view;

  LoginPresenterImpl({required LoginService loginService})
      : _loginService = loginService;

  @override
  Future<void> login(String email, String password) async {
    try {
      await _loginService.execute(email: email, password: password);
      _view.success();
    } on UnauthorizedException catch (e, s) {
      _view.error('Usuário ou senha inválidos');
    } catch (e, s) {
      log('Erro ao realizar login', error: e, stackTrace: s);
      _view.error('Erro ao realizar login');
    }
  }

  @override
  set view(LoginView view) => _view = view;
}
