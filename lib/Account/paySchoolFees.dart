import 'package:flutter/material.dart';

class PaySchoolFees extends StatefulWidget {
  @override
  _PaySchoolFeesState createState() => _PaySchoolFeesState();
}

class _PaySchoolFeesState extends State<PaySchoolFees> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(143, 148, 251, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(143, 148, 251, 1),
          title: Text("Select School",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'ptserif',
          ),),
          centerTitle: true,
          elevation: 0.0,
        ),
      ),
    );
  }
}
