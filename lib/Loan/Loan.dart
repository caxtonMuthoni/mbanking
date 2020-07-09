import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mbanking/Loan/loans_history.dart';
import 'package:mbanking/Loan/model/user_loan_deatil.dart';
import 'package:mbanking/Loan/pay_loan.dart';
import 'package:mbanking/Loan/request_loan.dart';
import 'package:mbanking/utils/constants.dart';
import 'package:mbanking/utils/string_formatter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sweetalert/sweetalert.dart';

class Loan extends StatefulWidget {
  @override
  _LoanState createState() => _LoanState();
}

class _LoanState extends State<Loan> {
  String loanBalance = "0";

  String loanLimit = "0";

  int loanId = 0;

  String loanStatus = "active";

  var details;

  String loanAlias = "0";

  var stringFomatter = StringFormatter();

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var userDetail = UserLoanDetail(context:context);
    getdetail(userDetail);
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
                    Text("Loan Balance :  $loanBalance",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'BowlbyOneSC',
                      fontWeight: FontWeight.w400,
                      color: white
                    ),),
                    Text("Loan Alias :  $loanAlias",
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
                    tile("Loan Application","Request for a new laon","apply","new",FontAwesomeIcons.check,success),
                    Divider(color: secondary,),
                    tile("Loan History", "Get my loan details","loan_history", "history", FontAwesomeIcons.history,info),
                    Divider(color: secondary,),
                    tile("Loan Limit", "Check my Loan Limit", "loan_limit", stringFomatter.formatString(loanLimit), FontAwesomeIcons.balanceScale,secondary),
                    Divider(color: secondary,),
                    showPaymentTile(),

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
        case 'apply':
          Navigator.push(context, MaterialPageRoute(builder: (context) => RequestLoan(),));
          break;
        case 'loan_status':
//          TODO :: navigate to loan application form
          break;
        case 'loan_history':
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoanHistory(),));
          break;
        case 'loan_limit':
           showdialog();
          break;

      }
  }

  showdialog() {
    print("showdilgo called");
    return ProgressDialog(context,type:ProgressDialogType.Normal);
  }

   getdetail(UserLoanDetail userDetail) async{
       var response =  await userDetail.getUserLoanDetail();
       setState(() {
         details = response;
         loanBalance = response.balance;
         loanLimit = response.limit;
         loanStatus = response.status;
         loanAlias = response.aliases;
         loanId = response.id;
       });

   }

  showPaymentTile() {

      return ListTile(
        leading: Icon(FontAwesomeIcons.moneyCheck,color: primary,),
        selected: true,
        title: Text("Loan Payment",
          style: TextStyle(
            fontFamily: 'ptserif',
            fontWeight: FontWeight.bold,
            color: paleBlack,
          ),
        ),
        subtitle: Text("make payment  to the outstanding loan",
          style: TextStyle(
              fontFamily: 'YeonSung'
          ),),
        onTap: (){
          if(int.parse(loanBalance) > 0){
            Navigator.push(context, MaterialPageRoute(builder: (context) => PayLoan(loanId),));
          }else{
            SweetAlert.show(context,
              title: 'Mbanking Info',
              subtitle: 'You don\'t have an outstanding loan.',
              style: SweetAlertStyle.success,
            );
          }
        },
      );

  }
}
