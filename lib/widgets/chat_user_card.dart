// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../main.dart';
import '../models/chat_user_model.dart';
import '../utils/app_colors.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser user;

  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.appWhiteColor,
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(0.00)),
      margin: EdgeInsets.symmetric(vertical:3 ),
       child: InkWell(
        onTap: (){},
         child: ListTile(
           
          leading: CircleAvatar(
            radius: mq.width * .06,
            child: Icon(CupertinoIcons.person),
          ),
          // leading: ClipRRect(
          //   borderRadius: BorderRadius.circular(mq.height * .3),
          //   child: CachedNetworkImage(
          //     width: mq.width * 0.12,
          //     height: mq.height * 0.15,
          //           imageUrl: widget.user.image,
          //           errorWidget: (context, url, error) =>  CircleAvatar(
          //     child: Icon(CupertinoIcons.person),
          //   ),
          //        ),
          // ),

           title: Text( widget.user.name,style: TextStyle( color: AppColors.appBlackColor , fontSize:16 , fontWeight: FontWeight.w500),),
           subtitle: Text(widget.user.about , maxLines: 1,style: TextStyle( color: AppColors.greyDark , fontSize:13 , fontWeight: FontWeight.w500),),
          //  trailing: Text("12:00 PM" , style: TextStyle( color: AppColors.greyDark , fontSize:10 ,fontWeight: FontWeight.w400 ),),
           trailing: Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
               color: AppColors.greenPale,
               borderRadius: BorderRadius.circular(10),
            ),
           )
           
         ),
       ),
    );
  }
}