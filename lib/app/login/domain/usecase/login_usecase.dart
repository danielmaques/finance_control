import 'package:finance_control/core/model/user_model.dart';

abstract class LoginUseCase {
  Future<UserModel> login(String email, String password);
  Future<String?> findHouseIdByUserId(String userId);
}
