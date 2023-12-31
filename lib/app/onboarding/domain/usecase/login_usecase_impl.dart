import 'package:finance_control/app/onboarding/datasource/repository/login_repository.dart';
import 'package:finance_control/app/onboarding/domain/usecase/login_usecase.dart';
import 'package:finance_control/core/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  @override
  Future<UserCredential?> loginWithGoogle() {
    return loginRepository.loginWithGoogle();
  }
}
