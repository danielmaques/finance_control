import 'package:finance_control/app/login/datasource/repository/login_repository.dart';
import 'package:finance_control/app/login/domain/usecase/login_usecase.dart';
import 'package:finance_control/core/model/user_model.dart';

class LoginUseCaseImpl implements LoginUseCase {
  final LoginRepository loginRepository;

  LoginUseCaseImpl(this.loginRepository);

  @override
  Future<UserModel> login(String email, String password) async {
    return await loginRepository.login(email, password);
  }

  @override
  Future<String?> findHouseIdByUserId(String userId) {
    return loginRepository.findHouseIdByUserId(userId);
  }
  
  @override
  Future<void> resetPassword(String email) {
    return loginRepository.resetPassword(email);
  }
}
