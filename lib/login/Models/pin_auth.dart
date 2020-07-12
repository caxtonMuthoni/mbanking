

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mbanking/General/constants.dart';
import 'package:http/http.dart' as http;
import 'package:mbanking/SQL/db_helper.dart';
import 'package:mbanking/SQL/user.dart';
import 'package:mbanking/utils/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';

class PinAuthentiction{
  String pin;
  String phone;
  PinAuthentiction(this.pin, this.phone);
  login(BuildContext context) async{

    ProgressDialogue progressDialogue = ProgressDialogue(
        context: context,
        title: 'Granting access ...'
    );

    var pr = progressDialogue.progress();

    pr.show();

    Map data ={
      "PhoneNumber":phone,
      "password": pin,
    };


    Map<String, String> requestHeaders = {
      'Content-type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
    };

    var client = http.Client();
    
    var jsonData = null;


    try{

      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      
      var response = await client.post(BASE_URL + "api/auth/login",body: data,headers: requestHeaders);

      if(response.statusCode ==200){
        jsonData = jsonDecode(response.body);
          print(jsonData['access_token']);

//          Store token to shared preferences
           sharedPreferences.setString("token", jsonData['access_token']);

             //            Add user to sql db
             addUser(phone);
            Future.delayed(Duration(seconds: 1)).then((value){
               pr.hide();
            });


             return "200";


        
      }
      else{
        if(response.statusCode == 401){

          Future.delayed(Duration(seconds: 2)).then((value) {
              pr.hide().whenComplete((){
                SweetAlert.show(context,
                    style: SweetAlertStyle.error,
                    title: "Oops!!!",
                    subtitle: "Invalid credentials"
                );
              });
          });

        }
        
        return "401";
      }

    }catch(e){
      print(e);
      Future.delayed(Duration(seconds: 2)).then((value) {
          SweetAlert.show(context,
            style: SweetAlertStyle.error,
            title: "Network error !!!",
            subtitle: "switch on data or connect to wifi",
          );
      });
      
      return "401";
    }
    

  }

  void addUser(String phone) async{
    var dbHelper = DBHelper();
    User u = User(null,phone);
    await dbHelper.db;
    await dbHelper.save(u);
  }

}