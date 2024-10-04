// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_element, use_build_context_synchronously



import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../api/api.dart';
import '../../main.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';
import '../../utils/app_strings.dart';
import '../../helper/dialogs.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAnimate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isAnimate = true;
      });
    });
  }

  void _handleGoogleBtnClick() {
    /// show progress indigator
  Dialogs.showProgressIndigator(context);
    _signInWithGoogle().then((user) async {

      /// for hiding progressindiagtor
      Navigator.pop(context);
      if (user != null) {
        debugPrint("\n user ::: ${user.user}");
        debugPrint("\n userAdditonalInfo ::: ${user.additionalUserInfo}");

        if((await APIs.userExists() )){
           Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
        }else{
         await APIs.createUser().then((value){
             Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
         } );
        }
      
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      /// Check internet connection
      await InternetAddress.lookup("google.com");

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // If the user cancels the login, return null
      if (googleUser == null) {
        Dialogs.showSnackBar(context, 'Sign in aborted by user');
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      return await APIs.auth.signInWithCredential(credential);
    } catch (e) {
      debugPrint("\n _signInWithGoogle ::: $e");
      Dialogs.showSnackBar(context, AppStrings.netError);
      return null;
    }
  }

    //// signout
    // _signOut() async{
    //    await FirebaseAuth.instance.signOut();
    //    await GoogleSignIn().signOut();
    // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: AppColors.appBlackColor),
        title: Text(AppStrings.welcomeTO, style: TextStyle(color: AppColors.textPrimaryColor)),
      ),
      body: Stack(
        children: [
          /// App logo with animation
          AnimatedPositioned(
            top: mq.height * .10,
            right: _isAnimate ? mq.width * .27 : -mq.width * .3,
            width: mq.width * .4,
            child: Image.asset(AppImages.appLogo),
            duration: Duration(seconds: 1),
          ),

          /// Sign-in button
          Positioned(
            bottom: mq.height * .15,
            left: mq.width * .05,
            width: mq.width * .9,
            height: mq.height * .07,
            child: ElevatedButton.icon(
              onPressed: _handleGoogleBtnClick,
              label: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: AppStrings.signInWith,
                      style: TextStyle(color: AppColors.appWhiteColor),
                    ),
                    TextSpan(
                      text: AppStrings.google,
                      style: TextStyle(
                        color: AppColors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              icon: Image.asset(AppImages.google, height: mq.height * .04),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.textPrimaryColor,
                elevation: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

