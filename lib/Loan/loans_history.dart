import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mbanking/Loan/Loan_detail.dart';
import 'package:mbanking/Loan/model/user_loans.dart';
import 'package:mbanking/utils/constants.dart';
import 'package:mbanking/utils/string_formatter.dart';

class LoanHistory extends StatefulWidget {
  @override
  _LoanHistoryState createState() => _LoanHistoryState();
}

class _LoanHistoryState extends State<LoanHistory> {

  var formatString;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formatString = StringFormatter();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(143, 148, 251, 1),
          title: Text("My Loans",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'ptserif',
          ),),
          elevation: 0.00,
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: UserLoans().getUserLoans(),
          builder: (context, snapshot){
            if(snapshot.hasError){
              print(snapshot.error);
            }

            if (snapshot.hasData) {
               return ListView.builder(
                   itemCount: snapshot.data.length,
                   itemBuilder: (context, index){
                     return Column(
                       children: <Widget>[
                         ListTile(
                           leading: leading(snapshot.data[index].loanType),
                           isThreeLine: true,
                           title:Text("Loan Id :" + snapshot.data[index].loanId,
                           style: TextStyle(
                             color: primary,
                             fontFamily: 'ptserif',
                             fontWeight: FontWeight.bold
                           ),),
                            subtitle: Text("${snapshot.data[index].loanType} \n Amount borrowed is KSH ${formatString.formatString(snapshot.data[index].borrowedAmount)}"),
                           trailing: trailing(snapshot.data[index].status),
                           onTap: (){
                             Navigator.push(context,MaterialPageRoute(builder: (context)=>LoanDetail(snapshot.data[index])));
                           },

                         ),
                         Divider(height: 10,color: Colors.grey[500],)
                       ],
                     );
                   });
            }
            else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  trailing(String status) {
    status = status.toLowerCase().trim();
    Color color;
    switch(status){
      case "defaulted" :
        color = danger;
        break;

      case "complete" :
        color = primary;
        break;

      case "defaulting" :
        color = warning;
        break;

      case "active" :
        color = success;
        break;
      default:
        color = secondary;
    }

    return Container(
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(12.0))
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(status,
            style: TextStyle(
                color: white
            ),),
        ));

  }

  CircleAvatar leading(String loanType) {
    loanType = loanType.trim();
    String letter =  loanType[0].toUpperCase();
    Color color;
    switch (letter) {
      case "D" :
        color = info;
        break;
      case "B" :
        color = primary;
        break;
      case "S" :
        color = success;
        break;
      default:
        color = danger;

    }
    return CircleAvatar(
      radius: 25,
      backgroundColor: color,
      child: Text("$letter",
        style:TextStyle(
          fontWeight: FontWeight.bold,
          color: white,
          fontFamily: 'BowlbyOneSC',
          fontSize: 20,
        ) ,),
    );

  }
}
