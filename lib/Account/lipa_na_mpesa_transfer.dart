import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mbanking/Account/account_home.dart';
import 'package:mbanking/General/constants.dart';
import 'package:mbanking/Models/account.dart';
import 'package:http/http.dart' as http;
import 'package:mbanking/Models/transfer_funds.dart';
import 'package:mbanking/utils/constants.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sweetalert/sweetalert.dart';

class LipaNaMpesaTransfer extends StatefulWidget {
  @override
  String type;
  LipaNaMpesaTransfer(this.type);
  _LipaNaMpesaTransferState createState() => _LipaNaMpesaTransferState();
}


class _LipaNaMpesaTransferState extends State<LipaNaMpesaTransfer> {

  final _lipaNaMpesaTransferFromKey = GlobalKey<FormState>();
  TextEditingController amountEditingController = new TextEditingController();
  TextEditingController accountEditingController = new TextEditingController();
  String path;
  String account;

  int selectedRadioTile;
  bool alertstate;
  @override
  void initState() {
    selectedRadioTile = 0;
    alertstate = false;
  }

  setSelectedRadioTile(value){
    setState(() {
      selectedRadioTile = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch(widget.type) {
      case "Lipa Na Mpesa" :
        path = "assets/images/mpesa.png";
        account= "Till Number";
        break;
      default:
        path = "assets/images/transfer.png";
        account= 'Account Number';
    }


    return SafeArea(
      child: Scaffold(
        backgroundColor:mainColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: mainColor,
          elevation: 0.00,
          title: Text(widget.type,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),),
        ),
        body: GestureDetector(
          onTap: ()=>FocusScope.of(context).unfocus(),
          child: Column(
            children: <Widget>[
              SizedBox(height: 15,),
              CircleAvatar(
                radius: 45.0,
                child: Image(
                  width: 60.0,
                  height: 60.0,
                  image: AssetImage(path),
                ) ,
                backgroundColor: Colors.white60,
              ),
              Text("Send money to friends ",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontFamily: 'YeonSung'
                ),),
              SizedBox(height: 40.0,),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0)
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
                    child:Form(
                      key: _lipaNaMpesaTransferFromKey,
                      child: ListView(
                        children: <Widget>[
                          TextFormField(
                            controller: accountEditingController,
                            validator: (firstName){
                              if(firstName.isEmpty){
                                return account+" is required";
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
                              labelText: "Enter "+account,
                              hintText: account,
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
                            controller: amountEditingController,
                            validator: (amount){
                              if(amount.isEmpty){
                                return "Amount is required";
                              }else if(int.parse(amount ) < 100){
                                return "The minimum tranfer amount is KSH 100.";
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
                              labelText: "Enter Amount",
                              hintText: "Amount eg. 1000",
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

                          SizedBox(height: 60.0,),
                          GestureDetector(
                            onTap: (){
                              FocusScope.of(context).unfocus();
                              if(_lipaNaMpesaTransferFromKey.currentState.validate()){
                                var transferFund = TransferFund(
                                  context: context,
                                  amount: amountEditingController.text,
                                  accountNumber: accountEditingController.text
                                );
                                transferFund.transferCash();

                              }

                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 45,
                                decoration: BoxDecoration(
                                    border: Border.all(color: info),
                                    borderRadius: BorderRadius.all(Radius.circular(50.0))
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text('Complete Transaction',
                                      style: TextStyle(
                                        color: info,
                                        fontFamily: 'YeonSung',
                                        fontSize: 16,
                                      ),),
                                    SizedBox(width: 20.0,),
                                    Icon(Icons.flight_takeoff,
                                      color: info,
                                      size: 30,
                                    )

                                  ],
                                ),
                              ),
                            ),
                          )


                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],

          ),
        ),
      ),
    );
  }


}
