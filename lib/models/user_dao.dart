import 'package:cloud_firestore/cloud_firestore.dart';

class UserDao {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('users');
  Future<QuerySnapshot<Object?>> getUserDate(String uid) {
    return collection.where('uid', isEqualTo: uid).limit(1).get();
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
