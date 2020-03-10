import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mbanking/General/Constants.dart';
class MyTransaction{

  int id;
  String TransactionType;
  String TransID;
  String UserId;
  String AccountNumber;
  String MSISDN;
  String FirstName;
  String MiddleName;
  String LastName;
  int TransAmount;
  int OrgAccountBalance;
  int CrtAccountBalance;
  String created_at;

  MyTransaction({this.id, this.TransactionType, this.TransID, this.UserId,
    this.AccountNumber, this.MSISDN, this.FirstName, this.MiddleName,
    this.LastName, this.TransAmount, this.OrgAccountBalance,
    this.CrtAccountBalance,this.created_at});


  Future<List<MyTransaction>> fetchTransactions( String phone) async{

    Map <String , String> data ={
      "MSISDN": phone
    };
    try{
      List<MyTransaction> myTransactions = [];

      final response =  await http.Client().post(BASE_URL+"api/mytransaction",headers: HeadersPost,body: data);

      //print(response.body);

      if (response.statusCode ==200) {
        var jsonData = jsonDecode(response.body);
        print(jsonData);
        for( var json in jsonData['transactions']){
          MyTransaction myTransaction = MyTransaction(
            id: json['id'],
            TransactionType: json['TransactionType'],
            TransID: json['TransID'],
            UserId: json['UserId'],
            AccountNumber: json['AccountNumber'],
            MSISDN: json['MSISDN'],
            FirstName: json['FirstName'],
            MiddleName: json['MiddleName'],
            LastName: json['LastName'],
            TransAmount: json['TransAmount'],
            OrgAccountBalance: json['OrgAccountBalance'],
            CrtAccountBalance: json['CrtAccountBalance'],
            created_at: json['created_at'],
          );

          myTransactions.add(myTransaction);
        }

        return myTransactions;
      }

    } catch(e){
       print(e);
    }
  }

  Future<List<MyTransaction>> fetchAccountTransactions( int AccountNumber) async{

    Map <String , String> data ={
      "accountNumber": AccountNumber.toString()
    };
    try{
      List<MyTransaction> myTransactions = [];

      final response =  await http.Client().post(BASE_URL+"api/accountstatement",headers: HeadersPost,body: data);

      print(response.body);

      if (response.statusCode ==200) {
        var jsonData = jsonDecode(response.body);
        //print(jsonData);
        for( var json in jsonData){
          MyTransaction myTransaction = MyTransaction(
            id: json['id'],
            TransactionType: json['TransactionType'],
            TransID: json['TransID'],
            UserId: json['UserId'],
            AccountNumber: json['AccountNumber'],
            MSISDN: json['MSISDN'],
            FirstName: json['FirstName'],
            MiddleName: json['MiddleName'],
            LastName: json['LastName'],
            TransAmount: json['TransAmount'],
            OrgAccountBalance: json['OrgAccountBalance'],
            CrtAccountBalance: json['CrtAccountBalance'],
            created_at: json['created_at'],
          );

          myTransactions.add(myTransaction);
        }

        return myTransactions;
      }

    } catch(e){
      print(e.toString());
    }
  }


}
