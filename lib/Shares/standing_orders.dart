import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mbanking/Shares/Models/standing_order.dart';
import 'package:mbanking/Shares/create_standing_order.dart';
import 'package:mbanking/utils/constants.dart';
import 'package:mbanking/utils/date_formatter.dart';
import 'package:mbanking/utils/string_formatter.dart';

class UserStandingOrders extends StatefulWidget {
  List<StandingOrderModel> standingOrders;

  UserStandingOrders(this.standingOrders);

  @override
  _UserStandingOrdersState createState() => _UserStandingOrdersState();
}

class _UserStandingOrdersState extends State<UserStandingOrders> {
  
  var dateFormatter =  FormatDate();
  var stringFormatter = StringFormatter();
  var STOs;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:  AppBar(
          backgroundColor: mainColor,
          elevation: 0.0,
        title: Text("Standing Orders",
        style: TextStyle(
        color: white,
    ),),
    ),

        body: SingleChildScrollView(
           scrollDirection: Axis.horizontal,
          child:  StandingOrderDataTable(widget.standingOrders),
        ),
    ));
  }

  StandingOrderDataTable(List<StandingOrderModel> standingOrders) {
    return DataTable(
      columns: [
        DataColumn(
            label: Text("Amount",
              style: TextStyle(
                  color: mainColor,
                  fontWeight: FontWeight.bold
              ),)
        ),
        DataColumn(
            label: Text("Duration",
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
        ),
        DataColumn(
            label: Text("Created at",
              style: TextStyle(
                  color: mainColor,
                  fontWeight: FontWeight.bold
              ),)
        ),
        DataColumn(
            label: Text("Next Order",
              style: TextStyle(
                  color: mainColor,
                  fontWeight: FontWeight.bold
              ),)
        ),
        DataColumn(
            label: Text("Update",
              style: TextStyle(
                  color: mainColor,
                  fontWeight: FontWeight.bold
              ),)
        ),
        DataColumn(
            label: Text("Stop/Start",
              style: TextStyle(
                  color: mainColor,
                  fontWeight: FontWeight.bold
              ),)
        ),
      ],
      rows: standingOrders.map((standingOrder) => DataRow(
        selected: false,
        cells: [
          DataCell(
            Text(stringFormatter.formatString(standingOrder.amount))
          ),
          DataCell(
              Text(standingOrder.duration + " month(s)")
          ),
          DataCell(
              orderStatus(standingOrder.status)
          ),
          DataCell(
              Text(dateFormatter.formatDate(standingOrder.created_at))
          ),
          DataCell(
              Text(dateFormatter.formatDate(standingOrder.nextOrder))
          ),DataCell(
              IconButton(icon: Icon(FontAwesomeIcons.edit),
                color: info,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => StandingOrder(standingOrder: standingOrder,),));
                },
              )
          ),
          DataCell(
                  getStopStartBtn(standingOrder.status,standingOrder.id)
          ),
        ]
      )).toList(),
    );
  }

  Widget orderStatus(String status){
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
        child: Text("Closed",
          style: TextStyle(
              color: white,
              fontFamily: 'ptserif'
          ),),
      ),
    );

  }

  Widget getStopStartBtn(String status,String id){

    if(status == '1'){
     return GestureDetector(
        onTap: (){
           stopStart(id);
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              color: danger
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 12,right: 12,top: 4,bottom: 4),
            child: Text("Stop STO",
              style: TextStyle(
                  color: white,
                  fontFamily: 'ptserif'
              ),),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: (){
        stopStart(id);
      },
      child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      color: success
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12,right: 12,top: 4,bottom: 4),
                    child: Text("Activate STO",
                      style: TextStyle(
                          color: white,
                          fontFamily: 'ptserif'
                      ),),
                  ),
                ),
    );

  }

  void stopStart(String id) async{

    STOs = StandingOrderModel(context: context);
    STOs.stopStartStandingOrder(id);
    var  myStandingOrders = await STOs.getStandingOrders();
    setState(() {
      widget.standingOrders = myStandingOrders;
    });

  }



}

/*"amount": "250",
  "duration": "1",
  "destinationId": "4",
  "nextOrder": "2020-06-22 12:36:26",
  "status": 1,
  "created_at": "2020-05-21 14:05:29",*/
