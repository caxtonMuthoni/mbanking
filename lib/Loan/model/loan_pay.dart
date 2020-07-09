import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mbanking/General/constants.dart';
import 'package:mbanking/utils/sweet_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sweetalert/sweetalert.dart';

class PayLoanModel{

  int id;
  String amount;
  BuildContext context;

  PayLoanModel(this.id, this.amount, this.context);


  payLoan() async{

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.get("token");
    setToken(token);

    Map<String,dynamic> data = {
      "id" : id.toString(),
      "amount" : amount
    };


    try{
      final response = await http.Client().post(BASE_URL +'api/payloan',body: data,headers: HeadersPost);
      print(id);
      print(response.body);
      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body);
        if(jsonData['status']){
          SweetAlert.show(context,
          title: "Success !!!",
          subtitle: jsonData['message'],
          style: SweetAlertStyle.success);
        }
       else if(!jsonData['status']){
          SweetAlert.show(context,
              title: "Oops !!!",
              subtitle: jsonData['message'],
              style: SweetAlertStyle.error);
        }
      }
    }catch(e){
      print(e);
    }
  }


}