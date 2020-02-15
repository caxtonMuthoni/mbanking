import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(143, 148, 251, 1),
          title: Text("Who are we ?",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'BowlbyOneSC'
          ),),
          centerTitle: true,
        ),
      ),
    );
  }
}
