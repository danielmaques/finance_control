import 'package:finance_control/core/model/user_model.dart';

abstract class LoginRepository {
  Future<UserModel> login(String email, String password);
  Future<String?> findHouseIdByUserId(String userId);

}
