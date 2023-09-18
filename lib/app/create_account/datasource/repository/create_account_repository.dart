import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_control/core/model/user_model.dart';

abstract class CreateAccountRepository {
  Future<UserModel> signUp(String email, String password);
  Future<DocumentReference> createHouse(List<UserModel> users);
  Future<void> joinHouse(String houseId, UserModel user);
}
