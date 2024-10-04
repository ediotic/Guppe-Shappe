// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../api/api.dart';
import '../../models/chat_user_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_strings.dart';
import '../../widgets/chat_user_card.dart';
import '../proflie/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatUser> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appWhiteColor,

      /// app bar
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.appBlackColor),
        title: Text(
          AppStrings.myAppName,
          style: TextStyle(color: AppColors.textPrimaryColor),
        ),
        leading: Icon(CupertinoIcons.home),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.search)),
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen(user: list[0],)));
              }, icon: Icon(CupertinoIcons.ellipsis_vertical)),
        ],
      ),

      /// floating action button
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 28, right: 10),
        child: FloatingActionButton(
          shape: CircleBorder(),
          backgroundColor: AppColors.green,
          onPressed: () async {
            //// signout

            await FirebaseAuth.instance.signOut();
            await GoogleSignIn().signOut();
          },
          child: Icon(Icons.add_comment_rounded,
              size: 30, color: AppColors.greyLight),
        ),
      ),

      body: StreamBuilder(
        stream: APIs.firestore.collection('users').snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            /// if data is loading
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const Center(child: CircularProgressIndicator());

            /// if some or all data is loaded then show it
            case ConnectionState.active:
            case ConnectionState.done:
              final data = snapshot.data?.docs;
              list =
                  data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];

              if (list.isNotEmpty) {
                return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return ChatUserCard(
                        user: list[index],
                      );
                      // return Text("Name: ${list[index]}");
                    });
              } else {
                return Center(
                    child: Text(
                  "No Connections Found!",
                  style: TextStyle(fontSize: 20, color: AppColors.errorColor),
                ));
              }
          }
        },
      ),
    );
  }
}
