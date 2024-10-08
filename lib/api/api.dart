// ignore_for_file: constant_identifier_names, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/chat_user_model.dart';

class APIs {
  /// for auth
  static FirebaseAuth auth = FirebaseAuth.instance;

  /// for accessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// for return current user
  static User get user => auth.currentUser!;

  /// for storing self info.
  static late ChatUser me;

  /// for checking if user existing or not?
  static Future<bool> userExists() async {
    return (await firestore.collection("users").doc(user.uid).get()).exists;
  }

  /// for getting current user info.
  static Future<void> getSelfInfo() async {
    await firestore.collection("users").doc(user.uid).get().then((user) async {
      if (user.exists) {
        me = ChatUser.fromJson(user.data()!);
        debugPrint("My Data  ${user.data}");
      } else {
        await createUser().then((value) => getSelfInfo());
      }
    });
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
    return await firestore
        .collection("users")
        .doc(user.uid)
        .set(chatUser.toJson());
  }

  /// for getting all users from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return firestore
        .collection('users')
        .where("id", isNotEqualTo: user.uid)
        .snapshots();
  }

  /// for updating user info.
  static Future<void> updatingUserInfo() async {
    await firestore
        .collection("users")
        .doc(user.uid)
        .update({'name': me.name, 'about': me.about});
  }
}
