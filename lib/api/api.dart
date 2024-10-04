// ignore_for_file: constant_identifier_names, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/chat_user_model.dart';

class APIs {
  /// for auth
  static FirebaseAuth auth = FirebaseAuth.instance;

  /// for accessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// for return current user
  static User get user => auth.currentUser!;

  /// for checking if user existing or not?
  static Future<bool> userExists() async {
    return (await firestore.collection("users").doc(user.uid).get()).exists;
  }

  /// for creating a new user
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final chatUser = ChatUser(
      id: user.uid,
      name: user.displayName.toString(),
      email: user.email.toString(),
      about: "Hey I'm feeling happy!",
      image: user.photoURL.toString(),
      createdAt: time,
      isOnline: false,
      lastActive: time,
      pushToken: "",
    );
    return await firestore.collection("users").doc(user.uid).set(chatUser.toJson());

  }
}
