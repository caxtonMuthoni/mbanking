import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mbanking/General/Constants.dart';
import 'package:mbanking/login/login.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sweetalert/sweetalert.dart';

class Borrow{

  int id;
  int userId;
  String title;
  String description;
  String project_image;
  int amountBorrowed;
  int balance;
  int status;
  int paymentstatus;
  String created_at;

  Borrow({this.id, this.userId, this.title, this.description,
    this.project_image, this.amountBorrowed, this.balance, this.status,
    this.paymentstatus, this.created_at});


  factory Borrow.fromJson(Map<String , dynamic> json){
     return Borrow(
         id: json["id"],
         userId: json["userId"],
         title: json["title"],
         description: json["description"],
         project_image: json["project_image"],
         amountBorrowed: json["amountBorrowed"],
         balance: json["balance"],
         status: json["status"],
         paymentstatus: json["paymentstatus"],
         created_at: json["created_at"],
     );
  }


  Future<List<Borrow>> fetchBorrows(http.Client client,BuildContext context) async{

    checkLoginStatus(context);

    List<Borrow> borrows = [];

    try{

      final response = await client.get(BASE_URL+"api/activeborrows",headers: RequestHeaders);

      if (response.statusCode == 401) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
        SweetAlert.show(context,
          style: SweetAlertStyle.error,
          title: "Access Denied !!!",
          subtitle: "Your session expired. Please Login",

        );


      }
      if (response.statusCode == 200) {
        print("Mwili ni" +response.body);

        var jsonData = jsonDecode(response.body);

        for(var json in jsonData){
          Borrow borrow = Borrow(
            id: json["id"],
            userId: json["userId"],
            title: json["title"].toString(),
            description: json["description"],
            project_image: json["project_image"],
            amountBorrowed: json["amountBorrowed"],
            balance: json["balance"],
            status: json["status"],
            paymentstatus: json["paymentstatus"],
            created_at: json["created_at"].toString(),
          );
          borrows.add(borrow);
        }

        return borrows;


      }else{
        //throw Exception("failed to load data");
        print(response.body);
      }

    }catch(e){
      print(e);
    }


  }
}