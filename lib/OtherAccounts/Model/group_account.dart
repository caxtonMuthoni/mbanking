import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mbanking/General/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GroupAccount {
  int id;
  int status;
  String role;
  String accountNumber;
  String accountName;
  String currentBalance;

  BuildContext context;

  GroupAccount(
      {this.id,
      this.status,
      this.role,
      this.accountNumber,
      this.accountName,
      this.currentBalance,
      this.context});

  /*=========================== Get User Group Accounts ================================ */
  Future<List<GroupAccount>> getGroupAccounts() async {
//    1. Get and set Token
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.get("token");
    setToken(token);

//  2. Initialize an empty list of GroupAccount

    List<GroupAccount> groupAccounts = [];

//  3. Send request to the server
    try {
      final response =
          await http.Client().get(BASE_URL + 'api/usergroupaccounts', headers: RequestHeaders);
      final jsonData = jsonDecode(response.body);
      print(jsonData);
      for (var json in jsonData['data']) {
        GroupAccount groupAccount = GroupAccount(
          id: json['id'],
          status: json['status'],
          role: json['role'],
          accountNumber: json['account_number'].toString(),
          accountName: json['account_name'],
          currentBalance: json['current_balance'],
        );

        groupAccounts.add(groupAccount);
      }
    } catch (e) {
      print(e);
    }
// 4. return the list

    return groupAccounts;
  }
}

/*"id": 1,
            "account_id": "36",
            "status": 1,
            "role": "admin",
            "account_number": 20133930519,
            "account_name": "cdt mega",
            "current_balance": "0"*/
