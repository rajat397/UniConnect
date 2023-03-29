import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uniconnect/models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = auth.currentUser!;

    DocumentSnapshot snap =
        await firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  //sign up user

  Future<String> signUpUser({
    required String username,
    required String email,
    required String password,
    // required Uint8List file,
  }) async {
    String res = "Some error occurred";

    try {
      if (email.isNotEmpty && username.isNotEmpty && password.isNotEmpty) {
        //register user
        UserCredential cred = await auth.createUserWithEmailAndPassword(
            email: email, password: password);

        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          password: password,
        );
        //add user to our database
        await firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );

        res = "Success";
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  // logging in user
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await auth.signInWithEmailAndPassword(email: email, password: password);
        res = "Success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
