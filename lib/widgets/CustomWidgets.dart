import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
   String name;
   String path;
   CustomCard(this.name,this.path);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(path,
            width: 50,
            height: 50,
          ),
          SizedBox(height: 3,),
          Text(name,
            style: TextStyle(
                color: Color.fromRGBO(143, 148, 251, 10),
                fontSize: 15,
                fontFamily: 'ptserif'
            ),)

        ],
      ),
    );
  }
}

class AccountCard extends StatelessWidget {

  String path;
  String name;
  AccountCard(this.name,this.path);
  @override
  Widget build(BuildContext context) {
    return  Card(
      elevation: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 30,
            child: Image.asset(path,
              width: 30,
              height: 30,
            ),
            backgroundColor: Colors.grey[300],
          ),
          Text(name,
            style: TextStyle(
              color: Color.fromRGBO(143, 148, 251, 1),
              fontFamily: 'ptserif',
            ) ,)
        ],
      ),
    );
  }
}

