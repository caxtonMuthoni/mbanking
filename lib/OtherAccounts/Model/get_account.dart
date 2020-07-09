import 'dart:convert';

import 'package:mbanking/General/constants.dart';
import 'package:mbanking/Models/account.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserAccount{

  int id;
  int accountNumber;
  String accountName;

  UserAccount({this.id, this.accountNumber, this.accountName});


  UserAccount fromJson(Map<String,dynamic> json){
    return UserAccount(
      id: json['id'],
      accountName: json['AccountName'],
      accountNumber: json['AccountNumber']
    );
  }


  Future<UserAccount> getAccount() async{
//    1. Get n set token

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String token = sharedPreferences.get("token");
  setToken(token);

//  2. initializing an instanse of UserAccount;
  UserAccount account;

//  3. Send request to the server
  try{
    final response = await http.Client().get(BASE_URL + 'api/',headers:RequestHeaders);
    final jsonData = jsonDecode(response.body);
    account = account.fromJson(jsonData['account']);
  }catch(e){
    print(e);
  }
  return account;
  }
}

/* "status": true,
    "account": {
        "id": 1,
        "AccountNumber": 33930519,
        "AccountName": "caxton Muthoni",
        "AccountCode": "200",
        "CustomerID": "30",
        "CurrentBalance": "15163.00099999999",
        "Status": "active",
        "created_at": "2020-05-21 00:00:00",
        "updated_at": "2020-07-09 15:03:46"
    }*/