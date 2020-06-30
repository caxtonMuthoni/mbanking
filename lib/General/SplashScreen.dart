import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mbanking/Home/home.dart';
import 'package:mbanking/SQL/db_helper.dart';
import 'package:mbanking/SQL/user.dart';
import 'package:mbanking/login/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<int> length;
  var dbHelper;
  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    Timer(Duration(seconds: 5),  ()=>{
      navigateTo()
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(143, 148, 251, 1),
                          Color.fromRGBO(133, 138, 241, .9),
                        ],
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft
                    )
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 50.0,
                            child: Icon(FontAwesomeIcons.umbrella,color: Colors.orangeAccent,size: 50.0,),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                          ),
                          Text("M~Banking",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 23.0,
                            fontFamily: 'BowlbyOneSC'
                          ),),
                          Text("Fast, Efficient, Flexible and  Secure  Banking.",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontFamily: 'YeonSung'
                            ),),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                        Text("Getting started ...",
                        style: TextStyle(
                          fontFamily: 'ptserif',
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold
                        ),)
                      ],
                    ),
                  )
                ],
              )
            ],
          ),

    ));
  }

   navigateTo() async{

    await dbHelper.db;
    List<User> users = await dbHelper.getUserLength();

    int length = users.length;


     if(length > 0){
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeMain()));
     }else{
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
     }
   }




}
