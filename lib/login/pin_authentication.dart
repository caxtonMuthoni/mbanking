import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mbanking/Account/accountHome.dart';
import 'package:mbanking/Models/pin_auth.dart';
import 'package:mbanking/SQL/db_helper.dart';
import 'package:mbanking/SQL/user.dart';
import 'package:mbanking/utils/constants.dart';
import 'package:mbanking/widgets/otpInputField.dart';

class PinAuth extends StatefulWidget {
  String page;

  PinAuth(this.page);

  @override
  _PinAuthState createState() => _PinAuthState();
}

class _PinAuthState extends State<PinAuth> {
  String pinNum;
  String num1 = "_";
  String num2 = "_";
  String num3 = "_";
  String num4 = "_";
  var dbHelper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pinNum = '';
    dbHelper = DBHelper();
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
                  Text("Enter your security pin.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 23.0,
                        fontFamily: 'YeonSung'
                    ),),
                  SizedBox(height: 50.0,),
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

  void confirmPin(String pinNumber) async{
    pinNum = '';
    await dbHelper.db;
    List<User> users = await dbHelper.getUserLength();
    String phone = users[0].phone;
    PinAuthentiction pinAuth = PinAuthentiction(pinNumber, phone);
    String code = await pinAuth.login(context);
    if(code == '200'){
      navigateTo();
    }
  }

  void navigateTo() {
    switch(widget.page){
      case 'account' :
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AccountHome()));
        break;
    }
  }
}
