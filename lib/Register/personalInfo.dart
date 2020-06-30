import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mbanking/General/Constants.dart';
import 'package:mbanking/login/Otp.dart';
import 'package:http/http.dart' as http;
import 'package:mbanking/login/login.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';

class PersonalInfo extends StatefulWidget {
  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  /*=====Controllers===*/
  TextEditingController firstNameTextEditingController = new TextEditingController();
  TextEditingController lastNameTextEditingController = new TextEditingController();
  TextEditingController middleNameTextEditingController = new TextEditingController();
  TextEditingController nationalIdNameTextEditingController = new TextEditingController();
  TextEditingController phoneNumberTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController cityTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();



  /*Form Key*/
  final _registerFormKey = GlobalKey<FormState>();

  /* data loading state*/

  bool _isLoading = false;

  /*Register function*/

  register(
      String firstname,
      String middleName,
      String lastName,
      String email,
      String city,
      String nationalId,
      String password,
      String phonenumber,
      ) async{

    Map data={
      "FirstName":firstname,
      "MiddleName":middleName,
      "LastName":lastName,
      "email":email,
      "City":city,
      "NationalID":nationalId,
      "password":password,
      "PhoneNumber":phonenumber,
    };

    Map<String, String> headers ={
      'Content-type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
    };


    try{
      var client = http.Client();


      var response = await client.post(BASE_URL + "api/auth/signup",body: data,headers: headers);
      var jsonData = jsonDecode(response.body);
      print(response.statusCode);
      if(response.statusCode == 201 ){
        setState(() {
          _isLoading = false;
        });
        print(jsonData);
        if (jsonData['status'] == "true") {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
        }

      }
      else{
        print(response.body);
        setState(() {
          _isLoading = false;
        });

        if(jsonData['errors']['PhoneNumber'] != null){
          SweetAlert.show(context,
            style: SweetAlertStyle.error,
            title: "Phone Number Error !!!",
            subtitle: jsonData['errors']['PhoneNumber'][0],
          );
          return;
        }
        if(jsonData['errors']['email'] != null){
          SweetAlert.show(context,
            style: SweetAlertStyle.error,
            title: "Email Error !!!",
            subtitle: jsonData['errors']['email'][0],
          );
          return;
        }
        if(jsonData['errors']['NationalID'] != null){
          SweetAlert.show(context,
            style: SweetAlertStyle.error,
            title: "National ID error !!!",
            subtitle: jsonData['errors']['NationalID'][0],
          );
          return;
        }

        print(jsonData['errors']['PhoneNumber']);
      }


    }catch(e){
      setState(() {
        _isLoading = false;
      });

      print(e);

    }

  }


  @override
  Widget build(BuildContext context) {
       ProgressDialog pr = new ProgressDialog(context,type: ProgressDialogType.Normal);
       pr.style(
           message: 'Regestering you ...',
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
        backgroundColor:Color.fromRGBO(143, 148, 251, 1),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromRGBO(143, 148, 251, 1),
          elevation: 0.00,
          title: Text("Personal Info",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),),
        ),
        body: Column(
          children: <Widget>[
           Expanded(
             child:  ListView(
               children: <Widget>[
                 SizedBox(height: 15,),
                 CircleAvatar(
                   radius: 45.0,
                   child: Image(
                     width: 60.0,
                     height: 60.0,
                     image: AssetImage('assets/images/register.png'),
                   ) ,
                   backgroundColor: Colors.white60,
                 ),
                 Text("Register your personal Info",
                   textAlign: TextAlign.center,
                   style: TextStyle(
                       color: Colors.white,
                       fontSize: 17,
                       fontFamily: 'YeonSung'
                   ),),
                 SizedBox(height: 20.0,),
                 Expanded(
                   child: Container(
                     decoration: BoxDecoration(
                         color: Colors.white,
                         shape: BoxShape.rectangle,
                         borderRadius: BorderRadius.only(
                             topLeft: Radius.circular(78.0),
                             topRight: Radius.circular(10.0)
                         )
                     ),
                     child: Padding(
                       padding: const EdgeInsets.only(left: 22,right: 8,top: 20,bottom: 20),
                       child:Form(
                         key: _registerFormKey,
                         child: Column(
                           children: <Widget>[
                             Text("About Me",
                               textAlign: TextAlign.center,
                               style: TextStyle(
                                 color: Color.fromRGBO(143, 148, 251, 1),
                                 fontFamily: 'BowlbyOneSC',
                                 fontSize: 18,
                               ),),
                             TextFormField(
                               controller: firstNameTextEditingController,
                               validator: (firstName){
                                 if(firstName.isEmpty){
                                   return "Your first name is required";
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
                                 labelText: "Enter your first name",
                                 hintText: "First Name",
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


                             SizedBox(height: 10,),

                             TextFormField(
                               controller: middleNameTextEditingController,
                               validator: (middleName){
                                 if(middleName.isEmpty){
                                   return "Your middle name is required";
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
                                 labelText: "Enter your middle name",
                                 hintText: "Middle Name eg.githinji",
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

                             SizedBox(height: 10,),

                             TextFormField(
                               controller: lastNameTextEditingController,
                               validator: (value){
                                 if(value.isEmpty){
                                   return "Your last name is required";
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
                                 labelText: "Enter your Last Name",
                                 hintText: "Last Name",
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

                             SizedBox(height: 10,),
                             Text("Contact Info",
                               textAlign: TextAlign.center,
                               style: TextStyle(
                                 color: Color.fromRGBO(143, 148, 251, 1),
                                 fontFamily: 'BowlbyOneSC',
                                 fontSize: 18,
                               ),),

                             TextFormField(
                               controller: emailTextEditingController,
                               validator: (email){
                                 if(email.isEmpty){
                                   return "Your email address is required";
                                 }
                                 if(!EmailValidator.validate(email)){
                                   return "You entered invalid email";
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
                                 labelText: "Enter your Email Address",
                                 hintText: "Email Address eg.example@gmail.com",
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

                             SizedBox(height: 10,),

                             TextFormField(
                               controller: phoneNumberTextEditingController,
                               validator: (phone){
                                 if(phone.isEmpty){
                                   return "Your Phone number is required";
                                 }
                                 if(phone.length != 10){
                                   return "You entered invalid phonenumber";
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
                                 labelText: "Enter your Phone Number",
                                 hintText: "Phone Number eg. 0712345678",
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

                             SizedBox(height: 10,),

                             TextFormField(
                               controller: cityTextEditingController,
                               validator: (city){
                                 if(city.isEmpty){
                                   return "Your City of Residence is required ";
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
                                 labelText: "Enter your city",
                                 hintText: "City eg. Nairobi",
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


                             SizedBox(height: 10,),

                             Text("Security Info",
                               textAlign: TextAlign.center,
                               style: TextStyle(
                                 color: Color.fromRGBO(143, 148, 251, 1),
                                 fontFamily: 'BowlbyOneSC',
                                 fontSize: 18,
                               ),),

                             TextFormField(
                               controller: nationalIdNameTextEditingController,
                               validator: (nationalId){
                                 if(nationalId.isEmpty){
                                   return "Your National ID number is required";
                                 }
                                 if(nationalId.length>8 && nationalId.length<6){
                                   return "You entered an invalid national id number";
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
                                 labelText: "Enter your National ID",
                                 hintText: "National ID",
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

                             SizedBox(height: 10,),


                             TextFormField(
                               controller: passwordTextEditingController,
                               validator: (password){
                                 if(password.isEmpty){
                                   return "The pin field is required !!";
                                 }
                                 if(password.length != 4){
                                   return "The pin field must contain 4 characters";
                                 }
                                 return null;
                               },
                               keyboardType: TextInputType.text,
                               obscureText: true,
                               decoration: InputDecoration(
                                 enabledBorder: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(15),
                                     borderSide: BorderSide(
                                         color: Color.fromRGBO(143, 143, 251, 1)
                                     )
                                 ),
                                 labelText: "Enter your Pin",
                                 hintText: "Pin",
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

                             SizedBox(height: 25,),
                             Container(
                               decoration: BoxDecoration(
                                   border: Border.all(color: Colors.blue),
                                   borderRadius: BorderRadius.all(Radius.circular(50.0))
                               ),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: <Widget>[
                                   Text('Continue',
                                     style: TextStyle(
                                       color: Colors.blue,
                                       fontFamily: 'YeonSung',
                                       fontSize: 16,
                                     ),),
                                   IconButton(
                                       iconSize: 30,
                                       icon:Icon(
                                         Icons.arrow_forward,
                                         color: Colors.blue,
                                       ) ,
                                       onPressed: (){
                                         if(_registerFormKey.currentState.validate()){
                                           setState(() {
                                             _isLoading = true;
                                           });

                                           _isLoading ? pr.show() : pr.hide();

                                           register(firstNameTextEditingController.text,
                                               middleNameTextEditingController.text,
                                               lastNameTextEditingController.text,
                                               emailTextEditingController.text,
                                               cityTextEditingController.text,
                                               nationalIdNameTextEditingController.text,
                                               passwordTextEditingController.text,
                                               phoneNumberTextEditingController.text);

                                         }


                                       }),
                                 ],
                               ),
                             ),
                           ],
                         ),
                       ),
                     ),
                   ),
                 ),
               ],
             ),
           ),

          ],

        ),
      ),
    );

  }
}
