import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mbanking/General/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sweetalert/sweetalert.dart';

class RequestLoanModel {

  String amount;
  String period;
  String loanType;
  BuildContext context;

  RequestLoanModel({this.context,this.amount, this.period, this.loanType});


  postLoan() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.get("token");
    setToken(token);

    Map<String, dynamic> data = {
      "loanType": loanType,
      "borrowedAmount": amount,
      "period": period
    };

    try {
      final response = await http.Client().post(
          BASE_URL + "api/addloan", headers: HeadersPost,body: data);
      if (response.statusCode == 200){
        final jsonData = jsonDecode(response.body);
        if(jsonData['status']){
          Future.delayed(Duration(seconds: 2)).then((value) {
            SweetAlert.show(context,
              style: SweetAlertStyle.success,
              title: "Success !!!",
              subtitle: jsonData['message'],
            );
          });
        }

        if(!jsonData['status']){
          Future.delayed(Duration(seconds: 2)).then((value) {
            SweetAlert.show(context,
              style: SweetAlertStyle.error,
              title: "Oops !!!",
              subtitle: jsonData['message'],
            );
          });
        }
      }else{
        Future.delayed(Duration(seconds: 2)).then((value) {
          SweetAlert.show(context,
            style: SweetAlertStyle.error,
            title: "Oops !!!",
            subtitle: "Please try again later.",
          );
        });
      }

    } catch (e) {
      print(e);
    }
  }
}

/*
* "loanType":1,
        "borrowedAmount": 12000,
        "period":*/