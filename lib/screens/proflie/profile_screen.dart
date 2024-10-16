// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unused_field, unused_element, prefer_const_literals_to_create_immutables
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:guppe_shappe/utils/app_images.dart';
import 'package:image_picker/image_picker.dart';

import '../../api/api.dart';
import '../../helper/dialogs.dart';
import '../../main.dart';
import '../../models/chat_user_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_strings.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUser user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _image;

  @override
  Widget build(BuildContext context) {
    debugPrint('Image URL: ${widget.user.image}');
    debugPrint('Image URLlllslslslsllslslslslslslslsllsls:');

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus,
      child: Scaffold(
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
            padding: EdgeInsets.only(bottom: 18, right: 5),
            child: FloatingActionButton.extended(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              backgroundColor: AppColors.red,
              onPressed: () async {
                Dialogs.showProgressIndigator(context);

                //// signout

                await APIs.auth.signOut().then((value) async {
                  await GoogleSignIn().signOut().then((value) {
                    /// for hiding progress indigator
                    Navigator.pop(context);

                    /// for moving to home screen
                    Navigator.pop(context);

                    /// replacing homescreen to login screen
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => LoginScreen()));
                  });
                });
              },
              icon: Icon(Icons.logout_rounded,
                  size: 30, color: AppColors.greyLight),
              label: Text(
                AppStrings.logOut,
                style: TextStyle(color: AppColors.greyLight),
              ),
            ),
          ),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: mq.width,
                      height: mq.height * .03,
                    ),

                    Stack(
                      children: [
                        /// profile picture
                        // _image != null ?

                        //           ClipRRect(
                        //             borderRadius: BorderRadius.circular(mq.height * .3),
                        //             child: Image.file(
                        //               File(_image!),
                        //               width: mq.width * 0.120,
                        //               height: mq.height * 0.150,
                        //               fit: BoxFit.cover,
                        //             ),
                        //                  )

                        //            :
                        //           // server image
                        //           ClipRRect(
                        //             borderRadius: BorderRadius.circular(mq.height * .3),
                        //             child: CachedNetworkImage(
                        //               width: mq.width * 0.120,
                        //               height: mq.height * 0.150,
                        //                 fit: BoxFit.cover,
                        //                    imageUrl: widget.user.image.isNotEmpty ? widget.user.image : ' https://lh3.googleusercontent.com/a/ACg8ocIADK0VfY7f9ngbAyKHFfKqi-4VPWRP6LLjnPGiT15WjyBUqa2qAQ=s96-c',

                        //                     errorWidget: (context, url, error) =>  CircleAvatar(
                        //               child: Icon(CupertinoIcons.person),
                        //             ),
                        //                  ),
                        //           ) ,

                        /// profile picture
                        CircleAvatar(
                          radius: mq.width * .18,
                          child: Icon(CupertinoIcons.person),
                        ),

                        /// edit button
                        Positioned(
                          bottom: 0,
                          left: 80,
                          child: MaterialButton(
                            elevation: 1,
                            shape: CircleBorder(),
                            color: AppColors.appWhiteColor,
                            onPressed: () {
                              _showBottomSheet();
                            },
                            child: Icon(
                              Icons.edit,
                              color: AppColors.primaryLightColor,
                            ),
                          ),
                        )
                      ],
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

                    /// name textField
                    TextFormField(
                      initialValue: widget.user.name,
                      onSaved: (val) => APIs.me.name = val ?? '',
                      validator: (val) => val != null && val.isNotEmpty
                          ? null
                          : "fields are not empty",
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

                    /// about textField
                    TextFormField(
                      initialValue: widget.user.about,
                      onSaved: (val) => APIs.me.about = val ?? '',
                      validator: (val) => val != null && val.isNotEmpty
                          ? null
                          : "fields are not empty",
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.info_outline,
                          color: AppColors.textSecondaryColor,
                        ),
                        hintText: 'eg. feeling happy',
                        label: Text(AppStrings.about),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                      ),
                    ),
                    SizedBox(
                      height: mq.height * .03,
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.skyBlue,
                        minimumSize: Size(mq.width * .5, mq.height * .06),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          APIs.updatingUserInfo().then((value) {
                            Dialogs.showSnackBar(
                                context, "Profile updated successfully");
                          });
                        }
                      },
                      icon: Icon(
                        Icons.edit,
                        size: 30,
                        color: AppColors.blue,
                      ),
                      label: Text(
                        AppStrings.update,
                        style: TextStyle(color: AppColors.blue, fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }

  /// bottom sheet for choosing the profile pictures
  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            padding:
                EdgeInsets.only(top: mq.height * .04, bottom: mq.height * .05),
            children: [
              Text(
                AppStrings.chooseProfilePicture,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimaryColor),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: mq.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      backgroundColor: AppColors.appWhiteColor,
                      fixedSize: Size(mq.width * 0.3, mq.height * .15),
                    ),
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();

                      /// Pick an image.
                      final XFile? image =
                          await picker.pickImage(source: ImageSource.gallery , imageQuality: 80);
                      if (image != null) {
                        debugPrint(
                            " image path: ${image.path} ----- MineType: ${image.mimeType}");
                        setState(() {
                          _image = image.path;
                        });

                        APIs.updateProfilePicture(File(_image!));

                        /// for hiding bottom sheet
                        Navigator.pop(context);
                      }
                    },
                    child: Image.asset(AppImages.gallery),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      backgroundColor: AppColors.appWhiteColor,
                      fixedSize: Size(mq.width * 0.3, mq.height * .15),
                    ),
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();

                      /// Pick an image.
                      final XFile? image =
                          await picker.pickImage(source: ImageSource.camera , imageQuality: 80);
                      if (image != null) {
                        debugPrint(" image path: ${image.path}");
                        setState(() {
                          _image = image.path;
                        });
                        APIs.updateProfilePicture(File(_image!));

                        /// for hiding bottom sheet
                        Navigator.pop(context);
                      }
                    },
                    child: Image.asset(AppImages.camera),
                  ),
                ],
              ),
              SizedBox(
                height: mq.height * 0.02,
              ),
            ],
          );
        });
  }
}
