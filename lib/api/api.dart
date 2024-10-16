// ignore_for_file: constant_identifier_names, unused_local_variable

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import '../models/chat_user_model.dart';

class APIs {
  /// for auth
  static FirebaseAuth auth = FirebaseAuth.instance;

  /// for accessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// for accessing cloud firestore storage
  static FirebaseStorage storage = FirebaseStorage.instance;

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


  /// update profile picture of user
  static Future<void> updateProfilePicture(File file) async {

    /// getting image file extension
    final ext = file.path.split('.').last;
    debugPrint('Extension: $ext');

    /// storage file ref with path 
    final ref = storage.ref().child('profile_pictures/${user.uid}.$ext');

    /// uploading image 
    await ref.putFile(file, SettableMetadata(contentType: 'image/$ext'))
    .then((p0) {
      debugPrint('Data transferred: ${p0.bytesTransferred / 1000 } kb');
    });
    /// uploading image in firestore database
    me.image =await ref.getDownloadURL();
       await firestore
        .collection("users")
        .doc(user.uid)
        .update({'image': me.image});
  }
}
