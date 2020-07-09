import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mbanking/Invest/Model/investment.dart';
import 'package:mbanking/utils/constants.dart';

class TerminateRequest extends StatefulWidget {
  int investmentId;

  TerminateRequest(this.investmentId);

  @override
  _TerminateRequestState createState() => _TerminateRequestState();
}

class _TerminateRequestState extends State<TerminateRequest> {
  TextEditingController reasonEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: mainColor,
          title: Text("Invest With Mbanking"),
        ),
        backgroundColor: mainColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(color: mainColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.plusSquare,
                      color: danger,
                      size: 60.0,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      "Terminate an investment.",
                      style: TextStyle(
                        color: white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        topLeft: Radius.circular(30.0)),
                    color: white),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          maxLines: 7,
                          textAlign: TextAlign.start,
                          toolbarOptions: ToolbarOptions(cut: true,paste: true,selectAll: true),
                          textCapitalization: TextCapitalization.sentences,
                          controller: reasonEditingController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "The  reason field is required";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(143, 143, 251, 1))),
                            labelText:
                                "Why do you wish to terminate  your investment. ?",
                            hintText: " ",
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                            ),
                            fillColor: Colors.green,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState.validate()) {
                              terminateInvestMent(
                                  reasonEditingController.text);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                gradient: LinearGradient(
                                    colors: [mainColor, baseColor])),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 18),
                              child: Text(
                                "Send Request",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  void terminateInvestMent(String reason) {
    var terminate = Investment(context: context);
    terminate.terminateInvestment(widget.investmentId, reason);
    clearFields();
  }

  void clearFields() {
    reasonEditingController.text = "";
  }
}
