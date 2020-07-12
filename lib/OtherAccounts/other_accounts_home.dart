import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mbanking/Account/open_account.dart';
import 'package:mbanking/Home/my_drawer.dart';
import 'package:mbanking/OtherAccounts/account_select.dart';
import 'package:mbanking/OtherAccounts/group_accounts.dart';
import 'package:mbanking/OtherAccounts/my_accounts.dart';
import 'package:mbanking/utils/constants.dart';

class OtherAccountsHome extends StatefulWidget {
  @override
  _OtherAccountsHomeState createState() => _OtherAccountsHomeState();
}

class _OtherAccountsHomeState extends State<OtherAccountsHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mainColor,
        appBar: AppBar(
          backgroundColor: mainColor,
          elevation: 0.0,
          title: Text("Invest With Mbanking"),
        ),
        drawer: MyDrawer(),
        body: Container(
          color: mainColor,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                        radius:50.0,
                        backgroundColor: white,
                        child: Icon(FontAwesomeIcons.ticketAlt,color: mainColor,size: 40.0,)),
                    SizedBox(height: 8.0,),
                    Text("Accounts Management",
                      style: TextStyle(
                        color: white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0))
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 30.0),
                    child: ListView(
                      children: <Widget>[

                        ListTile(
                          leading: CircleAvatar(
                              backgroundColor: success,
                              radius: 20.0,
                              child: Icon(Icons.add_box,color: white,size: 20.0,)),
                          title: Text("New Account"),
                          subtitle: Text("Create a new account"),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>OpenAccount()));
                          },
                        ),

                        Divider(height: 10.0,),
//                        ListTile(
//                          leading: CircleAvatar(
//                              radius: 20.0,
//                               backgroundColor: primary,
//                              child: Icon(Icons.format_list_bulleted,color: white,size: 20.0,)),
//                          title: Text("My Accounts"),
//                          subtitle: Text("Manage my  accounts"),
//                          onTap: (){
//                             Navigator.push(context, MaterialPageRoute(builder: (context) => MyAccounts(),));
//                          },
//                        ),
//
//                        Divider(height: 10.0,),

                        ListTile(
                          leading: CircleAvatar(
                              radius: 20.0,
                              backgroundColor: info,
                              child: Icon(Icons.supervised_user_circle,color: white,size: 20.0,)),
                          title: Text("Group Accounts"),
                          subtitle: Text("View my group accounts"),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => GroupAccounts(),));
                          },
                        ),

                        Divider(height: 10.0,),

                        ListTile(
                          leading: CircleAvatar(
                              radius: 20.0,
                              backgroundColor: primary,
                              child: Icon(Icons.arrow_downward,color: white,size: 20.0,)),
                          title: Text("Deposit"),
                          subtitle: Text("Deposit from main account."),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AccountSelect('deposit'),));
                          },
                        ),

                        Divider(height: 10.0,),

                        ListTile(
                          leading: CircleAvatar(
                              radius: 20.0,
                              backgroundColor: Colors.orange,
                              child: Icon(Icons.arrow_upward,color: white,size: 20.0,)),
                          title: Text("Withdraw"),
                          subtitle: Text("Withdraw to main account."),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AccountSelect('withdraw'),));
                          },
                        ),

                        Divider(height: 10.0,),

                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
