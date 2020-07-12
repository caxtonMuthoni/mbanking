import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbanking/Models/account.dart';
import 'package:mbanking/Models/user.dart';
import 'package:mbanking/OtherAccounts/withdraw_deposit.dart';
import 'package:mbanking/utils/constants.dart';
import 'package:mbanking/utils/string_formatter.dart';

class AccountSelect extends StatefulWidget {
  String action;

  AccountSelect(this.action);

  @override
  _AccountSelectState createState() => _AccountSelectState();
}

class _AccountSelectState extends State<AccountSelect> {
  var account = Account();
  int selectedRadioTile;
  var stringFormatter = StringFormatter();

  int currentUserId;
  bool _btnIsDisabled = true;

  @override
  void initState() {
    selectedRadioTile = 0;
    setCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          title: Text(
            "Account Selection",
            style: TextStyle(
              color: white,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: ListView(
            children: <Widget>[
              Text(
                "Please select the account you wish to ${widget.action}.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: info,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'ptseif'),
              ),
              FutureBuilder(
                future: account.fetchUserAccounts(context),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                  }
                  if (snapshot.hasData) {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return  accountTile(snapshot.data, index);
                        });
                  } else {
                    return Column(
                      children: <Widget>[
                        Center(child: CircularProgressIndicator()),
                      ],
                    );
                  }
                },
              ),
              SizedBox(
                height: 30.0,
              ),
              RaisedButton(
                color: primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50.0, vertical: 10.0),
                  child: Text(_btnIsDisabled ? "Select Account First" : "Continue",
                      style:
                          TextStyle(color: white, fontWeight: FontWeight.bold)),
                ),
                onPressed: _btnIsDisabled ? null : () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WithDrawNDeposit(
                                widget.action, selectedRadioTile)));


                },
              )
            ],
          ),
        ),
      ),
    );
  }

  setSelectedRadioTile(value) {
    setState(() {
      selectedRadioTile = value;
      _btnIsDisabled = false;
    });
  }

  Widget accountTile(data, int index) {

    if (data[index].AccountCode != "200") {
      if (widget.action == 'withdraw' &&
          int.parse(data[index].CustomerID) != currentUserId) {
        return SizedBox.shrink();
      }

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RadioListTile(
            title: Text(data[index].AccountName),
            subtitle: Text(data[index].AccountNumber.toString()),
            activeColor: Colors.green,
            selected: false,
            groupValue: selectedRadioTile,
            value: data[index].id,
            onChanged: (val) {
              setSelectedRadioTile(val);
              print(selectedRadioTile.toString());
            },
            secondary: OutlineButton(
                child: Text(stringFormatter
                    .formatString(data[index].CurrentBalance.toString()))),
          ),
          Divider(
            height: 10,
            color: Colors.grey[400],
          ),
        ],
      );
    } else {
      return SizedBox.shrink();
    }
  }

  void setCurrentUser() async{
    var user = User();
    var currentUser = await user.fetchUser(context: context);
    setState(() {
      currentUserId = currentUser.id;
    });
  }
}
