import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mbanking/Animation/FadeAnimation.dart';
import 'package:mbanking/Home.dart';
import 'package:mbanking/Home/home.dart';
import 'package:mbanking/Register/personalInfo.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();
  bool _isLoading = false;

  login(String email, String Password) async{

    Map data ={
      "email":email,
      "password":Password
    };


    Map<String, String> requestHeaders = {
      'Content-type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
    };

    var client = http.Client();

    SharedPreferences sharedPreferences = await  SharedPreferences.getInstance();
    var jsonData = null;


    try{
      var response = await client.post("http://192.168.43.143:8080/api/auth/login",body: data,headers: requestHeaders);

      if(response.statusCode ==200){
        jsonData = jsonDecode(response.body);
        setState(() {
          _isLoading = false;
          print(jsonData['access_token']);
          sharedPreferences.setString("token", jsonData['access_token']);

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeMain()));
        });
      }
      else{
        setState(() {
          _isLoading = false;
        });
       if(response.statusCode == 401){
         SweetAlert.show(context,
          style: SweetAlertStyle.error,
           title: "Access Denied !!!",
           subtitle: "The credentials you provided does no match our records."
         );
       }
      }

    }catch(e){
      setState(() {
        _isLoading=false;
      });
      print(e);
    }

}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _loginFormKey,
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
                          left: 30,
                          width: 80,
                          height: 200,
                          child: FadeAnimation(1, Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/light-1.png')
                                )
                            ),
                          )),
                        ),
                        Positioned(
                          left: 140,
                          width: 80,
                          height: 150,
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
                          height: 150,
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
                            margin: EdgeInsets.only(top: 50),
                            child: Center(
                              child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: _isLoading ? CircularProgressIndicator() : Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey[100]))
                                  ),
                                  child: TextFormField(
                                    controller: emailEditingController,
                                    validator: (value){
                                      if(value.isEmpty){
                                        return "Your email is required";
                                      }
                                      if(EmailValidator.validate(value)==false){
                                        return "Invalid email";
                                      }
                                      return null;

                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email or Phone number",
                                        hintStyle: TextStyle(color: Colors.grey[400])
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: passwordEditingController,
                                  validator: (value){
                                    if(value.isEmpty){
                                      return "Password field is required";
                                    }
                                    return null;
                                  },
                                 obscureText: true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: Colors.grey[400])
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                        SizedBox(height: 30,),
                        GestureDetector(
                          onTap: (){
                            if(_loginFormKey.currentState.validate()){
                             setState(() {
                               _isLoading = true;
                             });
                              login(emailEditingController.text, passwordEditingController.text);
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
                              child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            ),
                          )),
                        ),
                        SizedBox(height: 40,),
                        GestureDetector(
                          onTap: (){

                            Navigator.push(context, MaterialPageRoute(builder: (context)=>PersonalInfo()));
                          },
                          child: FadeAnimation(1.8, Text("Dont have an account,create one for free?",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                            ),
                          )
                          ),
                        ),

                        SizedBox(height: 20,),
                        GestureDetector(
                            onTap: (){
                              /*Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeMain()));*/
                            },
                            child: FadeAnimation(1.5, Text("Forgot Password?", style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),))),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );



  }
}
