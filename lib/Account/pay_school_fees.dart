import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mbanking/Account/school_fee.dart';
import 'package:mbanking/Models/school.dart';
import 'package:sweetalert/sweetalert.dart';

class PaySchoolFees extends StatefulWidget {
  @override
  _PaySchoolFeesState createState() => _PaySchoolFeesState();
}

class _PaySchoolFeesState extends State<PaySchoolFees> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(143, 148, 251, 1),
          title: Text("Select School",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'ptserif',
          ),),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: FutureBuilder(
          future: School().fetchSchools(),
          builder: (context,snapshot){
            if(snapshot.hasError){
              print(snapshot.error);
            }
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context,index){
                    return Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.school,color: Color.fromRGBO(143, 145, 241, 1),),
                          title: Text(snapshot.data[index].Name),
                          subtitle: Text(snapshot.data[index].Paybill) ,
                          onTap: (){

                            SweetAlert.show(context,
                                style: SweetAlertStyle.confirm,
                                title: "Fee Payment",
                                subtitle: "Are you sure you want to pay Fees to "+snapshot.data[index].Name,
                                showCancelButton: true,
                                cancelButtonColor: Colors.green,
                                // confirmButtonColor: Colors.green,
                                cancelButtonText: "Cancel",
                                confirmButtonText: " Pay Fee !",
                                onPress: (bool value){
                                  if(value){
                                    SweetAlert.show(context,subtitle: "Redirecting...", style: SweetAlertStyle.loading);
                                    new Future.delayed(new Duration(seconds: 1 ),(){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PayFee(BusinessNo: snapshot.data[index].Paybill,)));
                                    });

                                  }
                                  return true;
                                });
                          },
                        ),
                        Divider(height: 8, color:  Colors.grey[300],)
                      ],
                    );
              });

            }  else{
              return Center(child: CircularProgressIndicator
                (semanticsLabel: "Loading Data ..",
              backgroundColor: Colors.red,
              semanticsValue: "Loading",),);
            }
          },
        ),
      ),
    );
  }
}
