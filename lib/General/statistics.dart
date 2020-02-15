import 'package:flutter/material.dart';

class Statistics extends StatefulWidget {
  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(143, 148, 251, 1),
          title: Text("Statistics",
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
