import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mbanking/General/Constants.dart';

class AccountType{
  int id;
  String Name;
  String Code;
  String Fee;
  String created_at;

  AccountType({this.id, this.Name, this.Code, this.Fee, this.created_at});



  Future < List<AccountType>> fetchAccountTypes() async{
    List<AccountType> accountTypes = [];
    try{
       final response = await http.Client().get(BASE_URL+"api/accounttypes",headers: RequestHeaders);
       if(response.statusCode == 200){
         var jsonData = jsonDecode(response.body);
         for( var json in jsonData){
           AccountType accountType = AccountType(
             id: json['id'],
             Name: json['Name'],
             Code: json['Code'],
             Fee: json['Fee'],
             created_at: json['created_at'],
           );
           accountTypes.add(accountType);
         }

         return accountTypes;
       }
       return accountTypes;
    }catch(e){
      return accountTypes;
    }
  }


}