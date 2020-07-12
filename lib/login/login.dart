
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:mbanking/Animation/FadeAnimation.dart';
import 'package:mbanking/Home/home.dart';
import 'package:mbanking/login/Models/pin_auth.dart';
import 'package:mbanking/Register/personal_info.dart';
import 'package:mbanking/SQL/db_helper.dart';
import 'package:mbanking/utils/constants.dart';
import 'package:progress_dialog/progress_dialog.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();
  final phoneFocus = FocusNode();
  var dbHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper();
  }


  @override
  Widget build(BuildContext context) {

    ProgressDialog pr = new ProgressDialog(context,type: ProgressDialogType.Normal);
    pr.style(
        message: 'Authentication ...',
        borderRadius: 10.0,
        backgroundColor: white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 50.0,
        progressTextStyle: TextStyle(
            color: Colors.deepPurpleAccent, fontSize: 10.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.deepPurpleAccent, fontSize: 19.0, fontWeight: FontWeight.w600)
    );



    return Scaffold(
        backgroundColor: white,
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
                              child: Text("Connect Account", style: TextStyle(color: white, fontSize: 40, fontWeight: FontWeight.bold),),
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
                              color: white,
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
                                child:  Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey[100]))
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: emailEditingController,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (V){
                                      FocusScope.of(context).requestFocus(phoneFocus);
                                    },
                                    validator: (value){
                                      if(value.isEmpty){
                                        return "Your phone is required";
                                      }

                                      return null;

                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: " Phone eg. 07********",
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
                                      return "Pin field is required";
                                    }
                                    return null;
                                  },
                                 obscureText: true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "pin",
                                      hintStyle: TextStyle(color: Colors.grey[400])
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                        SizedBox(height: 30,),
                        GestureDetector(
                          onTap: () async{
                            if(_loginFormKey.currentState.validate()){
                              pr.show();
                              PinAuthentiction pinAuth = PinAuthentiction(passwordEditingController.text,emailEditingController.text);
                              String code = await pinAuth.login(context);
                              if(code == "200"){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeMain()));
                              }else{
                                 Future.delayed(Duration(seconds: 1),()=>{
                                     pr.hide()
                                 });
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
                              child: Text("complete connection", style: TextStyle(color: white, fontWeight: FontWeight.bold),),
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
