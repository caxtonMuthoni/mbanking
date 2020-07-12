import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mbanking/General/constants.dart';
import 'package:mbanking/OtherAccounts/Model/group_member.dart';
import 'package:mbanking/OtherAccounts/group_member_statement.dart';
import 'package:mbanking/utils/constants.dart';
import 'package:mbanking/utils/date_formatter.dart';

class GroupMembers extends StatefulWidget {
  String accountId;
  String groupName;
  String AccountNumber;


  GroupMembers(this.accountId, this.groupName,this.AccountNumber);

  @override
  _GroupMembersState createState() => _GroupMembersState();
}

class _GroupMembersState extends State<GroupMembers> {
  
  GroupMember groupMember;
  var dateFormatter = FormatDate();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    groupMember = GroupMember(id: int.parse(widget.accountId));
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          title: Text("${widget.groupName} members",
            style: TextStyle(
              color: white
            ),
          ),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.share,color: white,),onPressed: (){
              shareGroupAccount();
    }),
            SizedBox(width: 10.0,)
          ],
        ),
        body: FutureBuilder(
          future: groupMember.getGroupMembers(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              if(snapshot.data.length == 0 || snapshot.data == null){
                 return Center(child: Text("No Group Members found"),);
              }
              return ListView.builder(
                itemCount: snapshot.data.length,
                  itemBuilder: (context,index){
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 13.0),
                      child: ListTile(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>GroupMemberStatement(
                            userId: snapshot.data[index].userId,
                            username: snapshot.data[index].name,
                            AccountNumber: widget.AccountNumber,
                          )));
                        },
                        leading: CircleAvatar(
                          radius: 29.0,
                          backgroundImage: NetworkImage(BASE_URL +'images/avatar/' +snapshot.data[index].avatar),),
                        title: Text('${snapshot.data[index].name}'),
                        subtitle: Text("${snapshot.data[index].nationalId}. \n Joined on ${dateFormatter.formatDate(snapshot.data[index].joinedAt)}"),
                        trailing: getTrailingStatus(snapshot.data[index].status, snapshot.data[index].role),
                      ),
                    ),
                    Divider(height: 8.0,)
                  ],
                );
              });
            }
            return Center(child: CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }

  getTrailingStatus(int status, String role) {
    role = role.toLowerCase().trim();
    if (status == 1) {
      if (role == 'admin') {
        return getStatusWidget(success, role);
      }

      return getStatusWidget(primary, role);
    }

    return getStatusWidget(secondary, "pending");
  }

  getStatusWidget(Color color, String s) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12.0)), color: color),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 4, bottom: 4),
        child: Text(
          "$s",
          style: TextStyle(color: white, fontFamily: 'ptserif'),
        ),
      ),
    );
  }

  void shareGroupAccount() {
    print("Share group");
  }

}
