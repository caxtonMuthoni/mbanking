
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mbanking/Animation/FadeAnimation.dart';
import 'package:mbanking/Loan/model/loan_types.dart';
import 'package:mbanking/utils/constants.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:http/http.dart' as http;

import 'model/loan_request.dart';

class RequestLoan extends StatefulWidget {
  @override
  _RequestLoanState createState() => _RequestLoanState();
}

class _RequestLoanState extends State<RequestLoan> {
  final descriptionFocus = FocusNode();
  final amountFocus = FocusNode();
  String _value;

  var loanType;

  final _formkey = GlobalKey<FormState>();
  TextEditingController periodEditingController = TextEditingController();
  TextEditingController   amountEditingController = TextEditingController();
  ProgressDialog pr;

  var loantypes = [];
  var requestLoan;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loanType = LoanType();
    loadLoantypes();
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context,type: ProgressDialogType.Normal);
    pr.style(
        message: 'Processing ...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.deepPurpleAccent, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.deepPurpleAccent, fontSize: 19.0, fontWeight: FontWeight.w600)
    );
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Laon Application",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'BowlbyOneSC'
          ),),
          backgroundColor: Color.fromRGBO(148, 143, 251, 1),
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,

                children: <Widget>[
                  SizedBox(height: 20.0,),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        color: Colors.red[200]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text('Please make sure tha all fields are filled',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'ptserif',
                            color: white,
                            fontSize: 15
                        ),),
                    ),

                  ),
                  Divider(height: 20, color: secondary,),
                  SizedBox(height: 20.0,),
                  TextInputField(amountEditingController,
                      "What is the amount you wish to borrow ?",
                       "eg 5000",
                       "amount"
                  ),
                  SizedBox(height: 20.0,),
                  TextInputField(periodEditingController,
                      "How many months will it take you to repay the loan ?",
                      "eg 10",
                      "period"
                  ),

                  SizedBox(height: 30.0,),

                  _normal2Down(),

                  SizedBox(height: 50.0,),

                  requestLoanBtn()

                ],
              )),
            )
          ],
        )
      ),
    );
  }

  TextInputField(TextEditingController controller, String labelText,String hintText,String field) {
    return TextFormField(
      controller: controller,
      validator: (value){
         if(value.isEmpty){
           return "The $field field is required";
         }
         else if(double.parse(value) > 70000 && field == 'amount') {
            return "The loan limit is ksh 70,000";
         }
         else if(double.parse(value) > 48 && field == 'period') {
           return "The maximum period is 48 months";
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
        labelText: labelText,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[400],
        ),
        fillColor: Colors.green,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(

          ),
        ),
      ),
    );
  }


  DropdownButton _normal2Down()  {

   List<DropdownMenuItem<String>> dropDownList = [];

   loantypes.forEach((loanType){
      dropDownList.add(
        DropdownMenuItem<String>(
          value: loanType.id.toString(),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(loanType.type,),
              SizedBox(width: 10),
              Icon(FontAwesomeIcons.check,color: success,),

            ],
          ),
        ),
      );
   });

    return DropdownButton<String>(
      items: dropDownList,
      onChanged: (value) {
        setState(() {
          _value = value;
        });
      },
      hint: Text("Select the type of loan you which to request."),
      value: _value,
      elevation: 2,
      style: TextStyle(color: mainColor, fontSize: 16),
      isDense: true,
      iconSize: 40.0,
    );

  }

  void loadLoantypes() async{

    var lnTypes = await loanType.getLoanTypes();

    setState(() {
      loantypes = lnTypes;
    });
  }

  requestLoanBtn() {
    return GestureDetector(
      onTap: () async{
        if(_formkey.currentState.validate()){
          submitLoanRequest(amountEditingController.text,periodEditingController.text,_value);
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
          child: Text("Submit Loan Request", style: TextStyle(color: white, fontWeight: FontWeight.bold),),
        ),
      )),
    );
  }

  void submitLoanRequest(String amount, String period, String value) {
    requestLoan = RequestLoanModel(context:context,amount: amount,period: period,loanType: value);
    requestLoan.postLoan();
    print(value);
    clearTextFields();
  }

  void clearTextFields() {
    amountEditingController.text = "";
    periodEditingController.text = "";
  }

}

