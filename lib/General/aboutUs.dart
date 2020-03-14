import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(143, 148, 251, 1),
          title: Text("Who are we ?",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'BowlbyOneSC'
          ),),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 25,),
                 Text('######### Why US #########',
                 style: TextStyle(
                   color: Color.fromRGBO(148, 143, 251, 1),
                   fontFamily: 'BowlbyOneSC'
                 ),),
                Divider(height: 25,),
                Text(
                  "More than 1 million people around the Kenya are unbanked and can’t access the financial services they"
                      " need. Mbanking app is a Kenya nonprofit, founded in 2022 in Meru University, with a mission to expand "
                      "financial access to help underserved communities thrive.\n"

                    "We do this by crowdfunding loans and unlocking capital for the underserved, improving the quality and cost "
                      "of financial services, and addressing the underlying barriers to financial access around the world. "
                      "Through Mbanking work, students can pay for tuition, women can start businesses, "
                      "farmers are able to invest in equipment and families can afford needed emergency care.\n"

                    "By lending as little as 2500ksh on Mbanking, you can be part of the solution and make a real difference in someone’s life."
                    "100% of every Ksh you lend on Mbanking goes to funding loans.",
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'ptserif',
                    fontSize: 15.0,
                    height: 2.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
