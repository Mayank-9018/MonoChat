import 'package:firebase_auth/firebase_auth.dart';
//TODO: Do proper error handling on login and signup

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

  void signup(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);
      //   if (e.code == 'weak-password') {
      //     print('The password provided is too weak.');
      //   } else if (e.code == 'email-already-in-use') {
      //     print('The account already exists for that email.');
      //   }
      // } catch (e) {
      //   print(e);
      // }
    }
  }

  void login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);
      //   if (e.code == 'weak-password') {
      //     print('The password provided is too weak.');
      //   } else if (e.code == 'email-already-in-use') {
      //     print('The account already exists for that email.');
      //   }
      // } catch (e) {
      //   print(e);
      // }
    }
  }

  void logout() async {
    await auth.signOut();
  }
}
