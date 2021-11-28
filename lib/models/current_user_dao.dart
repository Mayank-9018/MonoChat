import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:monochat/models/exceptions.dart';
import 'package:monochat/models/user_dao.dart';

class CurrentUserDao {
  BuildContext context;
  CurrentUserDao(this.context);

  final auth = FirebaseAuth.instance;

  bool isLoggedIn() {
    return auth.currentUser != null;
  }

  String? userId() {
    return auth.currentUser?.uid;
  }

  Future<bool> signup(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Provider.of<UserDao>(context, listen: false).addNewUser(
          auth.currentUser!.uid,
          email,
          auth.currentUser!.metadata.creationTime as DateTime);
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
