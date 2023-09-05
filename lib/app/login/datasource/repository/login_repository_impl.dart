import 'package:finance_control/app/login/datasource/data/login_data.dart';
import 'package:finance_control/app/login/datasource/repository/login_repository.dart';
import 'package:finance_control/core/model/user_model.dart';

class LoginRepositoryImp implements LoginRepository {
  final LoginData loginData;

  LoginRepositoryImp(this.loginData);

  @override
  Future<UserModel> login(String email, String password) async {
    final userCredential = await loginData.login(email, password);
    return UserModel(
      id: userCredential.user!.uid,
      email: userCredential.user!.email!,
    );
  }
}
