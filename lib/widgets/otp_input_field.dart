import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mbanking/utils/constants.dart';

class InputField extends StatefulWidget {
  String num;

  InputField(this.num);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    String num = widget.num;
    return SizedBox(
      width: 50.0,
      height: 53.0,
      child: Container(
        padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white
        ),
        child:  Text("$num",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: paleBlack,
        ),)
      ),
    );
  }
}
