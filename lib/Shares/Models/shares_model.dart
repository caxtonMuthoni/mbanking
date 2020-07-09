import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mbanking/General/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserShares{

  int id;
  String depositContribution;
  String shares;
  String accountId;
  BuildContext context;


  UserShares({this.id, this.depositContribution, this.shares, this.accountId,
    this.context});

  factory UserShares.fromJson(Map<String,dynamic> json){
     return UserShares(
         id:json['id'],
         depositContribution:json['depositContribution'],
         shares:json['shares'],
         accountId:json['accountId'],
     );
  }

  Future<UserShares>getShares() async{
//    1. Get and send token
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.get("token");
    setToken(token);

//    create shares Account;
    await createSharesAccount();
//  2. send request to the server
    try{

      final response = await http.Client().get(BASE_URL + 'api/usershares',headers: RequestHeaders);
      final jsonData = jsonDecode(response.body);


      if(jsonData['status']){
         return UserShares.fromJson(jsonData['shares']);
      }else{
       createSharesAccount();
      }

    }catch(e){
      print(e);
    }

  }

  void createSharesAccount() async{
     try{

       final response = await http.Client().post(BASE_URL + 'api/createshare',headers: RequestHeaders);
       print(response.body);
     }catch(e){
       print(e);
     }
  }
}

/*{
    "status": false,
    "shares": {
        "id": 4,
        "userId": "1",
        "depositContribution": "5000",
        "shares": "6750",
        "accountId": "1",
        "created_at": "2020-05-21 10:05:14",
        "updated_at": "2020-05-22 12:36:26"
    }
}
* */