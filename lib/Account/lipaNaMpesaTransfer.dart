import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:mbanking/Account/accountHome.dart';
import 'package:mbanking/General/Constants.dart';
import 'package:mbanking/Models/Account.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sweetalert/sweetalert.dart';

class LipaNaMpesaTransfer extends StatefulWidget {
  @override
  String type;
  LipaNaMpesaTransfer(this.type);
  _LipaNaMpesaTransferState createState() => _LipaNaMpesaTransferState();
}

GlobalKey<FormState> _lipaNaMpesaTransferFromKey = GlobalKey<FormState>();
TextEditingController amountEditingController = new TextEditingController();
TextEditingController accountEditingController = new TextEditingController();
String path;
String account;
String dropdownValue = 'Select an account';




class _LipaNaMpesaTransferState extends State<LipaNaMpesaTransfer> {

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



    ProgressDialog pr = new ProgressDialog(context,type: ProgressDialogType.Normal);
    pr.style(
        message: 'Processing Transaction ...',
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


    alertstate ? pr.show() : pr.hide();



    transferCash(String amount, String accountNumber,int id) async{

      Map<String, String> data ={
        "amount": amount,
        "accountId": id.toString(),
        "accountNumber": accountNumber.toString(),
      };
      try{
        final response = await http.Client().post(BASE_URL+"api/tranfercash",headers: HeadersPost,body: data);
        print(response.body);

        if(response.statusCode == 200){
          pr.hide();
          final jsonData = jsonDecode(response.body);
          if(jsonData["status"] == "true"){

              SweetAlert.show(context,
                  style: SweetAlertStyle.success,
                  title: "Trunfer Processed",
                  subtitle:jsonData["success"],

              );
              Future.delayed(const Duration(milliseconds: 1000), () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountHome()));

              });


            //

          }
          else{
           // pr.hide();
            SweetAlert.show(context,
                style: SweetAlertStyle.error,
                title: "Trunfer Failed",
                subtitle:jsonData["error"] );


          }
        }else{
         // pr.hide();
          SweetAlert.show(context,
              style: SweetAlertStyle.error,
              title: "Trunfer Failed",
              subtitle:"An error occurred. Please try again later.");
        }

      }catch(e){
        setState(() {
          alertstate = false;
        });
        print(e);
        pr.hide();
      }

    }


    return SafeArea(
      child: Scaffold(
        backgroundColor:Color.fromRGBO(143, 148, 251, 1),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromRGBO(143, 148, 251, 1),
          elevation: 0.00,
          title: Text(widget.type,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),),
        ),
        body: Column(
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
            Text("Enter the Mpesa Pay Bill details.",
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
                          validator: (middleName){
                            if(middleName.isEmpty){
                              return "Amount is required";
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

                        SizedBox(height: 10,),
                        Text(" Select the Account you wish to transfer funds from",
                          style: TextStyle(
                              color: Color.fromRGBO(143, 148, 251, 1),
                              fontFamily: 'ptserif',
                              fontWeight: FontWeight.bold
                          ),),
                        Divider(height: 10, color: Colors.grey[400],),

                        FutureBuilder(
                            future: Account().fetchUserAccounts(context),
                            builder: (context,snapshot){
                              if(snapshot.hasError){
                                print(snapshot.error);
                              }
                              if(snapshot.hasData){
                                return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data.length,
                                    itemBuilder: (context,index){
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,

                                      children: <Widget>[

                                        RadioListTile(
                                          title: Text(snapshot.data[index].AccountName),
                                          subtitle: Text(snapshot.data[index].AccountNumber.toString()),
                                          activeColor: Colors.green,
                                          selected: false,
                                          groupValue: selectedRadioTile,
                                          value: snapshot.data[index].id,
                                          onChanged: (val){
                                            setSelectedRadioTile(val);
                                          },
                                          secondary: OutlineButton(child: Text("Bal: "+snapshot.data[index].CurrentBalance)),
                                        ),
                                        Divider(height: 10, color: Colors.grey[400],),

                                      ],
                                    );
                                    });
                              }
                              else{
                                return CircularProgressIndicator();
                              }
                          },
                          ),


                        SizedBox(height: 25,),
                        GestureDetector(
                          onTap: (){
                            print( amountEditingController.text);
                            if(_lipaNaMpesaTransferFromKey.currentState.validate()){
                             // pr.show();
                              transferCash(amountEditingController.text, accountEditingController.text, selectedRadioTile);

                            }

                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 45,
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
                                  Icon(Icons.arrow_forward,
                                    color: Color.fromRGBO(143, 148, 251, 1),
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
    );
  }


}
