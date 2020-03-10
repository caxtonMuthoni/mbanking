import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Profile",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'BowlbyOneSC'
          ),),
          backgroundColor: Color.fromRGBO(148, 143, 251, 1),
        ),
      ),
    );
  }
}
