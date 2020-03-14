import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mbanking/Account/Borrows.dart';
import 'package:mbanking/General/Constants.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:http/http.dart' as http;

class RequestLoan extends StatefulWidget {
  @override
  _RequestLoanState createState() => _RequestLoanState();
}

class _RequestLoanState extends State<RequestLoan> {
  final descriptionFocus = FocusNode();
  final amountFocus = FocusNode();
    File _image;

    final _formkey = GlobalKey<FormState>();
    TextEditingController titleEditingController = TextEditingController();
  TextEditingController   descriptionEditingController = TextEditingController();
  TextEditingController   amountEditingController = TextEditingController();
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Laon Application",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'BowlbyOneSC'
          ),),
          backgroundColor: Color.fromRGBO(148, 143, 251, 1),
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:BoxDecoration(
                  color: Color.fromRGBO(249, 68, 24, 0.6),
                  borderRadius: BorderRadius.all(Radius.circular(12.0))
                ) ,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Please note that all the fields are required. Please key in the correct data.',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'YeonSung',
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
              ),
            ),
            Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                     Padding(
                       padding: const EdgeInsets.all(12.0),
                       child: TextFormField(
                         controller: titleEditingController,
                          validator: (v){
                            if(v.isEmpty){
                               return "Project title is required !!!";
                            }
                            return null;
                          },
                         textCapitalization: TextCapitalization.words,
                         textInputAction: TextInputAction.next,
                         keyboardType: TextInputType.text,
                         onFieldSubmitted: (V){
                           FocusScope.of(context).requestFocus(descriptionFocus);
                         },
                         decoration: InputDecoration(
                           labelText: "What is the name of the project you wish to start ?",
                           labelStyle: TextStyle(
                             color: Color.fromRGBO(148, 143, 251, 1),
                             fontFamily: 'ptserif'
                           ),
                           hintText: 'eg. Pay school fees',
                           hintStyle: TextStyle(
                             fontFamily: 'YeonSung'
                           ),
                         ),
                       ),
                     ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: descriptionEditingController,
                        validator: (v){
                          if(v.isEmpty){
                            return "Project description is required !!!";
                          }
                          return null;
                        },
                        focusNode: descriptionFocus,
                        onFieldSubmitted: (v){
                          FocusScope.of(context).requestFocus(amountFocus);
                        },
                        textCapitalization: TextCapitalization.sentences,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.multiline,
                        maxLines: 10,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12.0)),
                              borderSide: BorderSide(color: Color.fromRGBO(143, 148, 251, 1))
                          ),
                          labelText: "Please tell us more about the project .",
                          labelStyle: TextStyle(
                              color: Color.fromRGBO(148, 143, 251, 1),
                              fontFamily: 'ptserif'
                          ),
                          hintText: 'eg. Pay school fees',
                          hintStyle: TextStyle(
                              fontFamily: 'YeonSung'
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: amountEditingController,
                        validator: (v){
                          if(v.isEmpty){
                            return "Project amount is required !!!";
                          }
                          if(int.parse(v) > 70000){
                            return "Project amount must be less or equal to 70,000 !!!";
                          }
                          if(int.parse(v) < 2500){
                            return "Project amount must be greator or equal to 2500 !!!";
                          }
                          return null;
                        },
                        focusNode: amountFocus,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "What is your request amount ?",
                          labelStyle: TextStyle(
                              color: Color.fromRGBO(148, 143, 251, 1),
                              fontFamily: 'ptserif'
                          ),
                          hintText: 'eg. Pay school fees',
                          hintStyle: TextStyle(
                              fontFamily: 'YeonSung'
                          ),
                        ),
                      ),
                    ),

                    Divider(height: 10,),

                    Text('Select a project caption',
                    style: TextStyle(
                      color: Color.fromRGBO(148, 143, 251, 1),
                      fontFamily: 'ptserif',
                      fontSize: 20.0
                    ),),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          onPressed: (){
                            _getImage(false);
                          },
                          color: Colors.blue,
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.image,color: Colors.white,),
                              Text('Gallery',style: TextStyle(color: Colors.white,fontFamily: 'ptserif'),)
                            ],
                          ),
                        ),
                        SizedBox(width: 20.0,),
                        FlatButton(
                          onPressed: (){
                            _getImage(true);
                          },
                          color: Colors.green,
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.camera,color: Colors.white,),
                              Text('Camera',style: TextStyle(color: Colors.white,fontFamily: 'ptserif'),)
                            ],
                          ),
                        )
                      ],
                    ),

                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      child: Image(
                        image: _image != null ? FileImage(_image) : AssetImage('assets/images/loan.png'),
                        width: 200,
                        height: 200,
                      ),
                    ),

                    Divider(height: 15,),

                    RaisedButton(
                      onPressed: (){
                        if (_formkey.currentState.validate()) {
                             pr.show();
                            _postLoan(titleEditingController.text, descriptionEditingController.text, amountEditingController.text,_image);
                        }
                      },
                      color: Color.fromRGBO(148, 143, 251, 1),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25.0,right: 25.0),
                        child: Text(" Request Loan  ",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'ptserif'
                        ),),
                      ),

                    )

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _getImage(bool imageSource) async{
    File image;
    if(imageSource){
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else{
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      _image = image;
    });
  }

  void _postLoan(String title, String description, String amount, File image) async{

    if(image ==  null){
      Future.delayed(Duration(seconds: 3)).then((value) {
        pr.hide().whenComplete(() {
          SweetAlert.show(context,
              style: SweetAlertStyle.error,
              title: "Oops !!!",
              subtitle: "Project caption is required"
          );
        });
      });
    } else{
     String bn64Image = base64Encode(image.readAsBytesSync());
     String name = image.path.split('/').last;
      Map<String , String> data = {
        'title' : title,
        'description' : description,
        'amountBorrowed' : amount,
        'name' : name,
        'image' : bn64Image,
        'type':'android',
      };
      try{

        final response = await http.Client().post(BASE_URL+"api/borrow",headers: HeadersPost,body: data);
        final jsonData = jsonDecode(response.body);
        if(response.statusCode == 200){
          print(response.body);
          if(jsonData['status'] == 'true'){
            Future.delayed(Duration(seconds: 2)).then((value) {
              pr.hide().whenComplete(() => SweetAlert.show(context,
              style: SweetAlertStyle.success,
              title: "Success",
              subtitle: jsonData['success']));
            });
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Borrows()));
          }
          if(jsonData['status'] == 'false'){
            Future.delayed(Duration(seconds: 2)).then((value) {
              pr.hide().whenComplete(() => SweetAlert.show(context,
                  style: SweetAlertStyle.error,
                  title: "Oops !!!",
                  subtitle: jsonData['error']));
            });
          }
          if(jsonData['image'] != null){
            Future.delayed(Duration(seconds: 2)).then((value) {
              pr.hide().whenComplete(() => SweetAlert.show(context,
                  style: SweetAlertStyle.error,
                  title: "Image error !!!",
                  subtitle: jsonData['image'][0]));
            });
            return;
          }
          if(jsonData['description'] != null){
            Future.delayed(Duration(seconds: 2)).then((value) {
              pr.hide().whenComplete(() => SweetAlert.show(context,
                  style: SweetAlertStyle.error,
                  title: "Description error !!!",
                  subtitle: jsonData['description'][0]));
            });
            return;
          }

          if(jsonData['title'] != null){
            Future.delayed(Duration(seconds: 2)).then((value) {
              pr.hide().whenComplete(() => SweetAlert.show(context,
                  style: SweetAlertStyle.error,
                  title: "Title error !!!",
                  subtitle: jsonData['title'][0]));
            });
            return;
          }

          if(jsonData['amountBorrowed'] != null){
            Future.delayed(Duration(seconds: 2)).then((value) {
              pr.hide().whenComplete(() => SweetAlert.show(context,
                  style: SweetAlertStyle.error,
                  title: "Amount error !!!",
                  subtitle: jsonData['amountBorrowed'][0]));
            });
          }

        }
        else{
          Future.delayed(Duration(seconds: 2)).then((value) {
            pr.hide().whenComplete(() => SweetAlert.show(context,
              style: SweetAlertStyle.error,
              title: "Oops !!!",
              subtitle: "Please try again Later",));
          });
        }

      }catch(e){
        Future.delayed(Duration(seconds: 2)).then((value) {
          pr.hide().whenComplete(() => SweetAlert.show(context,
            style: SweetAlertStyle.error,
            title: "Oops !!!",
            subtitle: "Please try again Later",));
        });

      }
    }

  }
}
