import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mbanking/Account/account_statement.dart';
import 'package:mbanking/General/constants.dart';
import 'package:mbanking/Models/account.dart';
import 'package:mbanking/utils/constants.dart';
import 'package:mbanking/utils/string_formatter.dart';
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

  var myAccounts = Account();

  var stringFormatter = StringFormatter();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
            color: Colors.deepPurpleAccent, fontSize: 15.0, fontWeight: FontWeight.w400),
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
        body: FutureBuilder(
          future: myAccounts.fetchUserAccounts(context),
          builder: (context,snapshot){
            if(snapshot.hasData){
              if(snapshot.data.length == 0 || snapshot.data == null){
                return Center(child: Text("No Account Found !!!"),);
              }else{
                return dataTable(snapshot.data);
              }

            }else{
              return Center(child: CircularProgressIndicator());
            }
          },
        ) ,
      ),
    );
  }

  Widget dataTable(List<Account> accounts){

    List<Account> groupAccounts = [];
    List<Account> personalAccounts = [];

    accounts.forEach((account) {
      if(account.AccountCode == "201"){
        groupAccounts.add(account);
      }else{
        personalAccounts.add(account);
      }
    });

    return  SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(FontAwesomeIcons.mandalorian,color: primary,size: 18,),
                  SizedBox(width: 10.0,),
                  Text(" My Personal Accounts",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: success
                    ),
                  )
                ],
              ),
            ),
            accountDataTable(personalAccounts),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(FontAwesomeIcons.objectGroup,color: success,size: 18,),
                  SizedBox(width: 10.0,),
                  Text(" My Group Accounts",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: primary
                    ),
                  )
                ],
              ),
            ),
            Divider(height: 10.0,),
            accountDataTable(groupAccounts)
          ],
        ),
      ),
    );

  }

  accountDataTable(List<Account> accounts) {
    return  DataTable(
      columns: [
        DataColumn(
            label: Text("Account Name",style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: mainColor,
            ),),
            numeric: false,
            tooltip: ""
        ),
        DataColumn(
            label: Text("Account Number",style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: mainColor,
            ),),
            numeric: false,
            tooltip: ""
        ),
        DataColumn(
            label: Text("Current Balance",style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: mainColor,
            ),),
            numeric: false,
            tooltip: ""
        ),
        DataColumn(
            label: Text("View Statement",style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: mainColor,
            ),),
            numeric: false,
            tooltip: ""
        ),
        DataColumn(
            label: Text("Close Account",style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: mainColor,
            ),),
            numeric: false,
            tooltip: ""
        ),
      ],
      rows: accounts.map((account)=>DataRow(cells: [
        DataCell(Text(account.AccountName)),
        DataCell(Text(account.AccountNumber.toString())),
        DataCell(Text(stringFormatter.formatString(account.CurrentBalance.toString()))),
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
    );
  }
}
