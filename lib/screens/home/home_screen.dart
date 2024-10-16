// ignore_for_file: prefer_const_constructors, unused_field, deprecated_member_use
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
  /// for storing all users
  List<ChatUser> _list = [];

  /// for storing all searched items
  final List<ChatUser> _searchList = [];

  /// for storing serach status
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>  FocusScope.of(context).unfocus,
      child: WillPopScope(

        /// if search is on & back button os pressed then close search
        /// or else simple close current screen on back button click..
        onWillPop: (){
          if(_isSearching){
            setState(() {
              _isSearching = !_isSearching;
            });
          return Future.value(false);
          }else{
            return Future.value(true);
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.appWhiteColor,
        
          /// app bar
          appBar: AppBar(
            elevation: 0,
            iconTheme: IconThemeData(color: AppColors.appBlackColor),
            title: _isSearching
                ? TextField(
                  autofocus: true,
                  style: TextStyle(fontSize: 16 , letterSpacing: .5),
        
                  /// when search text changes then updated search list.
                  onChanged: (val){
                    /// search logic
                    _searchList.clear();
        
                    for(var i in _list){
                      if(i.name.toLowerCase().contains(val.toLowerCase()) || i.email.toLowerCase().contains(val.toLowerCase())){
                        _searchList.add(i);
                      }
                      setState(() {
                        _searchList;
                      });
                    }
                  },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Name , email ....",
                      
                    ),
                  )
                : Text(
                    AppStrings.myAppName,
                    style: TextStyle(color: AppColors.textPrimaryColor),
                  ),
            leading: Icon(CupertinoIcons.home),
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      _isSearching = !_isSearching;
                    });
                  },
                  icon: Icon(_isSearching
                      ? CupertinoIcons.clear_circled_solid
                      : CupertinoIcons.search)),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ProfileScreen(user: APIs.me)));
                  },
                  icon: Icon(CupertinoIcons.ellipsis_vertical)),
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
            stream: APIs.getAllUsers(),
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
                  _list =
                      data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];
        
                  if (_list.isNotEmpty) {
                    return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: _isSearching ? _searchList.length : _list.length,
                        itemBuilder: (context, index) {
                          return ChatUserCard(
                            user: _isSearching ? _searchList[index] : _list[index],
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
        ),
      ),
    );
  }
}
