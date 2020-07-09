import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mbanking/Animation/FadeAnimation.dart';
import 'package:mbanking/Loan/model/loan_pay.dart';
import 'package:mbanking/utils/constants.dart';

class PayLoan extends StatefulWidget {
  int loanId;

  PayLoan(this.loanId);

  @override
  _PayLoanState createState() => _PayLoanState();
}

class _PayLoanState extends State<PayLoan> {
  TextEditingController amountEditingController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  var payLoan;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          elevation: 0.0,
          title: Text("Make Loan Payment",
          style: TextStyle(
            color: white,
          ),),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50.0)),
                  color: mainColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.check,color: success, size: 60.0,),
                    SizedBox(height: 20.0,),
                    Text("Loan Payment Process",
                    style: TextStyle(
                      fontSize: 21.0,
                      fontFamily: 'ptserif',
                      fontWeight: FontWeight.bold,
                      color: white
                    ),)
                  ],
                ),

              ),
            ),
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: Form(
                  key: _formkey,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(height: 60.0,),
                        TextFormField(
                          controller: amountEditingController,
                          validator: (value){
                            if(value.isEmpty){
                              return "The amount field is required";
                            }
                            else if(double.parse(value) > 70000) {
                              return "The amount must be less than 70,000";
                            }
                            else{
                              return null;
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(143, 143, 251, 1)
                                )
                            ),
                            labelText: "What is the amount you wish to repay ?",
                            hintText: "eg. 5000",
                            hintStyle: TextStyle(color: Colors.grey[400],
                            ),
                            fillColor: Colors.green,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(

                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 40.0,),

                        payLoanBtn()
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  payLoanBtn() {
    return GestureDetector(
      onTap: () async{
        if(_formkey.currentState.validate()){
          submitLoanPaymentRequest(amountEditingController.text,widget.loanId);
        }

      },
      child: FadeAnimation(2, Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(143, 148, 251, 1),
                  Color.fromRGBO(143, 148, 251, .6),
                ]
            )

        ),
        child: Center(
          child: Text("Complete Loan Payment", style: TextStyle(color: white, fontWeight: FontWeight.bold),),
        ),
      )),
    );
  }

  void submitLoanPaymentRequest(String amount, int loanId) {
    payLoan = PayLoanModel(loanId, amount, context);
    payLoan.payLoan();
    clearTextFields();
  }

  void clearTextFields() {
    amountEditingController.text = "";

  }

}
