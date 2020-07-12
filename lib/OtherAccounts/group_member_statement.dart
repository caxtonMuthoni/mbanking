import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbanking/OtherAccounts/Model/group_member_statement.dart';
import 'package:mbanking/utils/constants.dart';
import 'package:mbanking/utils/date_formatter.dart';
import 'package:mbanking/utils/string_formatter.dart';

class GroupMemberStatement extends StatefulWidget {
  String username;
  String AccountNumber;
  String userId;


  GroupMemberStatement({this.username, this.AccountNumber, this.userId});

  @override
  _GroupMemberStatementState createState() => _GroupMemberStatementState();
}

class _GroupMemberStatementState extends State<GroupMemberStatement> {

  var statement = MemberStatement();
  var stringFormatter = StringFormatter();
  var dateFormatter = FormatDate();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          title: Text("${widget.username}",
            style: TextStyle(
              color: white,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        body:FutureBuilder(
          future: statement.fetchMemberStatement(widget.AccountNumber, widget.userId),
          builder: (context,snapshot){
            if(snapshot.hasData){
              if(snapshot.data.length == 0 || snapshot.data == null){
                return Center(child: Text('No Transactions Found'),);
              }else{
                return dataTable(snapshot.data);
              }
            }else{
              return Center(child: CircularProgressIndicator(),);
            }
          },
        )

      ),
    );
  }

  Widget dataTable(List<MemberStatement> myTransactions){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child:  DataTable(
          columns: [
            DataColumn(
                label: Text("#",style: TextStyle(
                    fontFamily: 'BowlbyOneSC',
                    fontSize: 13,
                    color: mainColor,
                    fontWeight: FontWeight.bold
                ),),
                numeric: false,
                tooltip: ""
            ),

            DataColumn(
                label: Text("Transaction ID",style: TextStyle(
                  fontFamily: 'BowlbyOneSC',
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: mainColor,
                ),),
                numeric: false,
                tooltip: ""
            ),
            DataColumn(
                label: Text("Description",style: TextStyle(
                    fontFamily: 'BowlbyOneSC',
                    fontSize: 13,
                    color: mainColor,
                    fontWeight: FontWeight.bold
                ),),
                numeric: false,
                tooltip: ""
            ),

            DataColumn(
                label: Text("Phone",style: TextStyle(
                    fontFamily: 'BowlbyOneSC',
                    fontSize: 13,
                    color: mainColor,
                    fontWeight: FontWeight.bold
                ),),
                numeric: false,
                tooltip: ""
            ),

            DataColumn(
                label: Text("Amount",style: TextStyle(
                    fontFamily: 'BowlbyOneSC',
                    fontSize: 13,
                    color: mainColor,
                    fontWeight: FontWeight.bold
                ),),
                numeric: false,
                tooltip: ""
            ),
            DataColumn(
                label: Text("Original Bal",style: TextStyle(
                    fontFamily: 'BowlbyOneSC',
                    fontSize: 13,
                    color: mainColor,
                    fontWeight: FontWeight.bold
                ),),
                numeric: false,
                tooltip: ""
            ),
            DataColumn(
                label: Text("Current Bal.",style: TextStyle(
                    fontFamily: 'BowlbyOneSC',
                    fontSize: 13,
                    color: mainColor,
                    fontWeight: FontWeight.bold
                ),),
                numeric: false,
                tooltip: "Current Bal."
            ),
            DataColumn(
                label: Text("Date",style: TextStyle(
                    fontFamily: 'BowlbyOneSC',
                    fontSize: 13,
                    color: mainColor,
                    fontWeight: FontWeight.bold
                ),),
                numeric: false,
                tooltip: "Date"
            ),
          ],

          rows: myTransactions.map(
                (myTransaction) => DataRow(
                cells: [
                  DataCell(
                    Text(myTransaction.id.toString()),
                  ),

                  DataCell(
                    Text(myTransaction.transactionID),
                  ),

                  DataCell(
                    Text(myTransaction.description),
                  ),
                  DataCell(
                    Text(myTransaction.phone),
                  ),

                  DataCell(
                    Text(stringFormatter.formatString(myTransaction.amount)),
                  ),
                  DataCell(
                    Text(stringFormatter.formatString(myTransaction.originalBal)),
                  ),
                  DataCell(
                    Text(stringFormatter.formatString(myTransaction.newBal)),
                  ),
                  DataCell(
                    Text(dateFormatter.formatDate(myTransaction.date)),
                  ),
                ]),
          )
              .toList(),

        ),
      ),
    );
  }
}
