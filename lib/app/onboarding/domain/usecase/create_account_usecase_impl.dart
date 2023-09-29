import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/model/user_model.dart';
import '../../datasource/repository/create_account_repository.dart';
import 'create_account_usecase.dart';

class CreateAccountUseCaseImpl implements CreateAccountUseCase {
  final CreateAccountRepository createAccountRepository;

  CreateAccountUseCaseImpl(this.createAccountRepository);

  @override
  Future<UserModel> signUp(String email, String password) async {
    return await createAccountRepository.signUp(email, password);
  }

  @override
  Future<DocumentReference<Object?>> createHouse(List<UserModel> users) {
    return createAccountRepository.createHouse(users);
  }
  
  @override
  Future<void> joinHouse(String houseId, UserModel user) {
    return createAccountRepository.joinHouse(houseId, user);
  }
}
