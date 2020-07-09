import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mbanking/Invest/investments.dart';
import 'package:mbanking/Invest/new_investment.dart';
import 'package:mbanking/Invest/termination_requests.dart';
import 'package:mbanking/utils/constants.dart';

class InvestHome extends StatefulWidget {
  @override
  _InvestHomeState createState() => _InvestHomeState();
}

class _InvestHomeState extends State<InvestHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mainColor,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: mainColor,
          title: Text("Invest With Mbanking"),
        ),
        body:Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: mainColor
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 18.0,),
                    Icon(FontAwesomeIcons.wallet,color: white,size: 60.0,),
                    SizedBox(height: 8.0,),
                    Text("Create high returns from your capital now.",
                    style: TextStyle(
                      color: white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),)
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight:Radius.circular(30.0),topLeft: Radius.circular(30.0)),
                  color: white
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0,top: 20.0),
                  child: ListView(
                    children: <Widget>[
                      Divider(),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Investments(),));
                        },
                        child: ListTile(
                          leading: Icon(FontAwesomeIcons.list,color: success, size: 20.0,),
                          title: Text("Investments",
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w800,
                              fontSize: 18.0
                            ),
                          ),
                          subtitle: Text("View my investments",
                            style: TextStyle(
                                color: secondary,
                                fontWeight: FontWeight.w800,
                                 fontSize: 14.0
                            ),
                          ),
                        ),
                      ),
                      Divider(),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => NewInvestment(),));
                        },
                        child: ListTile(
                          leading: Icon(FontAwesomeIcons.crutch,color: primary, size: 20.0,),
                          title: Text("New Investment",
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w800,
                                fontSize: 18.0
                            ),
                          ),
                          subtitle: Text("start a new investments",
                            style: TextStyle(
                                color: secondary,
                                fontWeight: FontWeight.w800,
                                fontSize: 14.0
                            ),
                          ),
                        ),
                      ),
                      Divider(),
                      ListTile(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TerminationRequests(),));
                        },
                        leading: Icon(FontAwesomeIcons.trash,color: danger, size: 20.0,),
                        title: Text("Investment Termination",
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w800,
                              fontSize: 18.0
                          ),
                        ),
                        subtitle: Text("My investment termination requests",
                          style: TextStyle(
                              color: secondary,
                              fontWeight: FontWeight.w800,
                              fontSize: 14.0
                          ),
                        ),
                      ),
                      Divider(),

                    ],
                  ),
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}
