import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mbanking/Invest/Model/investment.dart';
import 'package:mbanking/Invest/terminate_request.dart';
import 'package:mbanking/utils/constants.dart';
import 'package:mbanking/utils/date_formatter.dart';
import 'package:mbanking/utils/string_formatter.dart';

class Investments extends StatefulWidget {
  @override
  _InvestmentsState createState() => _InvestmentsState();
}

class _InvestmentsState extends State<Investments> {
  var invest;
  var stringFormatter = StringFormatter();
  var dateFormatter = FormatDate();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    invest = Investment(context: context);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          title: Text("My investments",
          ),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh,color: white,),onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Investments(),));
            },)
          ],
        ),
        body: FutureBuilder(
            future: invest.getInvestments(),
            builder: (context,snapshot){
              if(snapshot.hasData){
                if(snapshot.data.length == 0 || snapshot.data == null){
                  return Center(child: Text("No Investments Found"),);
                }else{
                  return dataTable(snapshot.data);
                }

              }else{
                return Center(child: CircularProgressIndicator(),);
              }

        }),
      ),
    );
  }

  Widget dataTable(List<Investment> investments) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text("#",
              style: TextStyle(
                color: mainColor,
                fontWeight: FontWeight.bold,
                fontSize: 15.0
              ),)
            ),
            DataColumn(
                label: Text("Amount",
                  style: TextStyle(
                      color: mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0
                  ),)
            ),
            DataColumn(
                label: Text("Duration",
                  style: TextStyle(
                      color: mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0
                  ),)
            ),
            DataColumn(
                label: Text("Termination Date",
                  style: TextStyle(
                      color: mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0
                  ),)
            ),
            DataColumn(
                label: Text("Interest",
                  style: TextStyle(
                      color: mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0
                  ),)
            ),
            DataColumn(
                label: Text("Total Pay",
                  style: TextStyle(
                      color: mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0
                  ),)
            ),
            DataColumn(
                label: Text("Created at",
                  style: TextStyle(
                      color: mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0
                  ),)
            ),
            DataColumn(
                label: Text("Status",
                  style: TextStyle(
                      color: mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0
                  ),)
            ),

            DataColumn(
                label: Text("Action",
                  style: TextStyle(
                      color: mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0
                  ),)
            ),
          ],
          rows: investments.map((investment) => DataRow(
            cells: [
              DataCell(
                Text(investment.id.toString())
              ),
              DataCell(
                  Text(stringFormatter.formatString(investment.amount))
              ),

              DataCell(
                  Text(investment.duration)
              ),

              DataCell(
                  Text(dateFormatter.formatDate(investment.terminationDate))
              ),

              DataCell(
                  Text(stringFormatter.formatString(investment.interest) + '%')
              ),

              DataCell(
                  Text(stringFormatter.formatString(investment.totalPay))
              ),

              DataCell(
                  Text(dateFormatter.formatDate(investment.createdAt))
              ),

              DataCell(
                  investmentStatus(investment.status)
              ),

              DataCell(
                  terminateInvestment(investment.status,investment.id)
              ),

            ]
          )).toList(),
        ),
      ),
    );
  }

  Widget investmentStatus(String status){
    if(status == "1"){
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            color: success
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 12,right: 12,top: 4,bottom: 4),
          child: Text("Active",
            style: TextStyle(
                color: white,
                fontFamily: 'ptserif'
            ),),
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          color: danger
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12,right: 12,top: 4,bottom: 4),
        child: Text("Terminated",
          style: TextStyle(
              color: white,
              fontFamily: 'ptserif'
          ),),
      ),
    );

  }

  Widget terminateInvestment(String status,int investmentId) {
    if(status == '1'){
      return GestureDetector(
        onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => TerminateRequest(investmentId),));
        },
        child: Container(
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            color: primary
          ),
          child: Padding(
            padding:EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
            child: Text('Request Termination',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: white,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      );
    }
    return Text("terminated",textAlign: TextAlign.center,
    style: TextStyle(
      color: danger
    ),);
  }
}

/*int id;
  String duration;
  String terminationDate;
  String interest;
  String amount;
  String status;
  String totalPay;
  String createdAt;*/
