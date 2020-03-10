import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mbanking/Animation/FadeAnimation.dart';
import 'package:http/http.dart' as http;
import 'package:mbanking/General/Constants.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sweetalert/sweetalert.dart';

class Airtime extends StatefulWidget {
  @override
  _AirtimeState createState() => _AirtimeState();
}

class _AirtimeState extends State<Airtime> {
  final _airtimeFormKey =  GlobalKey<FormState>();
  TextEditingController phoneEditingController = new TextEditingController();
  TextEditingController amountEditingController = new TextEditingController();
  ProgressDialog pr;
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
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
                            child: Text("Buy Airtime",
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
                            child: Text("Get Connected wit family and friends today. Buy airtime  here.",
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
                  child: Form(
                    key: _airtimeFormKey,
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
                                      controller: phoneEditingController,
                                      keyboardType: TextInputType.number,
                                      validator: (value){
                                        if(value.isEmpty){
                                          return "Phone Number is Required";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                                color: Color.fromRGBO(143, 143, 251, 1)
                                            )
                                        ),
                                        labelText: "Enter Phone Number",
                                        hintText: "Phone Number",
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
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(color: Colors.grey[100]))
                                    ),
                                    child:  TextFormField(
                                      controller: amountEditingController,
                                      validator: (value){
                                        if(value.isEmpty){
                                          return "Airtime amount is required";
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                                color: Color.fromRGBO(143, 143, 251, 1)
                                            )
                                        ),
                                        labelText: "Enter Airtime amount",
                                        hintText: "Airtime amount",
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
                            if (_airtimeFormKey.currentState.validate()) {
                                pr.show();
                                buyAirtime(phoneEditingController.text, amountEditingController.text);
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
                              child: Text("Buy Airtime", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            ),
                          )),
                        ),

                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
    );;
  }

  void buyAirtime(String phone, String amount) async {
    Map<String,String> data = {
      'phone' : phone,
      'amount' : amount,
    };
    try{

      final response = await http.Client().post(BASE_URL+'api/buyairtime',body: data,headers: HeadersPost);
      final jsonData = jsonDecode(response.body);
      print(response.body);
      if (response.statusCode == 200) {
        if(jsonData['status'] == 'true'){
          Future.delayed(Duration(seconds: 3)).then((value) {
            pr.hide().whenComplete(() {
              SweetAlert.show(context,
                  style: SweetAlertStyle.success,
                  title: "Success",
                  subtitle: jsonData['success']
              );
            });
          });
        }

        if(jsonData['status'] == 'false'){
          Future.delayed(Duration(seconds: 3)).then((value) {
            pr.hide().whenComplete(() {
              SweetAlert.show(context,
                  style: SweetAlertStyle.error,
                  title: "Oops",
                  subtitle: jsonData['error']
              );
            });
          });
        }

      }

    }catch(e){

    }
  }
}
