import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/model/user_model.dart';
import '../data/create_account_data.dart';
import 'create_account_repository.dart';

class CreateAccountRepositoryImpl implements CreateAccountRepository {
  final CreateAccountData createAccountData;

  CreateAccountRepositoryImpl(this.createAccountData);

  @override
  Future<UserModel> signUp(String email, String password) async {
    final userCredential = await createAccountData.signUp(email, password);
    return UserModel(
      id: userCredential.user!.uid,
      email: userCredential.user!.email!,
      name: '',
    );
  }

  @override
  Future<DocumentReference<Object?>> createHouse(List<UserModel> users) {
    return createAccountData.createHouse(users);
  }
  
  @override
  Future<void> joinHouse(String houseId, UserModel user) {
    return createAccountData.joinHouse(houseId, user);
  }

  @override
  Future<UserCredential?> loginWithGoogle() {
    return createAccountData.loginWithGoogle();
  }
}
