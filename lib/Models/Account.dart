import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mbanking/General/Constants.dart';
import 'package:http/http.dart' as http;

class Account{


  int id;
  int AccountNumber;
  String AccountName;
  String CustomerID;
  String CurrentBalance;
  String Status;
  String created_at;

  Account({this.id, this.AccountNumber, this.AccountName, this.CustomerID,
    this.CurrentBalance, this.Status, this.created_at});
  
  
  Future<List<Account>> fetchUserAccounts(BuildContext context) async{

     
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