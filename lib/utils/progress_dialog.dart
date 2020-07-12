
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbanking/utils/constants.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ProgressDialogue{
  BuildContext context;

  String title;


  ProgressDialogue({this.context, this.title});

  progress(){
    ProgressDialog pr = new ProgressDialog(context,type: ProgressDialogType.Normal);
    pr.style(
        message: title,
        borderRadius: 10.0,
        backgroundColor: white,
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
    return pr;
  }
}