import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mbanking/Account/Borrows.dart';
import 'package:mbanking/Account/Lends.dart';
import 'package:mbanking/Account/depositWithdraw.dart';
import 'package:mbanking/Account/statement.dart';
import 'package:mbanking/Home/myDrawer.dart';
import 'package:mbanking/login/Otp.dart';
import 'package:mbanking/widgets/CustomWidgets.dart';

class AccountHome extends StatefulWidget {
  @override
  _AccountHomeState createState() => _AccountHomeState();
}

class _AccountHomeState extends State<AccountHome> {
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
                  CircleAvatar(
                    backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                    backgroundImage: AssetImage('assets/images/avatar.png'),

                    radius: 50,
                  ),
                  SizedBox(height: 10,),
                  Text('Caxton Githinji Muthoni',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'ptserif',
                    fontSize: 20,
                  ),),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("BAL in KES : ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'BowlbyOneSC'
                      ),),
                      Text("1000",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'ptserif'
                        ),)
                    ],
                  )


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
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPVerification("School Fees")));
                        },
                        child: AccountCard("School Fees", 'assets/images/fees.png')),
                    GestureDetector(
                         onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPVerification("Lipa Na Mpesa")));
                        },
                        child: AccountCard("Lipa Na Mpesa", 'assets/images/mpesa.png')),
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
                        child: AccountCard("My Borrows", 'assets/images/borrow.png')),

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
