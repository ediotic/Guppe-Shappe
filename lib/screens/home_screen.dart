// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_strings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      /// app bar
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.appBlackColor),
        title: Text(AppStrings.myAppName ,  style: TextStyle( color: AppColors.textPrimaryColor),),
        leading: Icon(CupertinoIcons.home),
        actions: [
           IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.search)),
           IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.ellipsis_vertical)),
         ],
      ),

      /// floating action button
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 28, right: 10),
        child: FloatingActionButton(
          shape: CircleBorder(),
          backgroundColor: AppColors.green,
          onPressed: () {},
          child: Icon(Icons.add_comment_rounded,
              size: 30, color: AppColors.greyLight),
        ),
      ),
    );
  }
}
