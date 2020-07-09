import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mbanking/General/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MyTransaction{

  int id;
  String transactionID;
  String phone;
  String description;
  String amount;
  String originalBal;
  String newBal;
  String date;


  MyTransaction({this.id, this.transactionID, this.phone, this.description,
      this.amount, this.originalBal, this.newBal, this.date});

  Future<List<MyTransaction>> fetchTransactions() async{

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.get("token");
    setToken(token);

    List<MyTransaction> myTransactions = [] ;

    try{
      final response = await http.Client().get(BASE_URL + 'api/usertransactions', headers: RequestHeaders);
      final jsonData = jsonDecode(response.body);

      for(var json in jsonData['data']){
        MyTransaction myTransaction = MyTransaction(
            id:json['id'],
            transactionID:json['transactionID'],
            phone:json['phone'],
            description:json['description'],
            amount:json['amount'].toString(),
            originalBal:json['original_bal'].toString(),
            newBal:json['new_bal'].toString(),
            date:json['date'],
        );

        myTransactions.add(myTransaction);
      }

    }catch(e){
      print(e);
    }

    return myTransactions;


  }

  Future<List<MyTransaction>> fetchAccountTransactions( int AccountNumber) async{


    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.get("token");
    setToken(token);

    Map<String,dynamic> data ={
      "accountNumber" : AccountNumber.toString()
    };

    List<MyTransaction> myTransactions = [] ;

    try{
      final response = await http.Client().post(BASE_URL + 'api/accountstatement', headers: HeadersPost,body: data);
      final jsonData = jsonDecode(response.body);
      if(response.statusCode == 200){
        for(var json in jsonData['data']){
          MyTransaction myTransaction = MyTransaction(
            id:json['id'],
            transactionID:json['transactionID'],
            phone:json['phone'],
            description:json['description'],
            amount:json['amount'].toString(),
            originalBal:json['original_bal'].toString(),
            newBal:json['new_bal'].toString(),
            date:json['date'],
          );

          myTransactions.add(myTransaction);
        }
      }

    }catch(e){
      print(e);
    }

    return myTransactions;


  }


}

/*
*            "id": 35,
            "transactionID": "2301501756",
            "user": "Caxton Githinji",
            "phone": "0743751575",
            "description": "investment total returns",
            "amount": 5240,
            "original_bal": 19683,
            "new_bal": 24923,
            "date": "2020-07-07T11:08:26.000000Z"*/
