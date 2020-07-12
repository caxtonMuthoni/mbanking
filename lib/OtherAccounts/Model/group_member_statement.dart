import 'dart:convert';

import 'package:mbanking/General/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MemberStatement{

  int id;
  String transactionID;
  String phone;
  String description;
  String amount;
  String originalBal;
  String newBal;
  String date;

  MemberStatement({this.id, this.transactionID, this.phone, this.description,
    this.amount, this.originalBal, this.newBal, this.date});


  Future<List<MemberStatement>> fetchMemberStatement( String accountNumber, String userId) async{


    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.get("token");
    setToken(token);

    Map<String,dynamic> data ={
      "AccountNumber" : accountNumber,
      "userId" : userId,
    };

    List<MemberStatement> memberStatements = [] ;

    try{
      final response = await http.Client().post(BASE_URL + 'api/usertransaction', headers: HeadersPost,body: data);
      final jsonData = jsonDecode(response.body);
      if(response.statusCode == 200){
        for(var json in jsonData['data']){
          MemberStatement memberStatement = MemberStatement(
            id:json['id'],
            transactionID:json['transactionID'],
            phone:json['phone'],
            description:json['description'],
            amount:json['amount'].toString(),
            originalBal:json['original_bal'].toString(),
            newBal:json['new_bal'].toString(),
            date:json['date'],
          );

          memberStatements.add(memberStatement);
        }
      }

    }catch(e){
      print(e);
    }

    return memberStatements;


  }






}