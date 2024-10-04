// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:guppe_shappe/utils/app_colors.dart';

class Dialogs {
  static void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: AppColors.errorLightColor.withOpacity(.9),
      behavior: SnackBarBehavior.floating,
    )
    );
  }
  static void showProgressIndigator(BuildContext context) {
   showDialog(context: context, builder: (_) => Center(child: CircularProgressIndicator()));
      
   
  }
}
