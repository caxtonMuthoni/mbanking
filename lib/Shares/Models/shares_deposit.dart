import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbanking/General/constants.dart';
import 'package:mbanking/Shares/shares.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sweetalert/sweetalert.dart';

class SharesDepositModel{

  String amount;
  BuildContext context;

  SharesDepositModel(this.amount, this.context);

  depositShares() async {
    SharedPreferences sharedPreferences =  await SharedPreferences.getInstance();
    String token = sharedPreferences.get("token");
    setToken(token);

    Map<String,dynamic> data = {
      "amount" : amount
    };
    
    try{
      final response = await http.post(BASE_URL + 'api/depositshare', headers: HeadersPost,body: data);
      final jsonData = jsonDecode(response.body);
      if(response.statusCode == 200){
        if(jsonData['status']){
          SweetAlert.show(context,
              title: 'Success !!!',
              subtitle: jsonData['message'],
              style: SweetAlertStyle.success,
          );
          Future.delayed(Duration(seconds: 3),(){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Shares()));
          });
        }else if(!jsonData['status']){
          SweetAlert.show(context,
              title: 'Oops !!!',
              subtitle: jsonData['message'],
              style: SweetAlertStyle.error);
        }
      }else if(response.statusCode == 422){
        SweetAlert.show(context,
            title: 'Invalid data !!!',
            subtitle: jsonData['errors']['amount'][0],
            style: SweetAlertStyle.error);
      }
      else{
        SweetAlert.show(context,
            title: 'Oops !!!',
            subtitle: "please try again later",
            style: SweetAlertStyle.error);
      }
      
    }catch(e){
      print(e);
    }
  }


}