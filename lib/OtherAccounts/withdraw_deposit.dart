import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:mbanking/OtherAccounts/Model/withdraw_deposit.dart';
import 'package:mbanking/utils/constants.dart';
import 'package:sweetalert/sweetalert.dart';

class WithDrawNDeposit extends StatefulWidget {
  String action;
  int accountId;

  WithDrawNDeposit(this.action, this.accountId);

  @override
  _WithDrawNDepositState createState() => _WithDrawNDepositState();
}

class _WithDrawNDepositState extends State<WithDrawNDeposit> {

  TextEditingController amountEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mainColor,
        appBar: AppBar(
          backgroundColor: mainColor,
          elevation: 0,
          title: Text(widget.action,
            style: TextStyle(
              color: white,
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        body: GestureDetector(
          onTap: () =>FocusScope.of(context).unfocus(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.orange,
                        radius: 35.0,
                        child: Icon(
                          widget.action == 'deposit' ? Icons.arrow_downward : Icons.arrow_upward,
                          color: white,
                          size: 30.0,
                        ),
                      ),
                      SizedBox(height: 8.0,),
                      Text('Account ${widget.action}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0
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
                    color: white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(12.0),topLeft: Radius.circular(12.0))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 30.0),
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: <Widget>[
                          TextFormField(
                            controller: amountEditingController,
                            keyboardType: TextInputType.numberWithOptions(),
                            validator: (value){
                              if(value.isEmpty){
                                 return "Amount field is required";
                              }else if(int.parse(value) > 70000){
                                return "Amount must be more than 70,000";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "eg. 50000",
                              labelText: "What amount do you which to ${widget.action}",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(
                                  color: mainColor
                                )
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(
                                  color: success
                                )
                              )
                            ),
                          ),

                          SizedBox(height: 30.0,),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 20),
                            child: RaisedButton(
                              color: info,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                child: Text("Complete Transaction",
                                  style: TextStyle(
                                    color: white,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),

                              onPressed: (){
                                if(_formKey.currentState.validate()){
                                  SweetAlert.show(context,
                                      style: SweetAlertStyle.confirm,
                                      title: "Are you sure",
                                      subtitle: " To  ${widget.action} KSH : ${amountEditingController.text}",
                                      showCancelButton: true,
                                      cancelButtonColor: Colors.green,
                                      // confirmButtonColor: Colors.green,
                                      cancelButtonText: "Cancel",
                                      confirmButtonText: "Yes, ${widget.action} !",
                                      onPress: (bool value){
                                        if(value){
                                          commitTransaction(widget.action,widget.accountId,amountEditingController.text);
                                        }
                                        return true;
                                      });
                                }
                              },
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
      ),
    );
  }

  void commitTransaction(String action, int accountId, String amount) {
      var transact = WithdrawDeposit(
        action: action,
        accountId: accountId,
        amount: amount,
        context: context
      );

      transact.withdrawDeposit();
  }
}
