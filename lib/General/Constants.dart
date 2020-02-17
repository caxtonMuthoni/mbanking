

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbanking/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

const BASE_URL ="http://192.168.43.143:8080/";

String token = 'no token';

Map<String, String>  HeadersPost;
Map<String, String> RequestHeaders;

checkLoginStatus (BuildContext context) async{
   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   if(sharedPreferences.getString("token") == null){
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
      RequestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      };
   }
   else{
       token = sharedPreferences.getString("token");
      RequestHeaders = {
         'Content-type': 'application/json',
         'Accept': 'application/json',
         'Authorization':'Bearer '+token,
       };

         HeadersPost = {
         'Content-type': 'application/x-www-form-urlencoded',
         'Accept': 'application/json',
         'Authorization':'Bearer '+token,
       };
   }
}

