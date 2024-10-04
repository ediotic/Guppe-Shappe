// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../api/api.dart';
import '../../main.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';
import '../../utils/app_strings.dart';
import '../auth/login_screen.dart';
import '../home/home_screen.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 2000), () {
      ///exit full screen
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(statusBarColor: Colors.transparent));

      /// user already login h
      if (APIs.auth.currentUser != null) {
        debugPrint("\n user ::: ${APIs.auth.currentUser}");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    /// media queary
    mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.appBlackColor,
      body: Stack(
        children: [
          /// icon logo
          Positioned(
            top: mq.height * .15,
            right: mq.width * .25,
            width: mq.width * .5,
            child: Image.asset(AppImages.appLogo),
          ),

          /// heading
          Positioned(
            bottom: mq.height * .15,
            width: mq.width,
            child: Text(
              textAlign: TextAlign.center,
              AppStrings.madeIn,
              style: TextStyle(
                  letterSpacing: .5,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.appWhiteColor),
            ),
          ),
        ],
      ),
    );
  }
}
