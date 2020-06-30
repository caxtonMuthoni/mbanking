import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mbanking/General/Constants.dart';
import 'package:mbanking/Home/home.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:sweetalert/sweetalert.dart';

class Query extends StatefulWidget {
  @override
  _QueryState createState() => _QueryState();
}

class _QueryState extends State<Query> {
  TextEditingController titleEditingController = new TextEditingController();
  TextEditingController reviewEditingController = new TextEditingController();
  final reviewFocus = new FocusNode();
  final _formkey = GlobalKey<FormState>();

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
        backgroundColor: Color.fromRGBO(143, 148, 251, 1),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color.fromRGBO(143, 148, 251, 1),
          title: Text(" Send a Review",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'BowlbyOneSC'
            ),),
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 150,
                child: Center(
                    child:Text('send us your review, We value our customers\' opinions alot.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'BowlbyOneSC',
                      fontSize: 16.0,
                    ),)),

              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0),bottomRight: Radius.circular(40.0)),
                  ),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            controller: titleEditingController,
                            validator: (v){
                              if(v.isEmpty){
                                return "Review title is required !!!";
                              }
                              return null;
                            },
                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            onFieldSubmitted: (V){
                              FocusScope.of(context).requestFocus(reviewFocus);
                            },
                            decoration: InputDecoration(
                              labelText: "What is the subject of your review ?",
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
                            controller: reviewEditingController,
                            validator: (v){
                              if(v.isEmpty){
                                return "Your review is required !!!";
                              }
                              return null;
                            },
                            focusNode: reviewFocus,
                            textCapitalization: TextCapitalization.sentences,
                            keyboardType: TextInputType.multiline,
                            maxLines: 10,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                  borderSide: BorderSide(color: Color.fromRGBO(143, 148, 251, 1))
                              ),
                              labelText: "Please tell us more about your review .",
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

                        Divider(height: 15,),

                        RaisedButton(
                          onPressed: (){
                            if (_formkey.currentState.validate()) {
                              pr.show();
                              _postLoan(titleEditingController.text, reviewEditingController.text);
                            }
                          },
                          color: Color.fromRGBO(148, 143, 251, 1),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 25.0,right: 25.0),
                            child: Text(" Submit Request  ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'ptserif'
                              ),),
                          ),

                        )

                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        )
      ),
    );
  }

  void _postLoan(String title, String review) async{
     Map<String, String> data = {
       "title": title,
       "review": review,
     };
     try{
       final response = await http.Client().post(BASE_URL+'api/sendreview',body:data,headers: HeadersPost);
       final jsonData = jsonDecode(response.body);
       if (response.statusCode == 200) {
         if (jsonData['status'] == 'true') {
            Future.delayed(Duration(seconds: 2)).then((value) {
              pr.hide().whenComplete((){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeMain()));
                SweetAlert.show(context,
                style: SweetAlertStyle.success,
                title: 'Success',
                subtitle: jsonData['success']);
              });
            });


         }

         if (jsonData['status'] == 'false') {
           Future.delayed(Duration(seconds: 2)).then((value) {
             pr.hide().whenComplete((){
               SweetAlert.show(context,
                   style: SweetAlertStyle.error,
                   title: 'Oops',
                   subtitle: jsonData['error']);
             });
           });
         }



       }  else{
           Future.delayed(Duration(seconds: 2)).then((value) {
             pr.hide().whenComplete((){
               SweetAlert.show(context,
                   style: SweetAlertStyle.error,
                   title: 'Oops',
                   subtitle: "Please try again later",);
             });
           });

       }
     }catch(e){
       Future.delayed(Duration(seconds: 2)).then((value) {
         pr.hide().whenComplete((){
           SweetAlert.show(context,
             style: SweetAlertStyle.error,
             title: 'Oops',
             subtitle: "Please try again later",);
         });
       });
     }
  }
}
