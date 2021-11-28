import 'package:cloud_firestore/cloud_firestore.dart';

class UserDao {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('users');

  Future<Map<String, dynamic>> getUserData(String uid) async {
    QuerySnapshot<Object?> query =
        await collection.where('uid', isEqualTo: uid).limit(1).get();
    return query.docs.first.data() as Map<String, dynamic>;
  }

  Future<void> updateName(String uid, String name) async {
    var query = await collection.where('uid', isEqualTo: uid).get();
    String docId = query.docs.first.id;
    collection.doc(docId).update({'name': name});
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
