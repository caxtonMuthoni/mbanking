import 'package:flutter/material.dart';
import 'package:mbanking/Invest/Model/termination_requests.dart';
import 'package:mbanking/utils/constants.dart';
import 'package:mbanking/utils/date_formatter.dart';

class TerminationRequests extends StatefulWidget {
  @override
  _TerminationRequestsState createState() => _TerminationRequestsState();
}

class _TerminationRequestsState extends State<TerminationRequests> {

  var terminateRequest;
  var dateFormatter =  FormatDate();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    terminateRequest = TerminationRequest(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: mainColor,
          title: Text("My termination requests"),
        ),

        body: FutureBuilder(
          future: terminateRequest.getRequests(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              if(snapshot.data.length == 0 || snapshot.data == null){
                return Center(child: Text("No requests found"),);
              }else{
                return dataTable(snapshot.data);
              }

            }
            return Center(child: CircularProgressIndicator());
          },
        ),

      ),
    );
  }

  Widget dataTable(List<TerminationRequest> terminationRequests) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        primary: true,
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text("#",
              style: TextStyle(
                color: mainColor,
                fontWeight: FontWeight.bold
              ),)
            ),
            DataColumn(
                label: Text("Reason",
                  style: TextStyle(
                      color: mainColor,
                      fontWeight: FontWeight.bold
                  ),)
            ),
            DataColumn(
                label: Text("Submited At",
                  style: TextStyle(
                      color: mainColor,
                      fontWeight: FontWeight.bold
                  ),)
            ),
            DataColumn(
                label: Text("Status",
                  style: TextStyle(
                      color: mainColor,
                      fontWeight: FontWeight.bold
                  ),)
            )
          ],

          rows: terminationRequests.map((request) => DataRow(
            cells: [
              DataCell(
                Text(request.id.toString())
              ),
              DataCell(
                  Text(request.reason)
              ),
              DataCell(
                  Text(dateFormatter.formatDate(request.createdAt))
              ),
              DataCell(
                  statusShow(request.status)
              ),
            ]
          )).toList(),

        ),
      ),
    );
  }

  Widget statusShow(String status) {
    if(status == "0"){
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            color: secondary
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 12,right: 12,top: 4,bottom: 4),
          child: Text("pending",
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
          color: success
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12,right: 12,top: 4,bottom: 4),
        child: Text("processed",
          style: TextStyle(
              color: white,
              fontFamily: 'ptserif'
          ),),
      ),
    );
  }
}
