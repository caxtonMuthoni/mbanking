import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mbanking/General/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';

class UserLoanDetail{

  BuildContext context;

  String limit;
  String balance;
  String aliases;
  String status;
  int id;


  UserLoanDetail({this.context,this.id, this.limit, this.balance, this.aliases,
      this.status});

  factory UserLoanDetail.fromJson(Map<String,dynamic> json){
    return UserLoanDetail(
      id: json['id'],
      balance: json['balance'].toString(),
      limit: json['limit'].toString(),
      aliases: json['alias'].toString(),
      status: json['loan_status'].toString(),
    );
  }

 Future<UserLoanDetail> getUserLoanDetail() async{

//    1. Get token from shared preferences
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.get("token");

//    2. set token to the headers.
    setToken(token);

//    3. complete request
    try{
       UserLoanDetail userLoanDetail;
       final response = await http.Client().get(BASE_URL + 'api/userloandetails',headers: RequestHeaders);
       final jsonData = jsonDecode(response.body);
       userLoanDetail = UserLoanDetail.fromJson(jsonData);
       return userLoanDetail;
    }catch(e){
      print(e);
      SweetAlert.show(context,
      title: "Network error",
        subtitle: "Start data or connect to wifi.",
          style: SweetAlertStyle.error,
      );
    }
  }

}