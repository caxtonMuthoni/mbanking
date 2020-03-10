import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mbanking/Account/AccountStatement.dart';
import 'package:mbanking/General/Constants.dart';
import 'package:mbanking/Models/Account.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:http/http.dart' as http;

class MyAccounts extends StatefulWidget {
  @override
  _MyAccountsState createState() => _MyAccountsState();
}

List<Account> accounts = [];

class _MyAccountsState extends State<MyAccounts> {

  ProgressDialog pr;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Account().fetchUserAccounts(context).then((data){
      accounts = data;
    });
  }

  destroyAccount(String id) async{
    try{
      final response = await http.Client().get(BASE_URL+"api/delete/"+id,headers: RequestHeaders);
      final jsonData = jsonDecode(response.body);
      print(response.body);
      print(response.statusCode);
      if(response.statusCode == 200){
        if(jsonData['status'] == 'true'){
          Future.delayed(Duration(seconds: 3)).then((value) {
            pr.hide().whenComplete(() {
              SweetAlert.show(context,
                  style: SweetAlertStyle.success,
                  title: "Success",
                  subtitle: jsonData['success']
              );
            });
          });
        }
        else if(jsonData['status'] == "false"){

          Future.delayed(Duration(seconds: 3)).then((value){
             pr.hide().whenComplete((){
               SweetAlert.show(
                 context,
                 title: "Oops",
                 subtitle: jsonData['error'],
                 style: SweetAlertStyle.error,
               );
             });
          });

        }
      }
      else{
        Future.delayed(Duration(seconds: 3)).then((value){
          pr.hide().whenComplete((){
            SweetAlert.show(context,
                title: "Oops",
                subtitle: "An error ocured please try again another time",
                style: SweetAlertStyle.error
            );
          });
        });
      }

    }catch(e){
          Future.delayed(Duration(seconds: 3)).then((value){
            pr.hide().whenComplete((){
            SweetAlert.show(context,
            title: "Oops",
            subtitle: "An error ocured please try another time");
            });
          });
    }
  }


  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context,type: ProgressDialogType.Normal);
    pr.style(
        message: 'Creating account ...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.deepPurpleAccent, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.deepPurpleAccent, fontSize: 19.0, fontWeight: FontWeight.w600)
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Accounts",
          style: TextStyle(
            color: Colors.white,
            fontFamily: ' BowlbyOneSC'
          ),),
          backgroundColor: Color.fromRGBO(143, 148, 251, 1),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              columns: [
                DataColumn(
                    label: Text("Account Name",style: TextStyle(
                        fontFamily: 'BowlbyOneSC',
                        fontSize: 13,
                        fontWeight: FontWeight.bold
                    ),),
                    numeric: false,
                    tooltip: ""
                ),
                DataColumn(
                    label: Text("Account Number",style: TextStyle(
                        fontFamily: 'BowlbyOneSC',
                        fontSize: 13,
                        fontWeight: FontWeight.bold
                    ),),
                    numeric: false,
                    tooltip: ""
                ),
                DataColumn(
                    label: Text("Current Balance",style: TextStyle(
                        fontFamily: 'BowlbyOneSC',
                        fontSize: 13,
                        fontWeight: FontWeight.bold
                    ),),
                    numeric: false,
                    tooltip: ""
                ),
                DataColumn(
                    label: Text("View Statement",style: TextStyle(
                        fontFamily: 'BowlbyOneSC',
                        fontSize: 13,
                        fontWeight: FontWeight.bold
                    ),),
                    numeric: false,
                    tooltip: ""
                ),
                DataColumn(
                    label: Text("Close Account",style: TextStyle(
                        fontFamily: 'BowlbyOneSC',
                        fontSize: 13,
                        fontWeight: FontWeight.bold
                    ),),
                    numeric: false,
                    tooltip: ""
                ),
              ],
              rows: accounts.map((account)=>DataRow(cells: [
                DataCell(Text(account.AccountName)),
                DataCell(Text(account.AccountNumber.toString())),
                DataCell(Text(account.CurrentBalance.toString())),
                DataCell(IconButton(
                  icon: Icon(Icons.list),
                  color: Colors.blue,
                  onPressed: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountStatement(accountNumber:account.AccountNumber ,name: account.AccountName)));
                  },
                )),
                DataCell(IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.redAccent,
                  onPressed: (){
                     SweetAlert.show(context,
                     style: SweetAlertStyle.confirm,
                     title: "Delete",
                     subtitle: "Are you sure you want to close the account. Please note that process is not reversable",
                     showCancelButton: true,
                     cancelButtonColor: Colors.green,
                    // confirmButtonColor: Colors.green,
                     cancelButtonText: "Cancel",
                     confirmButtonText: "Yes Delete !",
                     onPress: (bool value){
                       if(value){
                         pr.show();
                          destroyAccount(account.id.toString());
                       }
                       return true;
                     });

                  },
                )),
              ])).toList(),
            ),
          ),
        ) ,
      ),
    );
  }
}
