import 'dart:convert';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mbanking/General/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User{

  int id;
  String FirstName;
  String LastName;
  String MiddleName;
  String City;
  String email;
  String PhoneNumber;
  String NationalID;

  User({this.id, this.FirstName, this.LastName, this.MiddleName,
    this.City, this.email, this.PhoneNumber, this.NationalID});


  factory User.fromJson(Map<String , dynamic> json){
    return User(
        id: json['id'],
        FirstName: json['FirstName'],
        LastName: json['LastName'],
        MiddleName: json['MiddleName'],
        NationalID: json['NationalID'],
        City: json['City'],
        email: json['email'],
        PhoneNumber: json['PhoneNumber'],
    );
  }


  static Future<User> fetchUser({http.Client client,int id,BuildContext context}) async{

     checkLoginStatus(context);

     User user;
     var response;

    try{
      if(id == null){
         response = await client.get(BASE_URL+"api/user",headers:RequestHeaders );
      } else{
        response = await client.get(BASE_URL+"api/user/"+id.toString(),headers:RequestHeaders );
      }

      if (response.statusCode ==200) {
        user = User.fromJson(jsonDecode(response.body));
        return user;
      }
      else{
        print(response.body);
      }

    }catch(e){
      print(e);
    }

  }


}

