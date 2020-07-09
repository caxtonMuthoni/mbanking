import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:mbanking/flexible_app_bar.dart';
import 'package:mbanking/my_app_bar.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<double> data1 = [1.0, 1.1, 1.0, 1.2, 1.3, 1.3, 1.3, 1.3];
  List<double> data2 = [0.8, 0.7, 1.0, 0.9, 0.2, 1.3, 1.6, 0.8, 0.3, 0.0];
  List<double> data3 = [1.0, 1.1, 1.0, 0.9, 1.2, 1.2, 1.3, 1.4];
  List<double> data4 = [0.4,0.5,0.6,1.0,1.0,0.9,0.6,0.5];
  List<double> data5 = [1.0, 1.1, 1.0, 0.9, 1.2, 1.3, 0.8,1,2];
  List<double> data6 = [0.8,0.9,0.7,0.6,0.8,0.9];
  List<double> data7 = [0.2,0.3,0.6,1.0,0.6,0.3,0.2];
  List<double> data8 = [1.0,1.1,1.2,1.3,1.4,1.2,1.3];
  List<double> data9 = [1.0, 1.1, 1.0, 0.9, 1.2, 1.3, 1.0, 0.8, 1.3, 1.0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: MyAppBar(),
              pinned: true,
              expandedHeight: 210.0,
              flexibleSpace: FlexibleSpaceBar(
                background: MyFlexiableAppBar(),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  listItem('Janaury 2019', "Mpesa Deposit", 20.0),
                  listItem('February 2019', "Mpesa Deposit", 210.0),
                  listItem('March 2019', "withdraw", 270.0),
                  listItem('July 2019', "Mpesa Deposit", 420.0),
                  listItem('June 2019', "withdraw", 620.0),
                  listItem('July 2019', "Mpesa Deposit", 7.0),
                  listItem('May 2019', "Loan fund", 210.0),
                  listItem('June 2019', "withdraw", 620.0),
                  listItem('July 2019', "Mpesa Deposit", 7.0),
                  listItem('May 2019', "Loan fund", 210.0),

                ],
              ),
            ),
          ],
        )
    );
  }

}

Widget listItem(String date,String description, double amount){
  return(
      Padding(
        padding: const EdgeInsets.all(1.0),
        child: Material(
          elevation: 14.0,
          borderRadius: BorderRadius.circular(2.0),
          shadowColor: Colors.black12,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 20, 5, 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(child: Text(
                  date, style: const TextStyle(
                    color: Colors.black54,
                    fontFamily: 'ptserif',
                    fontSize: 16.0
                ),),),
                Container(child: Text(
                  description, style: const TextStyle(
                    color: Colors.black54,
                    fontFamily: 'ptserif',
                    fontSize: 16.0
                ),),),
                Container(child: Text(
                  '\u0024'+amount.toString(), style: const TextStyle(
                    color: Colors.black54,
                    fontFamily: 'ptserif',
                    fontSize: 16.0
                ),),),
              ],
            ),
          ),),
      )
  );
}

