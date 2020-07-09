import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbanking/General/constants.dart';
import 'package:mbanking/Invest/investments.dart';
import 'package:mbanking/Invest/termination_requests.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sweetalert/sweetalert.dart';

class Investment{

  int id;
  String duration;
  String terminationDate;
  String interest;
  String amount;
  String status;
  String totalPay;
  String createdAt;

  BuildContext context;

  Investment({this.context,this.id, this.duration, this.terminationDate, this.interest,
      this.amount, this.status, this.totalPay, this.createdAt});


//  1. Get user investments.

Future<List<Investment>> getInvestments() async{
//  1. Get and set Tokens

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String token = sharedPreferences.get("token");
  setToken(token);

//  2. Initialize an empty list on investments;
   List<Investment> investments = [];

//  3 .Send the request to the server
   try{
     final response = await http.Client().get(BASE_URL + 'api/myinvestments',headers: RequestHeaders);
     final jsonData = jsonDecode(response.body);
     if (response.statusCode == 200) {
       print(jsonData['data']);
        for(var json in jsonData['data']){
           Investment investment = Investment(
               id : json['id'],
               duration : json['duration'].toString(),
               interest : json['interest'].toString(),
               amount : json['amount'].toString(),
               status : json['status'].toString(),
               totalPay : json['total_pay'].toString(),
               createdAt : json['created_at'].toString(),
               terminationDate: json['termination_date'],

           );

           investments.add(investment);
        }

     }
   }catch(e){
     print(e);
   }



// 4. Return the List<Investment> investments

  return investments;

}


// 2. Create new investment.
createInvestment() async{
  //  1. Get and set Tokens

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String token = sharedPreferences.get("token");
  setToken(token);

//  2. Prepare the data

    Map<String,dynamic> data = {
        "amount" : amount,
        "duration": duration,
    };

//    3. Send request to the server

    try{
      final response = await http.Client().post(BASE_URL + 'api/invest',body: data,headers: HeadersPost);
      final jsonData = jsonDecode(response.body);
      print(jsonData);
      if(response.statusCode == 200){
        if(jsonData['status']){
          SweetAlert.show(context,
            title: "Success",
            subtitle: jsonData['message'],
            style: SweetAlertStyle.success
          );
          Future.delayed(Duration(seconds: 2),(){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Investments(),));
          });
        }else{
          SweetAlert.show(context,
              title: "An error occured.",
              subtitle: jsonData['message'],
              style: SweetAlertStyle.error);
        }
      }else if(response.statusCode == 422){
        if(jsonData['errors']['amount']  != null){
          SweetAlert.show(context,
              title: "Amount Error",
              subtitle: jsonData['errors']['amount'][0],
              style: SweetAlertStyle.error);
          return;
        }else if(jsonData['errors']['duration']  != null){
               SweetAlert.show(context,
              title: "Amount Error",
              subtitle: jsonData['errors']['duration'][0],
              style: SweetAlertStyle.error);
        }
      }

    }catch(e){
      print(e);
    }


}

//3. Terminate investment.

terminateInvestment(int investmentId, String reason) async{
  //  1. Get and set Tokens

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String token = sharedPreferences.get("token");
  setToken(token);

//  2. Prepare the data

  Map<String,dynamic> data = {
    "investmentId" : investmentId.toString(),
    "reason": reason,
  };

//    3. Send request to the server

try{
  final response = await http.Client().post(BASE_URL + 'api/requesttermination',headers: HeadersPost,body: data);
  final jsonData = jsonDecode(response.body);
  if(response.statusCode == 200){
    if(jsonData['status']){
      SweetAlert.show(context,
        style: SweetAlertStyle.success,
        title: "Success",
        subtitle: jsonData['message']
      );
      Future.delayed(Duration(seconds: 2),(){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TerminationRequests(),));
      });
    }
    else{
      SweetAlert.show(context,
          style: SweetAlertStyle.error,
          title: "Error",
          subtitle: "Please try again later"
      );
    }
  }else{
    SweetAlert.show(context,
        style: SweetAlertStyle.error,
        title: "Error",
        subtitle: "Please try again later"
    );
  }



}catch(e){
  print(e);
}
}



}

/*"id": 1,
            "user": "Caxton Githinji",
            "duration": 10,
            "termination_date": "2020-07-07 11:11:24",
            "interest": 3,
            "amount": 5000,
            "status": 0,
            "total_pay": 5240,
            "created_at": "2020-04-01T14:05:19.000000Z"*/