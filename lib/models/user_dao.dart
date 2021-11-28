import 'package:cloud_firestore/cloud_firestore.dart';

class UserDao {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('users');

  Future<Map<String, dynamic>> getUserData(String uid) async {
    QuerySnapshot<Object?> query =
        await collection.where('uid', isEqualTo: uid).limit(1).get();
    return query.docs.first.data() as Map<String, dynamic>;
  }

  void addNewUser(String uid, String email, DateTime creationDate) {
    collection.add({
      'uid': uid,
      'email': email,
      'name': null,
      'creationDate': creationDate,
      'photoUrl': null,
      'bio': null,
    });
  }
}
