import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mbanking/Animation/FadeAnimation.dart';
import 'package:mbanking/General/Constants.dart';
import 'package:mbanking/Models/Account.dart';
import 'package:mbanking/Models/AccountType.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:http/http.dart' as http;

class OpenAccount extends StatefulWidget {
  @override
  _OpenAccountState createState() => _OpenAccountState();
}

class _OpenAccountState extends State<OpenAccount> {

  int selectedRadioTile;
  bool alertstate;
  ProgressDialog pr;
  final _formState = GlobalKey<FormState>();
  TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    selectedRadioTile = 0;
    alertstate = false;
  }

  setSelectedRadioTile(value){
    setState(() {
      selectedRadioTile = value;
    });
  }

   createAccount(String AccountName, String AccountCode) async{
      try{
         Map<String, String> data = {
           "AccountCode": AccountCode,
           "AccountName": AccountName
         };
         final response = await http.Client().post(BASE_URL+"api/openaccount",body:data,headers:HeadersPost);
         print(response.body);
         final jsonData = jsonDecode(response.body);
         if(response.statusCode == 200){
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
            else if (jsonData['AccountName'] != null) {
              Future.delayed(Duration(seconds: 3)).then((value) {
                pr.hide().whenComplete(() {
                  SweetAlert.show(context,
                    style: SweetAlertStyle.error,
                    title: "AccountName Error",
                    subtitle:jsonData['AccountName'][0],

                  );
                });
              });

            }
            else if (jsonData['AccountCode'] != null) {
              Future.delayed(Duration(seconds: 3)).then((value) {
                pr.hide().whenComplete(() {
                  SweetAlert.show(context,
                    style: SweetAlertStyle.error,
                    title: "Code Error",
                    subtitle:jsonData['AccountCode'][0],

                  );
                });
              });

            }
            else if (jsonData['status'] == "false") {
              Future.delayed(Duration(seconds: 3)).then((value) {
                pr.hide().whenComplete(() {
                  SweetAlert.show(context,
                    style: SweetAlertStyle.error,
                    title: "Oops",
                    subtitle:jsonData['error'],
                  );
                });
              });


            }
            else{
              Future.delayed(Duration(seconds: 3)).then((value) {
                pr.hide().whenComplete(() {
                  SweetAlert.show(context,
                    style: SweetAlertStyle.error,
                    title: "Opps",
                    subtitle:"An Error Occured, Please try again later",

                  );
                });
              });

            }
         }else{
           Future.delayed(Duration(seconds: 3)).then((value) {
             pr.hide().whenComplete(() {
               SweetAlert.show(context,
                 style: SweetAlertStyle.error,
                 title: "Opps",
                 subtitle:"An Error Occured, Please try again later",

               );
             });
           });

         }

      }catch(e){
        Future.delayed(Duration(seconds: 3)).then((value) {
          pr.hide().whenComplete(() {
            SweetAlert.show(context,
              style: SweetAlertStyle.error,
              title: "Opps",
              subtitle:e.toString(),

            );
          });
        });

      }
   }
  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context,type: ProgressDialogType.Normal);
    pr.style(
        message: 'Creating account ...',
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("New Account for free",
          style: TextStyle(
            color: Colors.white,
            fontFamily: ' BowlbyOneSC'
          ),),
          backgroundColor: Color.fromRGBO(143, 148, 251, 1),
        ),
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
                            child: Text("New Account",
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
                            child: Text("Please Note that you cant create More than one account.",
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
                              key: _formState,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(color: Colors.grey[100]))
                                    ),
                                    child:  TextFormField(
                                      controller: _textEditingController,
                                      validator: (value){
                                        if(value.isEmpty){
                                          return "Account Name is required";
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
                                        labelText: "Enter the  Account Name",
                                        hintText: "Account Name",
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
                                  SizedBox(height: 10,),
                                  Text(" Select the type of account you wish to open",
                                    style: TextStyle(
                                        color: Color.fromRGBO(143, 148, 251, 1),
                                        fontFamily: 'ptserif',
                                        fontWeight: FontWeight.bold
                                    ),),
                                  Divider(height: 10, color: Colors.grey[400],),

                                  FutureBuilder(
                                    future: AccountType().fetchAccountTypes(),
                                    builder: (context,snapshot){
                                      if(snapshot.hasError){
                                        print(snapshot.error);
                                      }
                                      if(snapshot.hasData){
                                        return ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: snapshot.data.length,
                                            itemBuilder: (context,index){
                                              return Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,

                                                children: <Widget>[

                                                  RadioListTile(
                                                    title: Text(snapshot.data[index].Name),
                                                    subtitle: Text(snapshot.data[index].Code.toString()),
                                                    activeColor: Colors.green,
                                                    selected: false,
                                                    groupValue: selectedRadioTile,
                                                    value: int.parse(snapshot.data[index].Code),
                                                    onChanged: (val){
                                                      setSelectedRadioTile(val);
                                                      print(selectedRadioTile);
                                                    },
                                                    secondary: OutlineButton(child: Text("Fee: "+snapshot.data[index].Fee.toString())),
                                                  ),
                                                  Divider(height: 10, color: Colors.grey[400],),

                                                ],
                                              );
                                            });
                                      }
                                      else{
                                        return CircularProgressIndicator();
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )),
                      SizedBox(height: 50,),
                      GestureDetector(
                        onTap: (){

                          if(_formState.currentState.validate()){
                                pr.show();
                                createAccount(_textEditingController.text, selectedRadioTile.toString());
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
                            child: Text("Create Account", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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

      ),
    );
  }
}
