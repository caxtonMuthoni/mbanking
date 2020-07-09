import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mbanking/Invest/Model/investment.dart';
import 'package:mbanking/utils/constants.dart';

class NewInvestment extends StatefulWidget {
  @override
  _NewInvestmentState createState() => _NewInvestmentState();
}

class _NewInvestmentState extends State<NewInvestment> {
  TextEditingController amountEditingController = TextEditingController();
  TextEditingController durationEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                decoration: BoxDecoration(
                    color: mainColor
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.plusSquare,color: white,size: 60.0,),
                    SizedBox(height: 8.0,),
                    Text("Create new investment.",
                      style: TextStyle(
                        color: white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),)
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight:Radius.circular(30.0),topLeft: Radius.circular(30.0)),
                    color: white
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        TextFormField(
                          controller: amountEditingController,
                          validator: (value){
                            if(value.isEmpty){
                              return "The  amount field is required";
                            }
                            else if(double.parse(value) > 70000) {
                              return "The loan limit is ksh 70,000";
                            }
                            else{
                              return null;
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(143, 143, 251, 1)
                                )
                            ),
                            labelText: "What amount do you wish to invest ?",
                            hintText: "eg. 5000",
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

                        SizedBox(height: 20.0,),

                        TextFormField(
                          controller: durationEditingController,
                          validator: (value){
                            if(value.isEmpty){
                              return "The  duration field is required";
                            }
                            else{
                              return null;
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(143, 143, 251, 1)
                                )
                            ),
                            labelText: "How many months do you wish to invest ?",
                            hintText: "eg. 10",
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

                        SizedBox(height: 50.0,),

                        GestureDetector(
                          onTap: (){
                            if(_formKey.currentState.validate()){
                              createInvestMent(amountEditingController.text,durationEditingController.text);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(12.0)),
                              gradient: LinearGradient(colors: [mainColor,baseColor])
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 18),
                              child: Text("create new investment",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0
                                ),
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
    );
  }

  void createInvestMent(String amount, String duration) {
    var invest =  Investment(context: context,amount: amount,duration: duration);
    invest.createInvestment();
    clearFields();
  }

  void clearFields() {
    amountEditingController.text = "";
    durationEditingController.text = "";
  }


}
