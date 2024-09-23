import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'firebase_options.dart';
import 'my_app.dart';

late Size mq;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  /// for full screen splash screen
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    

    /// for setting  oreintation
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) {
    _initializeFireBase();
    runApp(const GuppeShappe());
  });
}

_initializeFireBase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
