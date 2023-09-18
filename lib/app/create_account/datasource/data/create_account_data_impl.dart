import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_control/app/create_account/datasource/data/create_account_data.dart';
import 'package:finance_control/core/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class CreateAccountDataImpl implements CreateAccountData {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserCredential> signUp(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<DocumentReference> createHouse(List<UserModel> users) async {
    final CollectionReference house =
        FirebaseFirestore.instance.collection('house');

    var uuid = const Uuid();
    String houseId = uuid.v4();

    List<String> userIds = users.map((user) => user.id).toList();
    List<String> userNames = users.map((user) => user.name).toList();
    List<String> userEmails = users.map((user) => user.email).toList();

    DocumentReference houseRef = house.doc(houseId);
    await houseRef.set({
      'membrosIds': userIds,
      'membrosNomes': userNames,
      'membrosEmails': userEmails,
    });

    return houseRef;
  }

  @override
  Future<void> joinHouse(String houseId, UserModel user) async {
    final DocumentReference houseRef =
        FirebaseFirestore.instance.collection('house').doc(houseId);

    return FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot houseSnapshot = await transaction.get(houseRef);

      if (!houseSnapshot.exists) {
        throw Exception('Casa não encontrada!');
      }

      Map<String, dynamic> houseData =
          houseSnapshot.data() as Map<String, dynamic>;

      List<String> membrosIds = List<String>.from(houseData['membrosIds']);
      List<String> membrosNomes = List<String>.from(houseData['membrosNomes']);
      List<String> membrosEmails =
          List<String>.from(houseData['membrosEmails']);

      if (!membrosIds.contains(user.id)) {
        membrosIds.add(user.id);
        membrosNomes.add(user.name);
        membrosEmails.add(user.email);

        transaction.update(houseRef, {
          'membrosIds': membrosIds,
          'membrosNomes': membrosNomes,
          'membrosEmails': membrosEmails,
        });
      }
    });
  }
}
