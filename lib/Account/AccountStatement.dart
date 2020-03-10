import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mbanking/Account/statement.dart';
import 'package:mbanking/Models/MyTransaction.dart';

class AccountStatement extends StatefulWidget {

  String name;
  int accountNumber;

  AccountStatement({this.name, this.accountNumber});

  @override
  _AccountStatementState createState() => _AccountStatementState();
}

List<MyTransaction>  myTransactions = [];

class _AccountStatementState extends State<AccountStatement> {
  @override
  void initState() {
    MyTransaction().fetchAccountTransactions(widget.accountNumber).then((data){
      setState(() {
        myTransactions = data;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.name + " statement",
          style: TextStyle(
            color: Colors.white
          ),),
          backgroundColor: Color.fromRGBO(148, 143, 251, 1),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              columns: [
                DataColumn(
                    label: Text("Transaction ID" ,
                    style: TextStyle(
                      fontFamily: 'BowlbyOneSC',
                      fontSize: 13,
                      fontWeight: FontWeight.bold
                    ),),
                    numeric: false,
                    tooltip: ""
                ),
                DataColumn(
                    label: Text("Description",style: TextStyle(
                        fontFamily: 'BowlbyOneSC',
                        fontSize: 13,
                        fontWeight: FontWeight.bold
                    ),),
                    numeric: false,
                    tooltip: ""
                ),
                DataColumn(
                    label: Text("Account No.",style: TextStyle(
                        fontFamily: 'BowlbyOneSC',
                        fontSize: 13,
                        fontWeight: FontWeight.bold
                    ),),
                    numeric: false,
                    tooltip: ""
                ),
                DataColumn(
                    label: Text("Phone",style: TextStyle(
                        fontFamily: 'BowlbyOneSC',
                        fontSize: 13,
                        fontWeight: FontWeight.bold
                    ),),
                    numeric: false,
                    tooltip: ""
                ),
                DataColumn(
                    label: Text("Name",style: TextStyle(
                        fontFamily: 'BowlbyOneSC',
                        fontSize: 13,
                        fontWeight: FontWeight.bold
                    ),),
                    numeric: false,
                    tooltip: ""
                ),
                DataColumn(
                    label: Text("Amount",style: TextStyle(
                        fontFamily: 'BowlbyOneSC',
                        fontSize: 13,
                        fontWeight: FontWeight.bold
                    ),),
                    numeric: false,
                    tooltip: ""
                ),
                DataColumn(
                    label: Text("Original Bal",style: TextStyle(
                        fontFamily: 'BowlbyOneSC',
                        fontSize: 13,
                        fontWeight: FontWeight.bold
                    ),),
                    numeric: false,
                    tooltip: ""
                ),
                DataColumn(
                    label: Text("Current Bal.",style: TextStyle(
                        fontFamily: 'BowlbyOneSC',
                        fontSize: 13,
                        fontWeight: FontWeight.bold
                    ),),
                    numeric: false,
                    tooltip: "Current Bal."
                ),
                DataColumn(
                    label: Text("Date",style: TextStyle(
                        fontFamily: 'BowlbyOneSC',
                        fontSize: 13,
                        fontWeight: FontWeight.bold
                    ),),
                    numeric: false,
                    tooltip: "Date"
                ),
              ],

              rows: myTransactions.map(
                    (myTransactions) => DataRow(
                    cells: [
                      DataCell(
                        Text(myTransactions.TransID.toString()),
                      ),

                      DataCell(
                        Text(myTransactions.TransactionType),
                      ),

                      DataCell(
                        Text(myTransactions.AccountNumber.toString()),
                      ),
                      DataCell(
                        Text(myTransactions.MSISDN),
                      ),
                      DataCell(
                        Text(myTransactions.FirstName+ " " + myTransactions.LastName),
                      ),
                      DataCell(
                        Text(myTransactions.TransAmount.toString()),
                      ),
                      DataCell(
                        Text(myTransactions.OrgAccountBalance.toString()),
                      ),
                      DataCell(
                        Text(myTransactions.CrtAccountBalance.toString()),
                      ),
                      DataCell(
                        Text(myTransactions.created_at),
                      ),
                    ]),
              )
                  .toList(),

            ),
          ),
        )

        ,
      ),
    );
  }
}
