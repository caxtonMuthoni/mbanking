import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mbanking/Account/Borrows.dart';
import 'package:mbanking/Account/Lends.dart';
import 'package:mbanking/Account/depositWithdraw.dart';
import 'package:mbanking/Account/statement.dart';
import 'package:mbanking/General/Constants.dart';
import 'package:mbanking/General/Profile.dart';
import 'package:mbanking/Home/myDrawer.dart';
import 'package:mbanking/Models/Profile.dart';
import 'package:mbanking/Models/User.dart';
import 'package:mbanking/login/Otp.dart';
import 'package:mbanking/widgets/CustomWidgets.dart';
import 'package:http/http.dart' as http;



class AccountHome extends StatefulWidget {
  @override
  _AccountHomeState createState() => _AccountHomeState();
}

User user;

class _AccountHomeState extends State<AccountHome> {

  @override
  void initState() {
    User.fetchUser(client: http.Client(),context: context).then((data){
      setState(() {
        user = data;
        print("data is " + data.FirstName);
      });
    });

  }
  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        backgroundColor: Color.fromRGBO(143, 148, 251, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(143, 148, 251, 1),
          elevation: 0,
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 170,
              child:Column(
                children: <Widget>[
                  FutureBuilder(
                    future: User.fetchUser(client: http.Client(),context: context ),
                    builder: (context,snapshot){
                      return  Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: snapshot.hasData ? Column(
                          children: <Widget>[
                            FutureBuilder(
                              future: Profile.fetchProfile(context),
                              builder: (context,snapshotP){
                                if(snapshotP.hasData){
                                  return GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MyProfile()));
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                                      backgroundImage: NetworkImage(BASE_URL+"images/avatar/"+snapshotP.data.Avatar),
                                      radius: 50,
                                    ),
                                  );
                                }else{
                                  return CircularProgressIndicator();
                                }
                              },
                            ),

                            SizedBox(height: 10,),

                            Text(snapshot.data.FirstName + "  "+snapshot.data.MiddleName+" "+snapshot.data.LastName,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'ptserif',
                                fontSize: 20,
                              ),),
                            SizedBox(height: 10,),



                          ],
                        ): CircularProgressIndicator(),
                      );
                    },
                  ),

                  Text("Select  the options below to enjoy our services",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontFamily: 'YeonSung'
                  ),),



                ],
              )
            ),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60.0),
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GridView.count(crossAxisCount: 3,
                  children: <Widget>[
                    GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>DepositWithDraw("Deposit")));
                        },
                        child: AccountCard("Deposit", 'assets/images/deposit.png')),
                    GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPVerification("Withdraw")));
                        },
                        child: AccountCard("Withdraw", 'assets/images/withdraw.png')),
                    GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPVerification("PayBill")));
                        },
                        child: AccountCard("PayBill", 'assets/images/paybill.jpeg')),
                    GestureDetector(
                         onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPVerification("fee")));
                        },
                        child: AccountCard("School Fees", 'assets/images/fees.png')),
                    GestureDetector(
                         onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPVerification("airtime")));
                        },
                        child: AccountCard("Buy Airtime", 'assets/images/airtime.png')),
                    GestureDetector(
                         onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPVerification("Transfer Funds")));
                        },
                        child: AccountCard("Tranfer Funds", 'assets/images/transfer.png')),
                    GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Statement()));
                        },
                        child: AccountCard("Statement", 'assets/images/statement.jpeg')),
                    GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Lends()));
                        },
                        child: AccountCard("Funded Loans", 'assets/images/loan.png')),
                    GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Borrows()));
                        },
                        child: AccountCard("My Loans", 'assets/images/borrow.png')),

                  ],),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


}
