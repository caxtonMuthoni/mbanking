import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:mbanking/Account/accountHome.dart';
import 'package:mbanking/Account/confrimPayment.dart';
import 'package:mbanking/Animation/FadeAnimation.dart';
import 'package:mbanking/General/Constants.dart';
import 'package:http/http.dart' as http;
import 'package:sweetalert/sweetalert.dart';

class DepositWithDraw extends StatefulWidget {
 final String type;
  DepositWithDraw(this.type);
  @override
  _DepositWithDrawState createState() => _DepositWithDrawState();
}

 TextEditingController phoneTextEditingController = new TextEditingController();
TextEditingController amountTextEditingController = new TextEditingController();

class _DepositWithDrawState extends State<DepositWithDraw> {

  final GlobalKey<ScaffoldState> scaffoldKey =
  GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();

  deposit(String phone,String amount) async{
    Map<String ,String> data = {
      "PhoneNumber":phone,
      "Amount":amount

    };
    try{

      final response = await http.Client().post(BASE_URL+"/api/stkpush",body: data, headers: HeadersPost);
      print(response.body);
      print(response.statusCode);
      final jsonData = jsonDecode(response.body);
      if(response.statusCode == 200){
        var jsonData = jsonDecode(response.body);
        if(jsonData["status"]){
          SweetAlert.show(context,
          title: "Success",
            subtitle: jsonData['response']['TransactionStatus'],
            style: SweetAlertStyle.success,
          );
          Future.delayed(const Duration(milliseconds: 10000), () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ConfirmPaymnet()));
          });

        }

        else {
          SweetAlert.show(context,
            title: "error",
            subtitle: jsonData['error'],
            style: SweetAlertStyle.error,
          );
        }
      }

      if(response.statusCode == 422){
       if(jsonData['errors']['PhoneNumber'] != null){
        SweetAlert.show(context,
          style: SweetAlertStyle.error,
          title: "Phone Number Error !!!",
          subtitle: jsonData['errors']['PhoneNumber'][0],
        );
        return;
      }
       if(jsonData['errors']['Amount'] != null){
         SweetAlert.show(context,
           style: SweetAlertStyle.error,
           title: "Amount Error !!!",
           subtitle: jsonData['errors']['Amount'][0],
         );
         return;
       }
      }
      else{
        SweetAlert.show(context,
          title: "Transaction Failed",
          subtitle: jsonData['response'],
          style: SweetAlertStyle.error,
        );
      }

    }catch(e){
      SweetAlert.show(context,
        title: "Transaction Failed",
        subtitle: e,
        style: SweetAlertStyle.error,
      );
      print(e);
    }

  }
  withdral(String phone,String amount) async{
    Map<String ,String> data = {
      "PhoneNumber":phone,
      "Amount":amount

    };
    try{

      final response = await http.Client().post(BASE_URL+"/api/withdraw",body: data, headers: HeadersPost);
      print(response.body);
      print(response.statusCode);
      final jsonData = jsonDecode(response.body);
      if(response.statusCode == 200){
        var jsonData = jsonDecode(response.body);
        if(jsonData["status"] =="true"){
          SweetAlert.show(context,
            title: "Success",
            subtitle: jsonData['success'],
            style: SweetAlertStyle.success,
          );
          Future.delayed(const Duration(milliseconds: 3000), () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AccountHome()));
          });

        }

        else {
          SweetAlert.show(context,
            title: "error",
            subtitle: jsonData['error'],
            style: SweetAlertStyle.error,
          );
        }
      }

      else if(response.statusCode == 422){
        if(jsonData['errors']['PhoneNumber'] != null){
          SweetAlert.show(context,
            style: SweetAlertStyle.error,
            title: "Phone Number Error !!!",
            subtitle: jsonData['errors']['PhoneNumber'][0],
          );
          return;
        }
        if(jsonData['errors']['Amount'] != null){
          SweetAlert.show(context,
            style: SweetAlertStyle.error,
            title: "Amount Error !!!",
            subtitle: jsonData['errors']['Amount'][0],
          );
          return;
        }
      }
      else{
        SweetAlert.show(context,
          title: "Transaction Failed",
          subtitle: jsonData['response'],
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
      key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              key: GlobalKey(),
              children: <Widget>[
                Container(
                  key: GlobalKey<FormState>(),
                  height: 300,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/background.png'),
                          fit: BoxFit.fill
                      )
                  ),
                  child: Stack(
                    key: GlobalKey<FormState>(),
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
                            child: Text(widget.type,
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
                            child: Text("Note the maximum and minimum amount to "+widget.type+" is KES 70,000 and 100 respectively. ",
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
                            key: ValueKey('djgfsjdjfgjewyg'),
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
                              key: _formKey,
                              child: Column(
                                key: ValueKey("ghdsfgyuwggsjdgyu"),
                                children: <Widget>[
                                  Container(
                                    key: ValueKey("hfjsdjfjehgfgu"),
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(color: Colors.grey[100]))
                                    ),
                                    child:  TextFormField(
                                      key: ValueKey("bdsgfiufgiuww"),
                                      controller: phoneTextEditingController,
                                      validator: (value){
                                        if(value.isEmpty){
                                          return "Your Phone number is requied";
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
                                        labelText: "Enter the  phone number "+widget.type,
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
                                    key: ValueKey("shfjsgfjgjsdgfjgy"),
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(color: Colors.grey[100]))
                                    ),
                                    child:  TextFormField(
                                      key: ValueKey("dhjfgjdsgfshfsd"),
                                      controller: amountTextEditingController,
                                      validator: (value){
                                        if(value.isEmpty){
                                          return "Amount field is required";
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
                                        labelText: "Enter the Amount to "+widget.type,
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
                            ),
                          )),
                      SizedBox(height: 50,),
                      GestureDetector(
                        key: ValueKey("dfhjdjsfgsdg"),
                        onTap: (){
                            if(_formKey.currentState.validate()){
                              if(type == "deposit"){
                                deposit(phoneTextEditingController.text,amountTextEditingController.text);
                              }
                              else{
                                withdral(phoneTextEditingController.text, amountTextEditingController.text);
                              }
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
                            child: Text(widget.type, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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
