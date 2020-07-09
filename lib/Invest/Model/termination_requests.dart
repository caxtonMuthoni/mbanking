import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mbanking/General/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TerminationRequest{

  int id;
  String reason;
  String status;
  String createdAt;

  BuildContext context;


  TerminationRequest({this.id, this.reason, this.status,this.createdAt,
      this.context}); // Get termination requests

  Future<List<TerminationRequest>> getRequests() async{
    //  1. Get and set Tokens

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.get("token");
    setToken(token);

// 2. List<TerminationRequest> requests
    List<TerminationRequest> requests = [];

//   3. Send request to the server
    try{
      final response = await http.Client().get(BASE_URL + 'api/myterminationrequests',headers: RequestHeaders);
      final jsonData = jsonDecode(response.body);
      if(response.statusCode == 200){
        for(var json in jsonData){
            TerminationRequest terminationRequest = TerminationRequest(
              id: json['id'],
              reason: json['reason'],
              status: json['status'].toString(),
              createdAt: json['created_at'],
            );

            requests.add(terminationRequest);
        }
      }
    }catch(e){
      print(e);
    }




    return requests;

  }

}