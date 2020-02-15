import 'package:flutter/material.dart';

class Query extends StatefulWidget {
  @override
  _QueryState createState() => _QueryState();
}

class _QueryState extends State<Query> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(143, 148, 251, 1),
          title: Text(" Send a Review",
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
