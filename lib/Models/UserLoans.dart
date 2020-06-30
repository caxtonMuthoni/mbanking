import 'dart:convert';

import 'package:mbanking/General/Constants.dart';
import 'package:http/http.dart' as http;

class UserLoan{
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

  UserLoan({this.id, this.userId, this.title, this.description,
    this.project_image, this.amountBorrowed, this.balance, this.status,
    this.paymentstatus, this.created_at});


  Future<List<UserLoan>> fetchUserLoans() async{
    try{

      List<UserLoan> userLoans = [];

      final response = await http.Client().get(BASE_URL+"api/userloans",headers:RequestHeaders);

      final jsonData =  jsonDecode(response.body);
      print(response.body);
      if (response.statusCode == 200) {
         for(var json in jsonData){
           UserLoan userLoan =  UserLoan(
             id:json['id'],
             userId: json['userId'],
             title: json['title'],
             description: json['description'],
             project_image: json['project_image'],
             amountBorrowed: json['amountBorrowed'],
             balance: json['balance'],
             status: json['status'],
             paymentstatus: json['paymentstatus'],
             created_at: json['created_at'],
           );
           userLoans.add(userLoan);
         }
         return userLoans;
      }

    }
    catch(e){

    }
  }


}