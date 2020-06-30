import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbanking/General/SplashScreen.dart';
import 'package:mbanking/Home.dart';
import 'package:mbanking/login/login.dart';

void main()=>runApp(MaterialApp(
  theme: ThemeData(accentColor: Colors.orangeAccent),
  home: SplashScreen(),
  debugShowCheckedModeBanner: false,
));

