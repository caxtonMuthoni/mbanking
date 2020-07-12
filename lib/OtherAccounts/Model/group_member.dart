import 'dart:convert';

import 'package:mbanking/General/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GroupMember {

int id;
String name;
String userId;
String nationalId;
String role;
String joinedAt;
int status;
String avatar;

GroupMember({this.id, this.userId,this.name, this.nationalId, this.role, this.joinedAt,this.status,this.avatar});

Future<List<GroupMember>> getGroupMembers() async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String token = sharedPreferences.get("token");
  setToken(token);

  Map<String,dynamic> data ={
    'accountId' : id.toString(),
  };

  List<GroupMember> groupMembers = [];

  try{
      final response = await http.Client().post(BASE_URL + 'api/getgroupmembers',headers: HeadersPost,body: data);
      final jsonData = jsonDecode(response.body);
      print(jsonData);


      for(var json in jsonData){
        GroupMember groupMember = GroupMember(
            id: json['id'],
            userId: json['userId'],
            name: json['name'],
            nationalId: json['nationalId'],
            role: json['role'],
            joinedAt: json['joined_at'],
            status: json['status'],
            avatar: json['avatar'],
        );
        groupMembers.add(groupMember);
      }

  }catch(e){
    print(e);
  }
  return groupMembers;
}


}


/*"id": 4,
        "name": "Caxton Githinji",
        "nationalId": "33930519",
        "role": "admin",
        "joined_at": "2020-07-10T07:37:06.000000Z"*/