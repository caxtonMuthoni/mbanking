import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:mbanking/Account/Lends.dart';
import 'package:mbanking/Account/accountHome.dart';
import 'package:mbanking/General/Borrowers.dart';
import 'package:mbanking/General/Constants.dart';
import 'package:mbanking/General/aboutUs.dart';
import 'package:mbanking/General/querry.dart';
import 'package:mbanking/General/statistics.dart';
import 'package:mbanking/Home/myDrawer.dart';
import 'package:mbanking/widgets/CustomWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeMain extends StatefulWidget {
  @override
  _HomeMainState createState() => _HomeMainState();
}


class _HomeMainState extends State<HomeMain> {



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        backgroundColor: Color.fromRGBO(143, 148, 251, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(143, 148, 251, 1),
          elevation: 0.0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 150,
              child: Column(
                children: <Widget>[
                  Text('78%',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'BowlbyOneSC',
                      fontSize: 35,
                    ),),
                  Text('Repayment Rate',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'BowlbyOneSC',
                    fontSize: 15,
                  ),),
                  SizedBox(height: 5,),
                  Text('Change lifes by lending as little as 200 KES. Lend now and create opportunities for others',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'ptserif',
                      fontSize: 18,
                    ),)
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15.0),
                      topLeft: Radius.circular(15.0))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.count(crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  children: <Widget>[
                    GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountHome()));
                        },
                        child: CustomCard('Account', 'assets/images/cashregister.png')),
                    GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Borrowers()));
                        },
                        child: CustomCard('Borrowers', 'assets/images/bill.png')),
                    GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Lends()));
                        },
                        child: CustomCard('Loans', 'assets/images/creditcard.png')),
                    GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Statistics()));
                        },
                        child: CustomCard('Statistics', 'assets/images/015-card.png')),
                    GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Query()));
                        },
                        child: CustomCard('Review', 'assets/images/006-bill.png')),
                    GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutUs()));
                        },
                        child: CustomCard('About Us', 'assets/images/paymentmethod.png')),

                  ],),
                ),
              ),
            ),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color:Colors.white70,
                  elevation: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("1000",
                            style: TextStyle(
                                color: Color.fromRGBO(143, 148, 251, 1),
                                fontSize: 25,
                                fontFamily: 'ptserif'
                            ),),
                          SizedBox(height: 5,),
                          Text("Happy Customers",
                            style: TextStyle(
                                color: Color.fromRGBO(143, 148, 251, 1),
                                fontSize: 15,
                                fontFamily: 'ptserif'
                            ),),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.supervised_user_circle,
                          size: 60,
                          color: Color.fromRGBO(143, 148, 251, 1),),
                        ],
                      ),

                    ],
                  )
                ),
              ),
            )

          ],

        ),
      ),
    );
  }

  @override
  void initState() {
    checkLoginStatus(context);
  }

 /* @override
  BuildContext get context {

  }*/
}
