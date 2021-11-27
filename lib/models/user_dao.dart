import 'package:firebase_auth/firebase_auth.dart';
import 'package:monochat/models/exceptions.dart';

class UserDao {
  final auth = FirebaseAuth.instance;

  bool isLoggedIn() {
    return auth.currentUser != null;
  }

  String? userId() {
    return auth.currentUser?.uid;
  }

  String? email() {
    return auth.currentUser?.email;
  }

  String? name() {
    return auth.currentUser?.displayName;
  }

  String? photoUrl() {
    return auth.currentUser?.photoURL;
  }

  DateTime? creationDate() {
    return auth.currentUser?.metadata.creationTime;
  }

  Future<bool> signup(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUse();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmail();
      } else if (e.code == 'weak-password') {
        throw WeakPassword();
      } else if (e.code == 'network-request-failed') {
        throw NetworkRequestFailed();
      } else {
        throw Exception({e.message});
      }
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFound();
      } else if (e.code == 'wrong-password') {
        throw WrongCredentials();
      } else if (e.code == 'network-request-failed') {
        throw NetworkRequestFailed();
      } else if (e.code == 'too-many-requests') {
        throw TooManyRequests();
      } else {
        throw Exception({e.message});
      }
    }
  }

  void logout() async {
    await auth.signOut();
  }
}
