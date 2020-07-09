import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mbanking/General/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
class UserLoans{

  int id;
  String loanId;
  String loanType;
  String borrowedAmount;
  String borrower;
  String status;
  String interest;
  String period;
  String installment;
  String startDate;
  String nextPayment;
  String dueDate;
  String alias;
  String totalRepayable;
  String paidAmount;
  String guarantorAmount;
  String guaranteedAmount;
  int guaranteeStatus;
  int isProcessed;


  UserLoans({this.id, this.loanId, this.loanType, this.borrowedAmount,this.borrower,
      this.status, this.interest, this.period, this.installment, this.startDate,
      this.nextPayment, this.dueDate, this.alias, this.totalRepayable,
      this.paidAmount, this.guarantorAmount, this.guaranteedAmount,
      this.guaranteeStatus, this.isProcessed});

  Future<List<UserLoans>> getUserLoans() async{

    List<UserLoans> userLoans = [];

//    1. Get auth token from Shared references
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.get("token");

//    2. Set the token for headers
    setToken(token);

//    Try the request

    try{
        // 1. Get the response

           final response = await http.Client().get(BASE_URL + 'api/userloans',headers: RequestHeaders);

        // 2. Decode the response into json
           final jsonData = jsonDecode(response.body);

           print(jsonData);

        // 3. Loop within  the json and add the items to the userLoans list;
            for ( var json in jsonData['data']){
                UserLoans userln = UserLoans(
                    id: json['id'],
                    loanId: json['loanId'].toString(),
                    loanType: json['loanType'],
                    borrowedAmount: json['borrowedAmount'],
                    borrower: json['borrower'],
                    status: json['status'],
                    interest: json['interest'].toString(),
                    period: json['period'].toString(),
                    installment: json['installment'].toString(),
                    startDate: json['startDate'],
                    nextPayment: json['nextPayment'],
                    dueDate: json['dueDate'],
                    alias: json['alias'].toString(),
                    totalRepayable: json['totalRepayable'].toString(),
                    paidAmount: json['paidAmount'].toString(),
                    guarantorAmount: json['guarantorAmount'].toString(),
                    guaranteedAmount: json['guaranteedAmount'].toString(),
                    guaranteeStatus: json['guaranteeStatus'],
                    isProcessed: json['isProcessed'],
                );

                userLoans.add(userln);
            }
        // 4. Return the list

      return userLoans;

    }catch(e){

      print(e);
    }

  }


}


/*
*
*
*           "id": 1,
            "borrower": "Caxton Githinji",
            "userId": "1",
            "loanId": "14376199",
            "loanType": "School Fee Loan",
            "borrowedAmount": "1000",
            "interest": "9",
            "period": "12",
            "installment": "500",
            "startDate": "2020-05-17T00:00:00.000000Z",
            "nextPayment": "2020-06-22 01:18:42",
            "dueDate": "2021-05-22 08:51:06",
            "alias": "complete",
            "totalRepayable": "2080",
            "paidAmount": "2080",
            "guarantorAmount": "2080",
            "guaranteedAmount": "2080",
            "guaranteeStatus": 1,
            "isProcessed": 1,
            "status": "complete"
* */