import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mbanking/General/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';


class WithdrawDeposit{

  int accountId;
  String action;
  String amount;

  BuildContext context;


  WithdrawDeposit({this.accountId, this.action, this.amount,this.context});

  withdrawDeposit() async {
//    1. Check action and set  url
  String URL;
  if(action == 'withdraw'){
    URL = BASE_URL + 'api/withdrawfromotheraccount';
  }
  else if(action == 'deposit'){
    URL = BASE_URL + 'api/deposittootheraccount';
  }

//  2. Get and set token
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.get("token");
    setToken(token);

//    3. Prepare data
    Map<String,dynamic> data ={
      'amount' : amount,
      'accountId' : accountId.toString()
    };

  try{
    final response = await http.Client().post(URL,headers: HeadersPost,body: data);
    final jsonData = jsonDecode(response.body);
    print(jsonData);
    if(jsonData['status']){
      SweetAlert.show(context,
        style: SweetAlertStyle.success,
        title: "$action complete",
        subtitle: jsonData['message']
      );
    }
    else {
      Future.delayed(Duration(seconds: 1),(){
        SweetAlert.show(context,
          title: "An errror occurred",
          subtitle: jsonData['message'],
          style: SweetAlertStyle.error,
        );
      });
    }

  }catch(e){
    print(e);
  }

  }
}