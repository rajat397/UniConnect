import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String username;
  final String email;
  final String password;

  const User({
    required this.email,
    required this.uid,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "password": password,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot['username'],
      password: snapshot['password'],
      email: snapshot['email'],
      uid: snapshot['uid'],
    );
  }
}
