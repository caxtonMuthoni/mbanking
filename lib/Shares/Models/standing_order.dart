import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbanking/General/constants.dart';
import 'package:mbanking/Shares/standing_orders.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sweetalert/sweetalert.dart';

class StandingOrderModel{

  String id;
  String accountId;
  String destinationId;
  String  amount;
  String  duration;
  String nextOrder;
  String status;
  String created_at;
  BuildContext context;


  StandingOrderModel({this.id,this.accountId, this.destinationId, this.amount,
    this.duration, this.nextOrder, this.status, this.created_at,
    this.context});

  createStandingOrder() async{
//    1. Get and set Token
  SharedPreferences  sharedPreferences = await SharedPreferences.getInstance();
  String token = sharedPreferences.get("token");
  setToken(token);

//  2. Prepare data
  Map<String,dynamic> data = {
    "accountId" : accountId,
    "amount" : amount,
    "duration" : duration,
    "destinationId" : destinationId
  };
//  3. send request to the server
  try{
    final response = await http.Client().post(BASE_URL + 'api/addstandingorder',headers: HeadersPost,body: data);
    final jsonData = jsonDecode(response.body);
    print(jsonData);
    if(response.statusCode == 200){
      if(jsonData['status']){
        var myStandingOrders = await getStandingOrders();
        SweetAlert.show(context,
        title: "Success",
        subtitle: jsonData['message'],
        style: SweetAlertStyle.success);
        Future.delayed(Duration(seconds: 2),(){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserStandingOrders(myStandingOrders)));
        });
      }
      else if(!jsonData['status']){
        SweetAlert.show(context,
            title: "Oops !!!",
            subtitle: jsonData['message'],
            style: SweetAlertStyle.error);
      }
    }else if(response.statusCode == 422 && jsonData['error'] != null){
      if(jsonData['error']['amount'][0] != null){
        SweetAlert.show(context,
            title: "Oops !!!",
            subtitle: jsonData['error']['amount'][0],
            style: SweetAlertStyle.error);
      }
      else if(jsonData['error']['duration'][0] != null){
        SweetAlert.show(context,
            title: "Oops !!!",
            subtitle: jsonData['error']['duration'][0],
            style: SweetAlertStyle.error);
      }
    }else{
      SweetAlert.show(context,
          title: "Oops !!!",
          subtitle: "Please try again later",
          style: SweetAlertStyle.error);
    }

  }catch(e){
    print (e);
  }
  }

  Future<List<StandingOrderModel>> getStandingOrders() async {
    //    1. Get and set Token
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.get("token");
    setToken(token);

//  2. initialize an empty list of Standing orders

    List<StandingOrderModel> standingOrders = [];

//    3. Send request to the server
    try {
      final response = await http.Client().get(
          BASE_URL + 'api/mystandingorders', headers: RequestHeaders);
      final jsonData = jsonDecode(response.body);
      for (var json in jsonData) {
        StandingOrderModel standingOrderModel = StandingOrderModel(
          id: json['id'].toString(),
          accountId: json['accountId'].toString(),
          destinationId: json['destinationId'].toString(),
          amount: json['amount'].toString(),
          duration: json['duration'].toString(),
          nextOrder: json['nextOrder'].toString(),
          status: json['status'].toString(),
          created_at: json['created_at'].toString(),
        );
        standingOrders.add(standingOrderModel);
      }
    } catch (e) {
      print(e);
    }

    return standingOrders;
  }



  stopStartStandingOrder(String orderId) async{
    //    1. Get and set Token
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.get("token");
    setToken(token);

//    2. Prepare data
    Map<String,dynamic> data ={
      "id" : orderId,
    };

//    3. send request to the server

    try {
      final   response = await http.Client().post(BASE_URL + 'api/stopstart',body: data,headers: HeadersPost) ;
      final jsonData = json.decode(response.body);
      if(response.statusCode == 200){
         if(jsonData['status']){
           SweetAlert.show(context,
           title: "Success",
           subtitle: jsonData['message'],
           style: SweetAlertStyle.success);
         }else{
           SweetAlert.show(context,
               title: "Error !!!",
               subtitle: "Please try again later",
               style: SweetAlertStyle.error);
         }
      }else{
        SweetAlert.show(context,
            title: "Error !!!",
            subtitle: "Please try again later",
            style: SweetAlertStyle.error);
      }

    }catch(e) {

    }
  }

  updateStandingOrder(String orderId) async{
    //    1. Get and set Token
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.get("token");
    setToken(token);

    //  2. Prepare data
    Map<String,dynamic> data = {
      "accountId" : accountId,
      "amount" : amount,
      "duration" : duration,
      "destinationId" : destinationId
    };
//  3. send request to the server
    try{
      final response = await http.Client().post(BASE_URL + 'api/updatestandingorder/' + orderId,headers: HeadersPost,body: data);
      final jsonData = jsonDecode(response.body);
      print(jsonData);
      if(response.statusCode == 200){
        if(jsonData['status']){
          var myStandingOrders = await getStandingOrders();
          SweetAlert.show(context,
              title: "Success",
              subtitle: jsonData['message'],
              style: SweetAlertStyle.success);
          Future.delayed(Duration(seconds: 2),(){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserStandingOrders(myStandingOrders)));
          });
        }
        else if(!jsonData['status']){
          SweetAlert.show(context,
              title: "Oops !!!",
              subtitle: jsonData['message'],
              style: SweetAlertStyle.error);
        }
      }else if(response.statusCode == 422 && jsonData['error'] != null){
        if(jsonData['error']['amount'][0] != null){
          SweetAlert.show(context,
              title: "Oops !!!",
              subtitle: jsonData['error']['amount'][0],
              style: SweetAlertStyle.error);
        }
        else if(jsonData['error']['duration'][0] != null){
          SweetAlert.show(context,
              title: "Oops !!!",
              subtitle: jsonData['error']['duration'][0],
              style: SweetAlertStyle.error);
        }
      }else{
        SweetAlert.show(context,
            title: "Oops !!!",
            subtitle: "Please try again later",
            style: SweetAlertStyle.error);
      }

    }catch(e){
      print (e);
    }


  }

  /*"id": 1,
  "userId": "1",
  "accountId": "1",
  "amount": "250",
  "duration": "1",
  "destinationId": "4",
  "nextOrder": "2020-06-22 12:36:26",
  "status": 1,
  "created_at": "2020-05-21 14:05:29",
  "updated_at": "2020-05-22 12:36:26"*/


}
