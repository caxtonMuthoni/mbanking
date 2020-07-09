import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mbanking/Loan/request_loan.dart';
import 'package:mbanking/Models/funded_loan.dart';
import 'package:mbanking/Shares/Models/standing_order.dart';
import 'package:mbanking/Shares/Models/shares_model.dart';
import 'package:mbanking/Shares/create_standing_order.dart';
import 'package:mbanking/Shares/shares_deposit.dart';
import 'package:mbanking/Shares/standing_orders.dart';
import 'package:mbanking/utils/constants.dart';

class Shares extends StatefulWidget {
  @override
  _SharesState createState() => _SharesState();
}

class _SharesState extends State<Shares> {

  var details;
  var userShares;

  String sharesBalance = "0";
  String depositContribution = "0";

  String accountId;

  String destinationId;
  @override
  void initState() {
   userShares = UserShares(context: context);
   getdetail(userShares);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          elevation: 0.0,
          title: Text("Loan Info.",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'ptserif',
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        body: details == null ? Center( child: CircularProgressIndicator(),) : Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(45.0),
                    )
                ),
                child: ListView(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 50.0,
                      backgroundColor: white,
                      foregroundColor: white,
                      child: Icon(FontAwesomeIcons.solidCreditCard,color: success,size: 40.5,),
                    ),
                    SizedBox(height: 20,),
                    Text("Shares Balance :  $sharesBalance",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'BowlbyOneSC',
                          fontWeight: FontWeight.w400,
                          color: white
                      ),),
                    Text("Deposit Contribution :  $depositContribution",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'ptserif',
                        fontWeight: FontWeight.w800,
                        color: info,
                        fontSize: 18.0,
                      ),)
                  ],
                ),
              ),
            ),

            Expanded(
              flex: 2,
              child: Container(
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 15.0,),
                    tile("Shares Deposit","Deposit into my shares account","shares_deposit","deposit",FontAwesomeIcons.arrowDown,primary),
                    Divider(color: secondary,),
                    tile("Shares withdrawal", "Request shares withdrawal","shares_withdraw", "withdraw", FontAwesomeIcons.wallet,info),
                    Divider(color: secondary,),
                    tile("Shares standing order", " start shares standing order ","standing_order", "standing order", FontAwesomeIcons.calendarTimes,mainColor),
                    Divider(color: secondary,),
                    tile("Loan Application", "Apply for a new loan", "loan_apply",'', FontAwesomeIcons.check,success),
                    Divider(color: secondary,),


                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  tile(String title, String subtitle, String navigation, String trailing, IconData iconData,Color leadingColor) {
    return ListTile(
      selected: true,
      title: Text(title,
        style: TextStyle(
          fontFamily: 'ptserif',
          fontWeight: FontWeight.bold,
          color: paleBlack,
        ),
      ),
      subtitle: Text(subtitle,
        style: TextStyle(
            fontFamily: 'YeonSung'
        ),),
      trailing: FlatButton(onPressed: (){
        navigateTo(navigation);
      }, child: Text(trailing)),
      leading: Icon(iconData,color: leadingColor,),
      onTap: (){
        navigateTo(navigation);
      },
    );
  }

  navigateTo(String s) {
    print(s);
    switch(s){
      case 'loan_apply':
        Navigator.push(context, MaterialPageRoute(builder: (context) => RequestLoan(),));

        break;
      case 'shares_deposit':
           Navigator.push(context, MaterialPageRoute(builder: (context) => SharesDeposit(),));
        break;
      case 'standing_order':
        navigateToStandingOrder();

        break;
      case 'loan_limit':

        break;

    }
  }



  getdetail(UserShares userShares) async{
    var response =  await userShares.getShares();
    setState(() {
      details = response;
      sharesBalance = response.shares;
      depositContribution = response.depositContribution;
      accountId = response.accountId;
      destinationId = response.id.toString();
    });

  }

  void navigateToStandingOrder() async{
    var standingOrders = StandingOrderModel(context: context);
    var  myStandingOrders = await standingOrders.getStandingOrders();
    if(myStandingOrders.length > 0){
      Navigator.push(context, MaterialPageRoute(builder: (context) => UserStandingOrders(myStandingOrders)));
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context) => StandingOrder(accountId: accountId,destinationId:destinationId),));
    }
  }

}
