
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mbanking/Loan/loan_guarantors.dart';
import 'package:mbanking/Loan/loan_payment_details.dart';
import 'package:mbanking/utils/constants.dart';
import 'package:mbanking/utils/date_formatter.dart';
import 'package:mbanking/utils/string_formatter.dart';

import 'model/user_loans.dart';

class LoanDetail extends StatefulWidget {

  UserLoans userLoan;


  LoanDetail(this.userLoan);

  @override
  _LoanDetailState createState() => _LoanDetailState();
}

class _LoanDetailState extends State<LoanDetail> {

  var formatDate;
  var formatString;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formatDate = FormatDate();
    formatString = StringFormatter();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(143, 148, 251, 1),
          title: Text(widget.userLoan.loanType.toUpperCase()),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    loanHeader("Loan Detail:",FontAwesomeIcons.list,primary),
                    Divider(height: 8,color: black,thickness: 2,),
                    loanBody("Borrower:","Date:",formatName(widget.userLoan.borrower),formatDate.formatDate(widget.userLoan.startDate),primary),
                    Divider(height: 8,color: black,thickness: 2,),
                    loanBody("Amount:","Interest:", formatString.formatString(widget.userLoan.borrowedAmount), formatString.formatString(widget.userLoan.interest),success),
                    Divider(height: 8,color: black,thickness: 2,),
                    loanBody("Period:","Installent/mth:",widget.userLoan.period, formatString.formatString(widget.userLoan.installment),info),
                    Divider(height: 8,color: black,thickness: 2,),
                    loanBody("Alias:","Status:", formatString.formatString(widget.userLoan.alias),widget.userLoan.status.trim(),danger),
                  ]
                ),
              ),

              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    loanHeader("Loan Payment Details:",FontAwesomeIcons.moneyBill,success),
                    Divider(height: 4,color: black,thickness: 2,),
                    loanBody("Total payable:","Paid Amt:", formatString.formatString(widget.userLoan.totalRepayable), formatString.formatString(widget.userLoan.paidAmount),primary),
                    Divider(height: 4,color: black,thickness: 2,),
                    loanBody("Started at:","Due date:",formatDate.formatDate(widget.userLoan.startDate),formatDate.formatDate(widget.userLoan.dueDate),info),
                    Divider(height: 4,color: black,thickness: 2,),
                    SizedBox(width: 40.0,),
                    FlatButton(color: white,
                        child: Text("View payment details",
                          style: TextStyle(
                            fontFamily: 'ptserif',
                            fontWeight: FontWeight.bold,
                            color: info,
                          ),
                        ),
                      onPressed: (){

                        navigateTo("loan_payment_details",widget.userLoan.id);
                      },
                      shape: Border.all(color: info),
                      splashColor: info,

                    ),
                  ],
                ),
              ),

              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    loanHeader("Loan Guarantors:",FontAwesomeIcons.palette,info),
                    Divider(height: 8,color: black,thickness: 2,),
                    loanBody("Guarantor Amt:","Guaranteed Amt:", formatString.formatString(widget.userLoan.guarantorAmount), formatString.formatString(widget.userLoan.guaranteedAmount),primary),
                    Divider(height: 8,color: black,thickness: 2,),
                    SizedBox(width: 40.0,),
                    FlatButton(color: white,
                        child: Text("View loan Guarantors",
                          style: TextStyle(
                            fontFamily: 'ptserif',
                            fontWeight: FontWeight.bold,
                            color: primary,
                          ),
                        ),
                        onPressed: (){
                          navigateTo("loan_guarantors",widget.userLoan.id);
                        },
                        shape: Border.all(color: primary),
                        splashColor: primary,

                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }

  loanHeader(String title, IconData icon, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(icon,color: color,size: 15,),
        SizedBox(width: 10.0,),
        Text(title,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),)
      ],
    );
  }

  loanBody(String title1, String title2, String value1, String value2, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(title1,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: secondary,
                    decorationColor: primary,
                    decorationThickness: 1.0
                ),),
              Text(value1,textAlign: TextAlign.center,
                style: TextStyle(
                    color: color,
                    fontFamily: 'ptserif'
                ),),
            ],
          ),
        ),
        SizedBox(width: 15.0,),
        Expanded(
          flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(title2,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: secondary,
                    decorationColor: primary,
                    decorationThickness: 1.0
                ),),
              Text(value2,textAlign: TextAlign.center,
                style: TextStyle(
                    color: color,
                    fontFamily: 'ptserif'
                ),),
            ],
          ),
        )
      ],
    );
  }

  void navigateTo(String s,int id) {
    switch(s){
      case "loan_payment_details":
            Navigator.push(context, MaterialPageRoute(builder: (context) => LoanPaymentDetails(id),));
        break;
      case "loan_guarantors" :
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoanGuarantors(id),));
        break;

    }
  }

  String formatName(String borrower) {
     if(borrower.length >12){
       borrower = borrower.substring(0,9) + "...";
     }
     return borrower;
  }
}
