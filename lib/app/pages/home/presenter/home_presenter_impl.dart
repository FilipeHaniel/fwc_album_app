import 'package:fwc_album_app/app/pages/home/presenter/home_presenter.dart';
import 'package:fwc_album_app/app/pages/home/view/home_view.dart';
import 'package:fwc_album_app/app/repositories/auth/user/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePresenterImpl implements HomePresenter {
  final UserRepository _userRepository;

  late HomeView _view;

  HomePresenterImpl({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<void> getUserData() async {
    try {
      final user = await _userRepository.getMe();

      _view.updateUser(user);
    } catch (e) {
      _view.error('Erro ao buscar dados do usuário');
    }
  }

  @override
  Future<void> logout() async {
    _view.showLoader();

    final sp = await SharedPreferences.getInstance();
    sp.clear();

    _view.logoutSuccess();
  }

  @override
  set view(HomeView view) => _view = view;
}
