import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mbanking/OtherAccounts/Model/get_account.dart';
import 'package:mbanking/OtherAccounts/Model/group_account.dart';
import 'package:mbanking/OtherAccounts/group_members.dart';
import 'package:mbanking/utils/constants.dart';
import 'package:sweetalert/sweetalert.dart';

class GroupAccounts extends StatefulWidget {
  @override
  _GroupAccountsState createState() => _GroupAccountsState();
}

class _GroupAccountsState extends State<GroupAccounts> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController acccountEditingController = TextEditingController();
  GroupAccount groupAccount;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    groupAccount = GroupAccount(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Group Accounts"),
          backgroundColor: mainColor,
        ),
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Form(
              key: _formkey,
              child: Container(
                decoration: BoxDecoration(
                    color: black,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "Join a group by entering the account number",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: primary,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                controller: acccountEditingController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Group account Number is required";
                                  }else if(isInvalidAccount(value)){
                                    return "The group account number is invalid";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: "Enter Account Number",
                                  hintText: "eg 20140504045",
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Color.fromRGBO(
                                              143, 143, 251, 1))),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(width: 1.1),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: FlatButton(
                                    onPressed: () {
                                      if (_formkey.currentState.validate()) {
                                        searchAccount(
                                            acccountEditingController.text);
                                      }
                                    },
                                    color: mainColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.search,
                                          color: white,
                                          size: 14.0,
                                        ),
                                        SizedBox(
                                          width: 4.0,
                                        ),
                                        Text(
                                          "search",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: white),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                child: FutureBuilder(
                  future: groupAccount.getGroupAccounts(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.length == 0 || snapshot.data == null) {
                        return Center(
                          child: Text("No Group Account Found."),
                        );
                      }
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: <Widget>[
                                ListTile(
                                  onTap:(){
                                     Navigator.push(context, MaterialPageRoute(builder: (context)=>GroupMembers(snapshot.data[index].accountId,snapshot.data[index].accountName,snapshot.data[index].accountNumber)));
                                   },
                                  leading: getLeadingText(
                                      snapshot.data[index].accountName),
                                  title: Text(snapshot.data[index].accountName),
                                  subtitle:
                                      Text(snapshot.data[index].accountNumber),
                                  trailing: getTrailingStatus(
                                      snapshot.data[index].status,
                                      snapshot.data[index].role),
                                ),
                                Divider(
                                  height: 8.0,
                                )
                              ],
                            );
                          });
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void searchAccount(String accountNumber) async{
    var userAccount = UserAccount(
        context: context,
        accountNumber: int.parse(accountNumber) );
    var account = await userAccount.getAccount();
    if(account != null){
      SweetAlert.show(context,
          style: SweetAlertStyle.confirm,
          title: "Are you sure",
          subtitle: " To join  ${account.accountName} account : ${account.accountNumber}",
          showCancelButton: true,
          cancelButtonColor: Colors.green,
          // confirmButtonColor: Colors.green,
          cancelButtonText: "Cancel",
          confirmButtonText: "Yes Join !",
          onPress: (bool value){
            if(value){
              print("Mafia");
             var groupAccount = GroupAccount(context: context,id: account.id);
             groupAccount.joinGroup();
            }
            return true;
          });
    }
  }
  getLeadingText(String s) {
    s = s[0].toUpperCase();

    return CircleAvatar(
      backgroundColor: info,
      radius: 20.0,
      child: Text(
        s,
        style: TextStyle(
            color: white, fontWeight: FontWeight.bold, fontSize: 17.0),
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

  bool isInvalidAccount(String accountNumber) {

    if(accountNumber.startsWith("201")){
      return false;
    }
    return true;

  }
}
