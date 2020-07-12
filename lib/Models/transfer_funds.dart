import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbanking/Account/account_home.dart';
import 'package:mbanking/General/constants.dart';
import 'package:http/http.dart' as http;
import 'package:mbanking/utils/progress_dialog.dart';
import 'package:sweetalert/sweetalert.dart';

class TransferFund {

  String amount;
  String accountNumber;
  BuildContext context;


  TransferFund({this.amount, this.accountNumber, this.context});

  transferCash() async{

    ProgressDialogue progressDialogue = ProgressDialogue(
      context: context,
      title: 'Transfering funds ...'
    );

    var pr = progressDialogue.progress();

    pr.show();

    Map<String, String> data ={
      "amount": amount,
      "accountNumber": accountNumber,
    };
    try{
      final response = await http.Client().post(BASE_URL+"api/tranfercash",headers: HeadersPost,body: data);
      print(response.body);

      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body);
        if(jsonData["status"]){

          Future.delayed(Duration(seconds: 3)).then((value){
            pr.hide().whenComplete((){
              SweetAlert.show(context,
                style: SweetAlertStyle.success,
                title: "Trunfer Processed",
                subtitle:jsonData["message"],

              );
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AccountHome()));

              });

            });
          });

        }
        else{
         Future.delayed(Duration(seconds: 3)).then((value) {
          pr.hide().whenComplete((){
            SweetAlert.show(context,
                style: SweetAlertStyle.error,
                title: "Trunsfer Failed",
                subtitle:jsonData["message"] );
          });
         });
        }
      }else {
        Future.delayed(Duration(seconds: 3)).then((value) {
          pr.hide().whenComplete((){
            SweetAlert.show(context,
                style: SweetAlertStyle.error,
                title: "Trunsfer Failed",
                subtitle: "An error occured .Please try again later");
          });
        });
      }

    }catch(e){
      print(e);
    }

  }
}