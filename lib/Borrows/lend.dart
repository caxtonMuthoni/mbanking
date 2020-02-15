import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:mbanking/Account/accountHome.dart';
import 'package:mbanking/Animation/FadeAnimation.dart';
import 'package:mbanking/General/Constants.dart';
import 'package:mbanking/Home/home.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sweetalert/sweetalert.dart';

class LendNow extends StatefulWidget {

  String borrowerId;
  String amountLend;
  String borrowId;


  LendNow({this.borrowerId, this.amountLend, this.borrowId});

  @override
  _LendNowState createState() => _LendNowState();
}

bool _isLoading = false;




TextEditingController textEditingController = new TextEditingController();
final _formKey = GlobalKey<FormState>();


class _LendNowState extends State<LendNow> {
  @override
  Widget build(BuildContext context) {

    ProgressDialog pr = new ProgressDialog(context,type: ProgressDialogType.Normal);
    pr.style(
        message: 'Processing Transaction ...',
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

    lendCash(String amount,String borrowerid,String borrowid) async{

      Map<String , String>  data ={
        "borrowerId":borrowerid,
        "amountLend":amount,
        "borrowId": borrowid
      };


      SharedPreferences sharedPreferences = await  SharedPreferences.getInstance();
      String token = sharedPreferences.getString("token");

      Map<String, String>  Headers = {
        'Content-type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        'Authorization':'Bearer '+token,
      };

      try{
        final response = await http.Client().post(BASE_URL+"api/lend",body: data,headers: Headers);
        if(response.statusCode == 200){
          pr.hide();
          var jsonData = jsonDecode(response.body);
          if(jsonData['status'] == "true" ){
            SweetAlert.show(context,
               title: "Success",
              subtitle: jsonData['success'],
              style: SweetAlertStyle.success
            );
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeMain()));
          } else{
            SweetAlert.show(context,
                title: "Error",
                subtitle: jsonData['error'],
                style: SweetAlertStyle.error
            );
          }

        }else{
          pr.hide();
        }
      }catch(e){
        pr.hide();
        print(e);
      }

    }


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
                            child: Text("Fund a Loan",
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
                            child: Text("Note the maximum and minimum amount to fund is KES 70,000 and 100 respectively. ",
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
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(color: Colors.grey[100]))
                                    ),
                                    child:  TextFormField(
                                      controller: textEditingController,
                                      keyboardType: TextInputType.number,
                                      validator: (value){
                                        if(value.isEmpty){
                                          return "The amout field is required";
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
                                        labelText: "Enter the Amount to fund",
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
                        onTap: (){

                          setState(() {
                            _isLoading = true;
                          });



                          if(_formKey.currentState.validate()){
                            lendCash(textEditingController.text, widget.borrowerId, widget.borrowId);
                            pr.show();
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
                            child: Text("Fund Now", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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
