import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mbanking/Animation/FadeAnimation.dart';
import 'package:mbanking/Shares/Models/standing_order.dart';
import 'package:mbanking/utils/constants.dart';

class StandingOrder extends StatefulWidget {
  String accountId;
  String destinationId;
  StandingOrderModel standingOrder;

  StandingOrder({this.accountId,this.destinationId,this.standingOrder});

  @override
  _StandingOrderState createState() => _StandingOrderState();
}

class _StandingOrderState extends State<StandingOrder> {
  TextEditingController amountEditingController = TextEditingController();
  TextEditingController durationEditingController = TextEditingController();
  bool isUpdating;
  final _formkey = GlobalKey<FormState>();
  var standingOrder;

  var btnText = "Create Standing Order";

  var subtitle = "start new standing order";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUi(widget.standingOrder);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          elevation: 0.0,
          title: Text("Standing Order",
            style: TextStyle(
              color: white,
            ),),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50.0)),
                  color: mainColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.businessTime,color: info, size: 60.0,),
                    SizedBox(height: 20.0,),
                    Text("$subtitle",
                      style: TextStyle(
                          fontSize: 21.0,
                          fontFamily: 'ptserif',
                          fontWeight: FontWeight.bold,
                          color: white
                      ),)
                  ],
                ),

              ),
            ),
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: Form(
                  key: _formkey,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(height: 60.0,),
                        TextFormField(
                          controller: amountEditingController,
                          validator: (value){
                            if(value.isEmpty){
                              return "The amount field is required";
                            }
                            else if(double.parse(value) > 70000) {
                              return "The amount must be less than 70,000";
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
                            labelText: "What is the standing order amount ?",
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
                        SizedBox(height: 25,),
                        TextFormField(
                          controller: durationEditingController,
                          validator: (value){
                            if(value.isEmpty){
                              return "The duration field is required";
                            }
                            else if(double.parse(value) > 12 || double.parse(value) < 1) {
                              return "The duration must be between 1 and 12 months";
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
                            labelText: "At what duration do you want the standing order to be executed ?",
                            hintText: "eg. 5",
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

                        SizedBox(height: 40.0,),

                        depositShareBtn()
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
  depositShareBtn() {
    return GestureDetector(
      onTap: () async{
        if(_formkey.currentState.validate()){
          submitShareDepositRequest(amountEditingController.text,durationEditingController.text);
        }

      },
      child: FadeAnimation(2, Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(143, 148, 251, 1),
                  Color.fromRGBO(143, 148, 251, .6),
                ]
            )

        ),
        child: Center(
          child: Text("$btnText", style: TextStyle(color: white, fontWeight: FontWeight.bold),),
        ),
      )),
    );
  }

  void submitShareDepositRequest(String amount,String duration) {
    print("Acc ID id ${widget.accountId} and destin Id is ${widget.destinationId}");
    standingOrder = StandingOrderModel(context:context,accountId:widget.accountId, destinationId:widget.destinationId,amount:amount,duration:duration);
    if(isUpdating){
      standingOrder.updateStandingOrder(widget.standingOrder.id) ;
    }else{
      standingOrder.createStandingOrder() ;
    }

    clearTextFields();
  }

  void clearTextFields() {
    amountEditingController.text = "";
    durationEditingController.text = "";

  }

  void updateUi(StandingOrderModel STO) {
    if(STO != null){
      setState(() {
         isUpdating = true;
         amountEditingController.text = STO.amount;
         durationEditingController.text = STO.duration;
         widget.destinationId = STO.destinationId;
         widget.accountId = STO.accountId;
         btnText ="Update Standing Order";
         subtitle = "updating standing order";
      });
    }
  }
}
