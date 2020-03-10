import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mbanking/General/Constants.dart';

class School{
  int id;
  String Name;
  String Location;
  String Paybill;
  String created_at;

  School({this.id, this.Name, this.Location, this.Paybill, this.created_at});

  Future<List<School>> fetchSchools() async{
    try{

      final response = await http.Client().get(BASE_URL+"api/schools",headers: RequestHeaders);
       print(response.body);
       final jsonData = jsonDecode(response.body);
       if (response.statusCode == 200) {
         List<School> schools = [];
         for(var json in jsonData){
            School school = School(
              id: json['id'],
              Name: json['Name'],
              Location: json['Location'],
              Paybill: json['Paybill'],
              created_at: json['created_at'],
            );

            schools.add(school);
         }

         return schools;

       }

       return [];


    }catch(e){
      return [];
    }
  }


}