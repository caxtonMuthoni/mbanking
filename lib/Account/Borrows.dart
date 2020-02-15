import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Borrows extends StatefulWidget {
  @override
  _BorrowsState createState() => _BorrowsState();
}

class _BorrowsState extends State<Borrows> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(143, 148, 251, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(143, 148, 251, 1),
          title: Text("Borrows",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'ptserif',
          ),),
          elevation: 0.00,
          centerTitle: true,
        ),
        body: Container(),
      ),
    );
  }
}
