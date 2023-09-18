import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_control/core/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class CreateAccountData {
  Future<UserCredential> signUp(String email, String password);
  Future<DocumentReference> createHouse(List<UserModel> users);
  Future<void> joinHouse(String houseId, UserModel user);
}
