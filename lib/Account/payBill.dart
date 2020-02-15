import 'package:flutter/material.dart';

class PayBill extends StatefulWidget {
  @override
  _PayBillState createState() => _PayBillState();
}

 final _payBillFormKey = GlobalKey<FormState> ();

 TextEditingController businessNumberTextEditingController = new TextEditingController();
 TextEditingController accountTextEditingController = new TextEditingController();
 TextEditingController amountTextEditingController = new TextEditingController();


class _PayBillState extends State<PayBill> {
  @override
  Widget build(BuildContext context) {
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
            SizedBox(height: 15,),
            CircleAvatar(
              radius: 45.0,
              child: Image(
                width: 60.0,
                height: 60.0,
                image: AssetImage('assets/images/mpesa.png'),
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
                    key: _payBillFormKey,
                    child: ListView(
                      children: <Widget>[
                        TextFormField(
                          controller: businessNumberTextEditingController,
                          validator: (firstName){
                            if(firstName.isEmpty){
                              return "Business Number is required";
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
                            labelText: "Enter Business Number",
                            hintText: "Business Number",
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
                          controller: accountTextEditingController,
                          validator: (middleName){
                            if(middleName.isEmpty){
                              return "Account Number is required";
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
                            labelText: "Enter Account Number",
                            hintText: "Account Number is required",
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
                          controller: amountTextEditingController,
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
                            hintText: "Amount eg.1000",
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
                        GestureDetector(
                            onTap: (){
                              if(_payBillFormKey.currentState.validate()){


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
