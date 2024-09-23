// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';


import 'screens/auth/login_screen.dart';
import 'utils/app_colors.dart';
import 'utils/app_strings.dart';

class GuppeShappe extends StatelessWidget {
  const GuppeShappe({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.myAppName,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 1,
          titleTextStyle: TextStyle(
              color: AppColors.appBlackColor,
              fontWeight: FontWeight.normal,
              fontSize: 20),
          backgroundColor: AppColors.appWhiteColor,
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
