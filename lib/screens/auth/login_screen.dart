// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';

import '../../main.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';
import '../../utils/app_strings.dart';
import '../home_screen.dart';

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
     _isAnimate = true ;
    });
  });
}


  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      /// app bar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: AppColors.appBlackColor),
        title: Text(AppStrings.welcomeTO ,  style: TextStyle( color: AppColors.textPrimaryColor),),
      ),
      body: Stack(
        children: [
          /// icon logo 
          AnimatedPositioned(
            top: mq.height * .15,
            right: _isAnimate ? mq.width * .25 :  -mq.width * .5,
            width: mq.width * .5,
            child: Image.asset(AppImages.appLogo),
            duration: Duration(seconds: 1),
          ),

          /// button
          Positioned(
            bottom: mq.height * .15,
            left: mq.width * .05,
            width: mq.width * .9,
            height: mq.height * .07,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen(),),);
              },
              label: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: AppStrings.signInWith,
                      style: TextStyle(color: AppColors.appWhiteColor),
                    ),
                    TextSpan(
                      text: AppStrings.google,
                      style: TextStyle(color: AppColors.blue ,fontWeight: FontWeight.bold , fontSize: 18),
                    ),
                  ],
                ),
              ),
              icon: Image.asset(AppImages.google , height: mq.height * .04,),
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.textPrimaryColor, elevation: 1),
            ),
          ),
        ],
      ),
    );
  }
}
