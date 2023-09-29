import 'package:finance_control/app/onboarding/datasource/data/login_data.dart';
import 'package:finance_control/app/onboarding/datasource/repository/login_repository.dart';
import 'package:finance_control/core/model/user_model.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginData loginData;

  LoginRepositoryImpl(this.loginData);

  @override
  Future<UserModel> login(String email, String password) async {
    final userCredential = await loginData.login(email, password);
    return UserModel(
      id: userCredential.user!.uid,
      name: '',
      email: userCredential.user!.email!,
    );
  }
  
  @override
  Future<String?> findHouseIdByUserId(String userId) {
    return loginData.findHouseIdByUserId(userId);
  }
  
  @override
  Future<void> resetPassword(String email) {
    return loginData.resetPassword(email);
  }
}
