import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Lends extends StatefulWidget {
  @override
  _LendsState createState() => _LendsState();
}

class _LendsState extends State<Lends> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(143, 148, 251, 1),
        appBar: AppBar(
          title: Text("Lends",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'ptserif',
          ),),
          backgroundColor: Color.fromRGBO(143, 148, 251, 1),
          centerTitle: true,
          elevation: 0.00,
        ),
        body: Container(),
      ),
    );
  }
}
