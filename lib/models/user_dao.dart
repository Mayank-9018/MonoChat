import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserDao {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('users');
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<Map<String, dynamic>> getUserData(String uid) async {
    QuerySnapshot<Object?> query =
        await _collection.where('uid', isEqualTo: uid).limit(1).get();
    return query.docs.first.data() as Map<String, dynamic>;
  }

  Future<void> updateName(String uid, String name) async {
    var query = await _collection.where('uid', isEqualTo: uid).get();
    String docId = query.docs.first.id;
    _collection.doc(docId).update({'name': name});
  }

  Stream<TaskSnapshot> updateImage(String uid, Uint8List imgData) {
    UploadTask uploadTask =
        _storage.ref('user_images/$uid.jpeg').putData(imgData);
    uploadTask.then((p0) =>
        p0.ref.getDownloadURL().then((value) => _updatePhotoUrl(uid, value)));
    return uploadTask.snapshotEvents;
  }

  Future<void> _updatePhotoUrl(String uid, String photoUrl) async {
    var query = await _collection.where('uid', isEqualTo: uid).get();
    String docId = query.docs.first.id;
    _collection.doc(docId).update({'photoUrl': photoUrl});
  }

  void addNewUser(String uid, String email, DateTime creationDate) {
    _collection.add({
      'uid': uid,
      'email': email,
      'name': null,
      'creationDate': creationDate,
      'photoUrl': null,
      'bio': null,
    });
  }
}
