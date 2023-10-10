import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IGetSpentData {
  Future<Map<String, double>> call(String uid);
}

class GetSpentData implements IGetSpentData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Map<String, double>> call(String uid) {
    // TODO: implement getTotalSpentByCategory
    throw UnimplementedError();
  }
}
