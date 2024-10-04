// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../main.dart';
import '../../models/chat_user_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_strings.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUser user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    debugPrint('Image URL: ${widget.user.image}');
    debugPrint('Image URLlllslslslsllslslslslslslslsllsls:');
    return Scaffold(
        backgroundColor: AppColors.appWhiteColor,

        /// app bar
        appBar: AppBar(
          elevation: 0.5,
          iconTheme: IconThemeData(color: AppColors.appBlackColor),
          title: Text(
            AppStrings.profileScreen,
            style: TextStyle(color: AppColors.textPrimaryColor),
          ),
        ),

        /// floating action button
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 18, right:5),
          child: FloatingActionButton.extended(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            backgroundColor: AppColors.red,
            onPressed: () async {
              //// signout

              await FirebaseAuth.instance.signOut();
              await GoogleSignIn().signOut();
            },
            icon: Icon(Icons.logout_rounded,
                size: 30, color: AppColors.greyLight),
            label: Text(
              AppStrings.logOut,
              style: TextStyle(color: AppColors.greyLight),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: mq.width,
                  height: mq.height * .03,
                ),

                // ClipRRect(
                //   borderRadius: BorderRadius.circular(mq.height * .3),
                //   child: CachedNetworkImage(
                //     width: mq.width * 0.120,
                //     height: mq.height * 0.150,
                //          imageUrl: widget.user.image.isNotEmpty ? widget.user.image : ' https://lh3.googleusercontent.com/a/ACg8ocIADK0VfY7f9ngbAyKHFfKqi-4VPWRP6LLjnPGiT15WjyBUqa2qAQ=s96-c',

                //           errorWidget: (context, url, error) =>  CircleAvatar(
                //     child: Icon(CupertinoIcons.person),
                //   ),
                //        ),
                // ),

                CircleAvatar(
                  radius: mq.width * .18,
                  child: Icon(CupertinoIcons.person),
                ),

                SizedBox(
                  height: mq.height * .03,
                ),

                Text(
                  widget.user.email,
                  style: TextStyle(
                      fontSize: 15, color: AppColors.textSecondaryColor),
                ),

                SizedBox(
                  height: mq.height * .05,
                ),

                TextFormField(
                  initialValue: widget.user.name,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: AppColors.textSecondaryColor,
                      ),
                      hintText: ' eg. Happy Singh',
                      label: Text(AppStrings.name),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0))),
                ),
                SizedBox(
                  height: mq.height * .03,
                ),
                TextFormField(
                  initialValue: widget.user.about,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.info_outline,
                        color: AppColors.textSecondaryColor,
                      ),
                      hintText: 'eg. feeling happy',
                      label: Text(AppStrings.about),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0))),
                ),
                  SizedBox(
                  height: mq.height * .03,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.skyBlue,
                    minimumSize: Size(mq.width * .5, mq.height * .06),

                  ),
                  onPressed: (){}, 
                icon: Icon(Icons.edit , size: 30, color: AppColors.blue,),
                 label: Text(AppStrings.update , style: TextStyle(color: AppColors.blue , fontSize:16),),)
              ],
            ),
          ),
        ));
  }
}
