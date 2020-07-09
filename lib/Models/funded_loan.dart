import 'dart:convert';

import 'package:mbanking/General/constants.dart';
import 'package:mbanking/Models/user_loans.dart';
import 'package:http/http.dart' as http;

class FundedLoan{
  int id;
  int userId;
  int borrowerId;
  int borroweId;
  String transcationId;
  int amountLend;
  String created_at;

  FundedLoan({this.id, this.userId, this.borrowerId, this.borroweId,
    this.transcationId, this.amountLend, this.created_at});
  
  Future <List<FundedLoan>> fetchFundedLoans() async{
    try{
      
      List<FundedLoan> fundedLoans = [];
       final response = await http.Client().get(BASE_URL+"api/mylends",headers: RequestHeaders);
       print(response.body);
       if (response.statusCode == 200) {
         final jsonData = jsonDecode(response.body);

         for(var json in jsonData){
           FundedLoan fundedLoan = FundedLoan(
             id:json['id'],
             userId: json['userId'],
             borrowerId: json['borrowerId'],
             borroweId: json['borroweId'],
             transcationId: json['transcationId'],
             amountLend: json['amountLend'],
             created_at: json['created_at'],
           );
           fundedLoans.add(fundedLoan);
         }

         return fundedLoans;

       }
      
    }catch(e){
      return [];
      
    }
  }


}