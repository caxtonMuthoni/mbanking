import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mbanking/Models/FundedLoan.dart';
import 'package:mbanking/Models/User.dart';
import 'package:http/http.dart' as http;

class Lends extends StatefulWidget {
  @override
  _LendsState createState() => _LendsState();
}

List<FundedLoan> fundedLoans;

class _LendsState extends State<Lends> {

  @override
  void initState() {
   FundedLoan().fetchFundedLoans().then((data){
      setState(() {
        fundedLoans = data;
      });
   });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Lends",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'ptserif',
          ),),
          backgroundColor: Color.fromRGBO(143, 148, 251, 1),
          centerTitle: true,
          elevation: 0.00,
        ),
        body:  SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
               columns: [
                 DataColumn(
                   label:Text("#")
                 ),
                 DataColumn(
                     label:Text("Borrower")
                 ),
                 DataColumn(
                     label:Text("Amount")
                 ),
                 DataColumn(
                     label:Text("Date")
                 ),
               ],
              rows: fundedLoans.map(
                  (fundedLoans)=>DataRow(
                    cells: [
                      DataCell(
                        Text(fundedLoans.id.toString())
                      ),
                      DataCell(
                        Center(
                            child: FutureBuilder(
                              future: User.fetchUser(client: http.Client(),context: context,id: fundedLoans.borrowerId),
                              builder: (context, snapshotUser){
                                if(snapshotUser.hasData) {
                                  return Text(
                                      snapshotUser.data.FirstName + ' ' +
                                          snapshotUser.data.MiddleName +
                                          ' ' +
                                          snapshotUser.data.LastName);
                                }else{
                                  return Text( "Loading data ...");
                                }

                              },

                            ) ),
                      ),
                      DataCell(
                        Text(fundedLoans.amountLend.toString())
                      ),
                      DataCell(
                        Text(fundedLoans.created_at)
                      )
                    ]
                  )
              ).toList(),
            ),
          ),
        )
     /*
        Column(
          children: <Widget>[
        Container(
          height: 20,
          child: Table(

          border: TableBorder.all(
              color: Colors.black26, width: 1,
              style: BorderStyle.solid),
          children: [
            TableRow(children: [
              TableCell(child: Center(child: Text('#',style: TextStyle(fontWeight: FontWeight.bold),))),
              TableCell(
                child: Center(child: Text('Borrower',style: TextStyle(fontWeight: FontWeight.bold),)),
              ),
              TableCell(child: Center(child: Text('Amount',style: TextStyle(fontWeight: FontWeight.bold),))),
              TableCell(child: Center(child: Text('Date',style: TextStyle(fontWeight: FontWeight.bold),))),
            ]),
              ]),
        ),
            Expanded(
              child: FutureBuilder(
                future: FundedLoan().fetchFundedLoans(),
                builder: (context , snapshot){
                   if(snapshot.hasData){
                     return ListView.builder(
                         itemCount: snapshot.data.length,
                         itemBuilder: (context,index){
                           return Table(
                             border: TableBorder.all(
                                 color: Colors.grey[300], width: 0.5,
                                 style: BorderStyle.solid),
                             children: [
                               TableRow(children: [
                                 TableCell(child: Center(child: Text(snapshot.data[index].id.toString(),))),
                                 TableCell(
                                   child: Center(
                                       child: FutureBuilder(
                                         future: User.fetchUser(client: http.Client(),context: context,id: snapshot.data[index].borrowerId),
                                         builder: (context, snapshotUser){
                                           if(snapshotUser.hasData) {
                                             return Text(
                                                 snapshotUser.data.FirstName + ' ' +
                                                     snapshotUser.data.MiddleName +
                                                     ' ' +
                                                     snapshotUser.data.LastName);
                                           }else{
                                             return Text( "Loading data ...");
                                           }

                                         },

                                       ) ),
                                 ),
                                 TableCell(child: Center(child: Text(snapshot.data[index].amountLend.toString(),))),
                                 TableCell(child: Center(child: Text(snapshot.data[index].created_at.toString(),))),
                               ]),
                             ],
                           );



                         });
                   }
                   else{
                     return Center(child: Text("Loading Data ..."),);
                   }
                },
              ),
            ),
          ],
        ),*/
      ),
    );
  }
}
