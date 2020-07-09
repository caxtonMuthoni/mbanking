import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:mbanking/Account/account_home.dart';
import 'package:mbanking/Animation/FadeAnimation.dart';
import 'package:mbanking/General/constants.dart';
import 'package:mbanking/Models/user.dart';
import 'package:http/http.dart' as http;
import 'package:sweetalert/sweetalert.dart';

class ConfirmPaymnet extends StatefulWidget {
  @override
  _ConfirmPaymnetState createState() => _ConfirmPaymnetState();
}

 final _formKeyState = GlobalKey<FormState>();

 TextEditingController IdTextEditingController = new TextEditingController();


class _ConfirmPaymnetState extends State<ConfirmPaymnet> {

  confirmPayment(String Id) async{
    Map<String ,String> data = {
      "MPESATransactionID": Id

    };
    try{

      final response = await http.Client().post(BASE_URL+"/api/deposit",body: data, headers: HeadersPost);

      final jsonData = jsonDecode(response.body);

      if(response.statusCode == 200){
        var jsonData = jsonDecode(response.body);
           //print(jsonData['status']);
          if(jsonData["status"] == "true" ){
            SweetAlert.show(context,
               title: "Success",
              subtitle: jsonData['success'],
              style: SweetAlertStyle.success,
            );
            Future.delayed(const Duration(milliseconds: 1000), () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountHome()));
            });


          }

           else if(jsonData['status']  == "false") {
             SweetAlert.show(context,
              title: "error",
              subtitle: jsonData['error'],
              style: SweetAlertStyle.error,
            );
          }

      }

     else if(response.statusCode == 422){
           if(jsonData['errors']['MPESATransactionID'] != null){
            SweetAlert.show(context,
              style: SweetAlertStyle.error,
              title: "Phone Number Error !!!",
              subtitle: jsonData['errors']['MPESATransactionID'][0],
            );
            return;
          }

      }
      else{
        SweetAlert.show(context,
          title: "Transaction Failed",
          subtitle: "Please Try again later !!!",
          style: SweetAlertStyle.error,
        );
      }

    }catch(e){

      print(e.toString());
    }

  }

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
                            child: Text("Confrim Payment",
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
                            child: Text("Please enter the MPESA transaction Id to confirm payment ",
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
                            child: Form(
                              key: _formKeyState,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(color: Colors.grey[100]))
                                    ),
                                    child:  TextFormField(
                                      controller: IdTextEditingController,
                                      validator: (value){
                                        if(value.isEmpty){
                                          return "The MPESA transaction Id is requied";
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                                color: Color.fromRGBO(143, 143, 251, 1)
                                            )
                                        ),
                                        labelText: "Enter the  MPESA transaction ID",
                                        hintText: "MPESA Transaction ID",
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
                            ),
                          )),
                      SizedBox(height: 50,),
                      GestureDetector(
                        onTap: (){
                            if(_formKeyState.currentState.validate()){
                              confirmPayment(IdTextEditingController.text);
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
                            child: Text("Confirm Payment", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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
}
