import 'dart:convert';

import 'package:mbanking/General/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoanType{

  int id;
  String type;
  String interest;
  String maxAmount;
  String maxPeriod;

  LoanType({this.id, this.type, this.interest, this.maxAmount, this.maxPeriod});


  Future<List<LoanType>> getLoanTypes() async{
//    1. Get and set token

       SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
       String token = sharedPreferences.get("token");
       setToken(token);

//    2. initialize empty list of loan types
       List<LoanType> loanTypes = [];

//    3. Send request to the sender.
       try{

         final response = await http.Client().get(BASE_URL + 'api/loantypes',headers: RequestHeaders);

         final jsonData = jsonDecode(response.body);
          print(jsonData);
         for (var json in jsonData){
            LoanType loanType = LoanType(
                id:json['id'],
                type:json['type'],
                interest:json['interest'].toString(),
                maxAmount:json['maxAmount'].toString(),
                maxPeriod:json['maxPeriod'].toString());
            loanTypes.add(loanType);
         }


       }catch(e){
          print(e);
       }

       return loanTypes;
  }


}

/*
         "id": 1,
        "type": "School Fee Loan",
        "interest": "9",
        "maxAmount": "20000",
        "maxPeriod": "36",
* */