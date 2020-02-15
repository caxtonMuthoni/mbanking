import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Statement extends StatefulWidget {
  @override
  _StatementState createState() => _StatementState();
}

class _StatementState extends State<Statement> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(143, 148, 251, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(143, 148, 251, 1),
          title: Text("Statement",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'ptserif'
          ),),
          centerTitle: true,
          elevation: 0.00,
        ),
        body: Container(),
      ),
    );
  }
}
