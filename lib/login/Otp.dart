import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:mbanking/Account/Airtime.dart';
import 'package:mbanking/Account/depositWithdraw.dart';
import 'package:mbanking/Account/lipaNaMpesaTransfer.dart';
import 'package:mbanking/Account/payBill.dart';
import 'package:mbanking/Animation/FadeAnimation.dart';
import 'package:mbanking/Register/personalInfo.dart';

import '../Home.dart';

class OTPVerification extends StatefulWidget {
  String type;
  OTPVerification(this.type);
  @override
  _OTPVerificationState createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/background.png'),
                        fit: BoxFit.fill
                    )
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 140,
                      width: 80,
                      height: 130,
                      child: FadeAnimation(1.3, Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/light-2.png')
                            )
                        ),
                      )),
                    ),
                    Positioned(
                      right: 40,
                      top: 40,
                      width: 80,
                      height: 130,
                      child: FadeAnimation(1.5, Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/clock.png')
                            )
                        ),
                      )),
                    ),
                    Positioned(
                      child: FadeAnimation(1.6, Container(
                        margin: EdgeInsets.only(top: 0),
                        child: Center(
                          child: Text("AUTHENTICATION",
                            style: TextStyle(color: Colors.white, fontSize: 30,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'ptserif'),),
                        ),
                      )),
                    ),

                    Positioned(
                      child: FadeAnimation(1.6, Container(
                        margin: EdgeInsets.only(top: 85),
                        child: Center(
                          child: Text("A  4 digit security code OTP was sent to your phone.Use if for authentication purpose",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 18,
                                fontWeight: FontWeight.bold,
                            fontFamily: 'ptserif'),),
                        ),
                      )),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    FadeAnimation(1.8,
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(143, 148, 251, .2),
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10)
                                )
                              ]
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[100]))
                                ),
                                child:  TextFormField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                            color: Color.fromRGBO(143, 143, 251, 1)
                                        )
                                    ),
                                    labelText: "Enter the security code",
                                    hintText: "Security Code",
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
                              ),
                            ],
                          ),
                        )),
                    SizedBox(height: 50,),
                    GestureDetector(
                      onTap: (){

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
                          default :
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));

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
                          child: Text("Continue", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        ),
                      )),
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  @override
  void didUpdateWidget(OTPVerification oldWidget) {

  }
}
