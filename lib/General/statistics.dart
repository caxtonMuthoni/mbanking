import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mbanking/Account/Airtime.dart';

class Statistics extends StatefulWidget {
  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {

//  List<charts.Series<Expenditure,String>> _seriesPieData;

  _generateData(){
    var pieData = [
      new Expenditure("Airtime", 100.3, Colors.green),
      new Expenditure("paybill", 50.2, Colors.teal),
      new Expenditure("school fee", 70.9, Colors.blue),
      new Expenditure("loans", 120.2, Colors.yellow),
      new Expenditure("transaction", 20.5, Colors.purple),

    ];
//    _seriesPieData.add(
//      charts.Series(
//
//      )
//    );
  }

  @override
  void initState() {
  _generateData();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(143, 148, 251, 1),
            title: Text("Statistics",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'BowlbyOneSC'
              ),),
            centerTitle: true,
            bottom: TabBar(
                indicatorColor: Colors.green,
                labelColor: Colors.white,
                tabs: [
              Tab(text: "Expenditure",
              icon: Icon(FontAwesomeIcons.chartPie),),
              Tab(text: "Loan",
              icon: Icon(FontAwesomeIcons.chartBar),),
              Tab(text: "Borrow",
              icon: Icon(FontAwesomeIcons.chartLine),)
            ]),
          ),
          body: TabBarView(
            children: <Widget>[],
          ),
        ),
      ),
    );
  }


}

class Expenditure{
  String expenditure;
  double value;
  Color color;

  Expenditure(this.expenditure, this.value, this.color);

}
