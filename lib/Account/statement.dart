import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mbanking/Models/MyTransaction.dart';

class Statement extends StatefulWidget {
  @override
  _StatementState createState() => _StatementState();
}

 List<MyTransaction>  myTransactions =[];

class _StatementState extends State<Statement> {

  @override
  void initState() {
   MyTransaction().fetchTransactions().then((data){
     setState(() {
       myTransactions = data;
       print("data is " + data.length.toString());
     });
   });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(143, 148, 251, 1),
          title: Text("Statement",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'ptserif'
          ),),
          centerTitle: true,
          elevation: 0.00,
        ),
        body:SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              columns: [
                DataColumn(
                    label: Text("Transaction ID"),
                    numeric: false,
                    tooltip: ""
                ),
                DataColumn(
                    label: Text("Description"),
                    numeric: false,
                    tooltip: ""
                ),
                DataColumn(
                    label: Text("Account No."),
                    numeric: false,
                    tooltip: ""
                ),
                DataColumn(
                    label: Text("Phone"),
                    numeric: false,
                    tooltip: ""
                ),
                DataColumn(
                    label: Text("Name"),
                    numeric: false,
                    tooltip: ""
                ),
                DataColumn(
                    label: Text("Amount"),
                    numeric: false,
                    tooltip: ""
                ),
                DataColumn(
                    label: Text("Original Bal"),
                    numeric: false,
                    tooltip: ""
                ),
                DataColumn(
                    label: Text("Current Bal."),
                    numeric: false,
                    tooltip: "Current Bal."
                ),
                DataColumn(
                    label: Text("Date"),
                    numeric: false,
                    tooltip: "Date"
                ),
              ],

              rows: myTransactions.map(
                      (myTransactions) => DataRow(
                      cells: [
                        DataCell(
                          Text(myTransactions.TransID),
                        ),

                        DataCell(
                          Text(myTransactions.TransactionType),
                        ),

                        DataCell(
                          Text(myTransactions.AccountNumber),
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






        /* Column(
          children: <Widget>[
            Container(
              height: 20,
              child: Table(

                  border: TableBorder.all(
                      color: Colors.black26, width: 1,
                      style: BorderStyle.solid),
                  children: [
                    TableRow(children: [
                      TableCell(child: Center(child: Text(' Transaction ID',style: TextStyle(fontWeight: FontWeight.bold),))),
                      TableCell(
                        child: Center(child: Text('Account No.',style: TextStyle(fontWeight: FontWeight.bold),)),
                      ),
                      TableCell(child: Center(child: Text('Phone',style: TextStyle(fontWeight: FontWeight.bold),))),
                      TableCell(child: Center(child: Text('Name',style: TextStyle(fontWeight: FontWeight.bold),))),
                      TableCell(child: Center(child: Text('Amount',style: TextStyle(fontWeight: FontWeight.bold),))),
                      TableCell(child: Center(child: Text('Original Bal.',style: TextStyle(fontWeight: FontWeight.bold),))),
                      TableCell(child: Center(child: Text('Current Bal',style: TextStyle(fontWeight: FontWeight.bold),))),
                      TableCell(child: Center(child: Text('Date',style: TextStyle(fontWeight: FontWeight.bold),))),
                    ]),
                  ]),
            ),
            Expanded(
              child: FutureBuilder(
                future: MyTransaction().fetchTransactions(),
                builder: (context,snapshot){
                  if (snapshot.hasError) {
                    print(snapshot.error);
                  }
                  if(snapshot.hasData){
                    return  ListView.builder(
                      itemCount: snapshot.data.length,
                        itemBuilder: (context,index){
                         return DataTable(
                           columns: [
                             DataColumn(
                               label: Text("Transaction ID"),
                               numeric: false,
                               tooltip: ""
                             ),
                             DataColumn(
                                 label: Text("Account No."),
                                 numeric: false,
                                 tooltip: ""
                             ),
                             DataColumn(
                                 label: Text("Phone"),
                                 numeric: false,
                                 tooltip: ""
                             ),
                             DataColumn(
                                 label: Text("Amount"),
                                 numeric: false,
                                 tooltip: ""
                             ),
                             DataColumn(
                                 label: Text("Name"),
                                 numeric: false,
                                 tooltip: ""
                             ),
                             DataColumn(
                                 label: Text("Amount"),
                                 numeric: false,
                                 tooltip: ""
                             ),
                             DataColumn(
                                 label: Text("Original Bal"),
                                 numeric: false,
                                 tooltip: ""
                             ),
                             DataColumn(
                                 label: Text("Current Bal."),
                                 numeric: false,
                                 tooltip: "Current Bal."
                             ),
                             DataColumn(
                                 label: Text("Date"),
                                 numeric: false,
                                 tooltip: "Date"
                             ),
                           ],
                           rows: [

                           ],
                         );

                          *//*Table(

                           border: TableBorder.all(
                               color: Colors.grey[300], width: 0.5,
                               style: BorderStyle.solid),
                           children: [
                             TableRow(children: [
                               TableCell(child: Center(child: Text(snapshot.data[index].TransID.toString(),))),
                               TableCell(
                                 child: Center(child: Text(snapshot.data[index].AccountNumber.toString(),)),
                               ),
                               TableCell(child: Center(child: Text(snapshot.data[index].MSISDN))),
                               TableCell(child: Center(child: Text(
                                   snapshot.data[index].FirstName + ' ' +
                                       snapshot.data[index].MiddleName +
                                       ' ' +
                                       snapshot.data[index].LastName))),
                               TableCell(child: Center(child: Text(snapshot.data[index].TransAmount.toString(),))),
                               TableCell(child: Center(child: Text(snapshot.data[index].OrgAccountBalance.toString(),))),
                               TableCell(child: Center(child: Text(snapshot.data[index].CrtAccountBalance.toString(),))),
                               TableCell(child: Center(child: Text(snapshot.data[index].created_at,))),
                             ]),
                           ],
                         );*//*
                    });
                  }
                  else{
                    return Center(child: CircularProgressIndicator(),);
                  }
                },
              ),
            )
          ],
        ),*/
      ),
    );
  }


}
