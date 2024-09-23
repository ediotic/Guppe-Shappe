import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'my_app.dart';

late Size mq;

void main() {
  runApp(const GuppeShappe ());
  _initializeFireBase();
}

_initializeFireBase() async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
}
