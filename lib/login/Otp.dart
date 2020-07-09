
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mbanking/Account/airtime.dart';
import 'package:mbanking/Account/account_home.dart';
import 'package:mbanking/Account/deposit_withdraw.dart';
import 'package:mbanking/Account/lipa_na_mpesa_transfer.dart';
import 'package:mbanking/Account/pay_bill.dart';
import 'package:mbanking/Account/pay_school_fees.dart';
import 'package:mbanking/home.dart';
import 'package:mbanking/utils/constants.dart';
import 'package:mbanking/widgets/otp_input_field.dart';

class OTPVerification extends StatefulWidget {
  String type;
  OTPVerification(this.type);
  @override
  _OTPVerification createState() => _OTPVerification();
}

class _OTPVerification extends State<OTPVerification> {
  String pinNum;
  String num1 = "_";
  String num2 = "_";
  String num3 = "_";
  String num4 = "_";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pinNum = '';
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: baseColor,
          body:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                  Text("OTP Verification",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 23.0,
                          fontFamily: 'BowlbyOneSC'
                      ),),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text("please provide the 4 digit code that you recieved in your phone number",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontFamily: 'YeonSung'
                        ),),
                    ),
                    SizedBox(height: 30.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InputField(num1),
                        SizedBox(width: 15.0,),
                        InputField(num2),
                        SizedBox(width: 15.0,),
                        InputField(num3),
                        SizedBox(width: 15.0,),
                        InputField(num4),
                      ],
                    ),

                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    pinBtnRow("1","2","3"),
                    pinBtnRow("4","5","6"),
                    pinBtnRow("7","8","9"),
                    pinBtnRow("<","0",">"),
                    SizedBox(height: 30.0,)
                  ],
                ),
              )
            ],
          )
      ),
    );
  }

  pinBtn(String num) {
    return GestureDetector(
      onTap: (){
        getAction(num);
      },
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: pinBtnColor

        ),
        child: Center(
          child: Text(num, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }

  pinBtnRow(String num1, String num2, String num3,) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        pinBtn(num1),
        pinBtn(num2),
        pinBtn(num3)
      ],
    );
  }

  void getAction(String num) {
    int length = pinNum.length;

    if(num =="<" && length>0){
      pinNum = pinNum.substring(0,length-1);
    }else{
      if(num != "<" && num != ">" && length < 4){
        setState(() {
          pinNum += num;
        });
      }else if(num == ">" && pinNum.length == 4){
        confirmPin(pinNum);
      }
    }

    setTextFieldText(pinNum.length);

  }

  void setTextFieldText(int length) {
    String num;
    if(length == 0){
      num = pinNum.substring(0);
    }else{
      num = pinNum.substring(length-1);
    }


    switch(length){
      case 0:
        setState(() {
          num1 = "_";
          num2 = "_";
          num3 = "_";
          num4 = "_";
        });
        break;
      case 1:
        setState(() {
          num1 = num;
          num2 = "_";
          num3 = "_";
          num4 = "_";
        });
        break;
      case 2:
        setState(() {
          num2 = num;
          num3 = "_";
          num4 = "_";
        });
        break;
      case 3:
        setState(() {
          num3 = num;
          num4 = "_";
        });
        break;

      case 4:
        setState(() {
          num4 = num;
        });
        break;
      default:
        print("length is $length");
    }
  }

  void confirmPin(String pinNum) {
    navigateTo();
  }

  void navigateTo() {

    switch (widget.type){
      case "Withdraw" :
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DepositWithDraw(widget.type)));
        break;
      case "PayBill" :
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PayBill()));
        break;
      case "Lipa Na Mpesa" :
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LipaNaMpesaTransfer("Lipa Na Mpesa")));
        break;
      case "Transfer Funds" :
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LipaNaMpesaTransfer("Transfer Funds")));
        break;
      case "airtime" :
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Airtime()));
        break;
      case "fee" :
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PaySchoolFees()));
        break;
      default :
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));

    }

  }


}








//import 'package:email_validator/email_validator.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/painting.dart';
//import 'package:flutter/services.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:mbanking/Account/airtime.dart';
//import 'package:mbanking/Account/deposit_withdraw.dart';
//import 'package:mbanking/Account/lipa_na_mpesa_transfer.dart';
//import 'package:mbanking/Account/pay_bill.dart';
//import 'package:mbanking/Account/pay_school_fees.dart';
//import 'package:mbanking/Animation/FadeAnimation.dart';
//import 'package:mbanking/Register/personal_info.dart';
//import 'package:mbanking/utils/constants.dart';
//import 'package:mbanking/widgets/otp_input_field.dart';
//
//import '../home.dart';
//
//class OTPVerification extends StatefulWidget {
//  String type;
//  OTPVerification(this.type);
//  @override
//  _OTPVerificationState createState() => _OTPVerificationState();
//}
//
//class _OTPVerificationState extends State<OTPVerification> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      backgroundColor: baseColor,
//      body: Padding(
//        padding: const EdgeInsets.all(12.0),
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Expanded(
//              flex: 2,
//              child: Container(
//                child: Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    Padding(
//                      padding: EdgeInsets.only(top: 10.0),
//                    ),
//                    Text("OTP Verification",
//                      style: TextStyle(
//                          color: Colors.white,
//                          fontSize: 23.0,
//                          fontFamily: 'BowlbyOneSC'
//                      ),),
//                    Text("please provide the 4 digit code that you recieved in your phone number",
//                      textAlign: TextAlign.center,
//                      style: TextStyle(
//                          color: Colors.white,
//                          fontSize: 15.0,
//                          fontFamily: 'YeonSung'
//                      ),),
//                    SizedBox(height: 30.0,),
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: <Widget>[
//                        InputField("0"),
//                        SizedBox(width: 5.0,),
//                        InputField("0"),
//                        SizedBox(width: 5.0,),
//                        InputField("0"),
//                        SizedBox(width: 5.0,),
//                        InputField("0"),
//                      ],
//                    ),
//                  ],
//                ),
//              ),
//            ),
//
//
//            Expanded(
//              flex: 1,
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  Padding(
//                    padding: const EdgeInsets.all(28.0),
//                    child: GestureDetector(
//                      onTap: (){
//                          confirmOTP(widget.type,context);
//                      },
//                      child: FadeAnimation(2, Container(
//                        height: 50,
//                        decoration: BoxDecoration(
//                            borderRadius: BorderRadius.circular(10),
//                            gradient: LinearGradient(
//                                colors: [
//                                  Color.fromRGBO(143, 148, 251, 1),
//                                  Color.fromRGBO(143, 148, 251, .6),
//                                ]
//                            )
//
//                        ),
//                        child: Center(
//                          child: Text("Confirm Code", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
//                        ),
//                      )),
//                    ),
//                  ),
//                ],
//              ),
//            )
//
//          ],
//        ),
//      ),
//    );
//  }
//
//  @override
//  void didUpdateWidget(OTPVerification oldWidget) {
//
//  }
//
////  Navigation after  otp verification
//
//  void confirmOTP(String type, BuildContext context) {
//    switch (widget.type){
//      case "Withdraw" :
//        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DepositWithDraw(widget.type)));
//        break;
//      case "PayBill" :
//        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PayBill()));
//        break;
//      case "Lipa Na Mpesa" :
//        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LipaNaMpesaTransfer("Lipa Na Mpesa")));
//        break;
//      case "Transfer Funds" :
//        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LipaNaMpesaTransfer("Transfer Funds")));
//        break;
//      case "airtime" :
//        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Airtime()));
//        break;
//      case "fee" :
//        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PaySchoolFees()));
//        break;
//      default :
//        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
//
//    }
//  }
//}
//
//
