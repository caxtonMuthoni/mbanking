import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mbanking/General/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Account{


  int id;
  int AccountNumber;
  String AccountName;
  String CustomerID;
  String CurrentBalance;
  String Status;
  String created_at;
  String AccountCode;

  Account({this.id, this.AccountNumber, this.AccountName, this.CustomerID,
    this.CurrentBalance, this.Status, this.created_at,this.AccountCode});
  
  
  Future<List<Account>> fetchUserAccounts(BuildContext context) async{

//    Get and set token

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String token = sharedPreferences.get("token");
  setToken(token);



     
     try{
       List<Account>  accountList = [];
        final response =  await http.Client().get(BASE_URL+"api/getusersaccounts",headers: RequestHeaders);
        if (response.statusCode==200) {
         final  jsonData = jsonDecode(response.body);
          for(var json in jsonData){
            Account account = Account(
              id: json['id'],
              AccountNumber: json['AccountNumber'],
              AccountName: json['AccountName'],
              CustomerID: json['CustomerID'],
              CurrentBalance: json['CurrentBalance'],
              Status: json['Status'],
              created_at: json['created_at'],
              AccountCode: json['AccountCode']
            );
            accountList.add(account);
          }


          return accountList;
        }
     }
     catch(e){
       print(e);
     }
    
    
  }



}