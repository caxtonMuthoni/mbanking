import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mbanking/General/Constants.dart';
import 'package:http/http.dart' as http;
import 'package:sweetalert/sweetalert.dart';

class Profile{

  int id;
  int UserId;
  String Avatar;
  int EmploymentStatus;
  String Company;
  String Occupation;
  String AnualIncome;
  String MonthlyIncome;
  String Bio;
  String EducationLevel;
  String created_at;

  Profile({this.id, this.UserId, this.Avatar, this.EmploymentStatus,
    this.Company, this.Occupation, this.AnualIncome, this.MonthlyIncome,
    this.Bio, this.EducationLevel, this.created_at});


  factory Profile.fromJson(Map<String , dynamic> json){
    return Profile(
        id: json["id"],
        UserId: json["UserId"],
        Avatar: json["Avatar"],
        EmploymentStatus: json["EmploymentStatus"],
        Company: json["Company"],
        Occupation: json["Occupation"],
        AnualIncome: json["AnualIncome"],
        MonthlyIncome: json["MonthlyIncome"],
        Bio: json["Bio"],
        EducationLevel: json["EducationLevel"],
        created_at: json["created_at"],
    );
  }

 static  Future<Profile> fetchProfile (BuildContext context) async{


    Profile profile;
    try{
      final response = await http.Client().get(BASE_URL+"api/show",headers: RequestHeaders);
      if(response.statusCode == 200){
        var jsondata = jsonDecode(response.body);
        profile = Profile.fromJson(jsondata);
        return profile;

      }
    }catch(e){
           print(e);
    }

  }




}