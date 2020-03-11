

import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mbanking/Models/Profile.dart';
import 'package:mbanking/Models/User.dart';
import 'package:http/http.dart' as http;
import 'package:select_dialog/select_dialog.dart';

import 'Constants.dart';

class ProfilePage extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  TextEditingController FirstEditingController = TextEditingController();
  TextEditingController MiddleEditingController = TextEditingController();
  TextEditingController LastEditingController = TextEditingController();
  TextEditingController IdEditingController = TextEditingController();
  TextEditingController CityEditingController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController PhoneEditingController = TextEditingController();

  TextEditingController OccupationEditingController = TextEditingController();
  TextEditingController CompanyController = TextEditingController();
  TextEditingController AnnualEditingController = TextEditingController();
  TextEditingController MonthlyEditingController = TextEditingController();

  int selectedRadioTile;

  int selectedRadioTile2;

  File _image;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _image = null;
    selectedRadioTile = 10;
    selectedRadioTile2 = 10;
  }



  setSelectedRadioTile2(value){
    setState(() {
      selectedRadioTile2 = value;
    });
  }

  setSelectedRadioTile(value){
    setState(() {
      selectedRadioTile = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: new Scaffold(
          body: new Container(
            color: Colors.white,
            child: new ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    new Container(
                      height: 250.0,
                      color: Colors.white,
                      child: new Column(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(left: 20.0, top: 20.0),
                              child: new Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.black,
                                    size: 22.0,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 25.0),
                                    child: new Text('PROFILE',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0,
                                            fontFamily: 'sans-serif-light',
                                            color: Colors.black)),
                                  )
                                ],
                              )),
                          Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: new Stack(fit: StackFit.loose, children: <Widget>[
                              new Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[

                                  FutureBuilder(
                                    future: Profile.fetchProfile(context),
                                    builder: (context,snapshotP){
                                      if(snapshotP.hasData){

                                        if (_image == null) {
                                          return GestureDetector(
                                              onTap: (){
                                                Navigator.pop(context);
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
                                              },
                                              child: Container(
                                                  width: 140.0,
                                                  height: 140.0,
                                                  decoration: new BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: new DecorationImage(
                                                      image: NetworkImage(BASE_URL+"images/avatar/"+snapshotP.data.Avatar),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                              ));
                                        }
                                        else{
                                          return GestureDetector(
                                              onTap: (){
                                                Navigator.pop(context);
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
                                              },
                                              child: Container(
                                                  width: 140.0,
                                                  height: 140.0,
                                                  decoration: new BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: new DecorationImage(
                                                      image: FileImage(_image),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                              ));
                                        }

                                      }else{
                                        return new Container(
                                            width: 140.0,
                                            height: 140.0,
                                            decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: new DecorationImage(
                                                image: new ExactAssetImage(
                                                    'assets/images/as.png'),
                                                fit: BoxFit.cover,
                                              ),
                                            ));
                                      }
                                    },
                                  ),

                                ],
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 90.0, right: 100.0),
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap:(){
                                          var ex1 ="selected sele";
                                          List<String> dta = ['Camera', 'Gallary'];
                                          getImage("Camera");
                                          /*SelectDialog.showModal<String>(
                                            context,
                                            label: "Where do you want to get the profile Picture",
                                            selectedValue: ex1,
                                            items: dta,
                                            onChange: (String selected) {
                                              getImage(selected);
                                            },
                                          );*/
                                        },
                                        child: new CircleAvatar(
                                          backgroundColor: Colors.red,
                                          radius: 25.0,
                                          child: new Icon(
                                            Icons.camera_alt,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                            ]),
                          )
                        ],
                      ),
                    ),
                    new Container(
                      color: Color(0xffFFFFFF),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 25.0),
                        child: FutureBuilder(
                          future: Profile.fetchProfile(context),
                          builder: (context,snapshot){
                            if(snapshot.hasData){

                              return  FutureBuilder(
                                future: User.fetchUser(client: http.Client(),context: context),
                                builder: (context,snapshot2){
                                   if(snapshot2.hasData && snapshot.hasData){

                                      OccupationEditingController.text = snapshot.data.Occupation ;
                                      CompanyController.text = snapshot.data.Company ;
                                      AnnualEditingController.text = snapshot.data.AnualIncome ;
                                      MonthlyEditingController.text = snapshot.data.MonthlyIncome ;

                                      FirstEditingController.text = snapshot2.data.FirstName ;
                                      MiddleEditingController.text = snapshot2.data.MiddleName ;
                                      LastEditingController.text = snapshot2.data.LastName ;
                                      IdEditingController.text = snapshot2.data.NationalID;
                                      CityEditingController.text = snapshot2.data.City ;
                                      EmailController.text = snapshot2.data.email ;
                                      PhoneEditingController.text = snapshot2.data.PhoneNumber ;

                                     return Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       children: <Widget>[
                                         Padding(
                                             padding: EdgeInsets.only(
                                                 left: 25.0, right: 25.0, top: 25.0),
                                             child: new Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               mainAxisSize: MainAxisSize.max,
                                               children: <Widget>[
                                                 new Column(
                                                   mainAxisAlignment: MainAxisAlignment.start,
                                                   mainAxisSize: MainAxisSize.min,
                                                   children: <Widget>[
                                                     new Text(
                                                       'Personal Information',
                                                       style: TextStyle(
                                                           fontSize: 18.0,
                                                           fontWeight: FontWeight.bold),
                                                     ),
                                                   ],
                                                 ),
                                                 new Column(
                                                   mainAxisAlignment: MainAxisAlignment.end,
                                                   mainAxisSize: MainAxisSize.min,
                                                   children: <Widget>[
                                                     _status ? _getEditIcon() : new Container(),
                                                   ],
                                                 )
                                               ],
                                             )),
                                         Padding(
                                             padding: EdgeInsets.only(
                                                 left: 25.0, right: 25.0, top: 25.0),
                                             child: new Row(
                                               mainAxisSize: MainAxisSize.max,
                                               children: <Widget>[
                                                 new Column(
                                                   mainAxisAlignment: MainAxisAlignment.start,
                                                   mainAxisSize: MainAxisSize.min,
                                                   children: <Widget>[
                                                     new Text(
                                                       'First Name',
                                                       style: TextStyle(
                                                           fontSize: 16.0,
                                                           fontWeight: FontWeight.bold),
                                                     ),
                                                   ],
                                                 ),
                                               ],
                                             )),
                                         Padding(
                                             padding: EdgeInsets.only(
                                                 left: 25.0, right: 25.0, top: 2.0),
                                             child: new Row(
                                               mainAxisSize: MainAxisSize.max,
                                               children: <Widget>[
                                                 new Flexible(
                                                   child: new TextField(
                                                     controller:FirstEditingController,
                                                     decoration: const InputDecoration(
                                                       hintText: "Enter Your First Name",
                                                     ),
                                                     enabled: !_status,
                                                     autofocus: !_status,

                                                   ),
                                                 ),
                                               ],
                                             )),
                                         Padding(
                                             padding: EdgeInsets.only(
                                                 left: 25.0, right: 25.0, top: 25.0),
                                             child: new Row(
                                               mainAxisSize: MainAxisSize.max,
                                               children: <Widget>[
                                                 new Column(
                                                   mainAxisAlignment: MainAxisAlignment.start,
                                                   mainAxisSize: MainAxisSize.min,
                                                   children: <Widget>[
                                                     new Text(
                                                       'Middle Name',
                                                       style: TextStyle(
                                                           fontSize: 16.0,
                                                           fontWeight: FontWeight.bold),
                                                     ),
                                                   ],
                                                 ),
                                               ],
                                             )),
                                         Padding(
                                             padding: EdgeInsets.only(
                                                 left: 25.0, right: 25.0, top: 2.0),
                                             child: new Row(
                                               mainAxisSize: MainAxisSize.max,
                                               children: <Widget>[
                                                 new Flexible(
                                                   child: new TextField(
                                                     controller:MiddleEditingController,
                                                     decoration: const InputDecoration(
                                                       hintText: "Enter Middle Name",
                                                     ),
                                                     enabled: !_status,
                                                     autofocus: !_status,

                                                   ),
                                                 ),
                                               ],
                                             )),
                                         Padding(
                                             padding: EdgeInsets.only(
                                                 left: 25.0, right: 25.0, top: 25.0),
                                             child: new Row(
                                               mainAxisSize: MainAxisSize.max,
                                               children: <Widget>[
                                                 new Column(
                                                   mainAxisAlignment: MainAxisAlignment.start,
                                                   mainAxisSize: MainAxisSize.min,
                                                   children: <Widget>[
                                                     new Text(
                                                       'Last Name',
                                                       style: TextStyle(
                                                           fontSize: 16.0,
                                                           fontWeight: FontWeight.bold),
                                                     ),
                                                   ],
                                                 ),
                                               ],
                                             )),
                                         Padding(
                                             padding: EdgeInsets.only(
                                                 left: 25.0, right: 25.0, top: 2.0),
                                             child: new Row(
                                               mainAxisSize: MainAxisSize.max,
                                               children: <Widget>[
                                                 new Flexible(
                                                   child: new TextField(
                                                     controller:LastEditingController,
                                                     decoration: const InputDecoration(
                                                       hintText: "Enter Your Last Name",
                                                     ),
                                                     enabled: !_status,
                                                     autofocus: !_status,

                                                   ),
                                                 ),
                                               ],
                                             )),
                                         Padding(
                                             padding: EdgeInsets.only(
                                                 left: 25.0, right: 25.0, top: 25.0),
                                             child: new Row(
                                               mainAxisSize: MainAxisSize.max,
                                               children: <Widget>[
                                                 new Column(
                                                   mainAxisAlignment: MainAxisAlignment.start,
                                                   mainAxisSize: MainAxisSize.min,
                                                   children: <Widget>[
                                                     new Text(
                                                       'Email ID',
                                                       style: TextStyle(
                                                           fontSize: 16.0,
                                                           fontWeight: FontWeight.bold),
                                                     ),
                                                   ],
                                                 ),
                                               ],
                                             )),
                                         Padding(
                                             padding: EdgeInsets.only(
                                                 left: 25.0, right: 25.0, top: 2.0),
                                             child: new Row(
                                               mainAxisSize: MainAxisSize.max,
                                               children: <Widget>[
                                                 new Flexible(
                                                   child: new TextField(
                                                     controller:EmailController,
                                                     decoration: const InputDecoration(
                                                         hintText: "Enter Email ID"),
                                                     enabled: !_status,
                                                   ),
                                                 ),
                                               ],
                                             )),
                                         Padding(
                                             padding: EdgeInsets.only(
                                                 left: 25.0, right: 25.0, top: 25.0),
                                             child: new Row(
                                               mainAxisSize: MainAxisSize.max,
                                               children: <Widget>[
                                                 new Column(
                                                   mainAxisAlignment: MainAxisAlignment.start,
                                                   mainAxisSize: MainAxisSize.min,
                                                   children: <Widget>[
                                                     new Text(
                                                       'Mobile',
                                                       style: TextStyle(
                                                           fontSize: 16.0,
                                                           fontWeight: FontWeight.bold),
                                                     ),
                                                   ],
                                                 ),
                                               ],
                                             )),
                                         Padding(
                                             padding: EdgeInsets.only(
                                                 left: 25.0, right: 25.0, top: 2.0),
                                             child: new Row(
                                               mainAxisSize: MainAxisSize.max,
                                               children: <Widget>[
                                                 new Flexible(
                                                   child: new TextField(
                                                     controller:PhoneEditingController,
                                                     decoration: const InputDecoration(
                                                         hintText: "Enter Mobile Number"),
                                                     enabled: !_status,
                                                   ),
                                                 ),
                                               ],
                                             )),
                                         Padding(
                                             padding: EdgeInsets.only(
                                                 left: 25.0, right: 25.0, top: 25.0),
                                             child: new Row(
                                               mainAxisSize: MainAxisSize.max,
                                               mainAxisAlignment: MainAxisAlignment.start,
                                               children: <Widget>[
                                                 Expanded(
                                                   child: Container(
                                                     child: new Text(
                                                       'National ID',
                                                       style: TextStyle(
                                                           fontSize: 16.0,
                                                           fontWeight: FontWeight.bold),
                                                     ),
                                                   ),
                                                   flex: 2,
                                                 ),
                                                 Expanded(
                                                   child: Container(
                                                     child: new Text(
                                                       'City',
                                                       style: TextStyle(
                                                           fontSize: 16.0,
                                                           fontWeight: FontWeight.bold),
                                                     ),
                                                   ),
                                                   flex: 2,
                                                 ),
                                               ],
                                             )),
                                         Padding(
                                             padding: EdgeInsets.only(
                                                 left: 25.0, right: 25.0, top: 2.0),
                                             child: new Row(
                                               mainAxisSize: MainAxisSize.max,
                                               mainAxisAlignment: MainAxisAlignment.start,
                                               children: <Widget>[
                                                 Flexible(
                                                   child: Padding(
                                                     padding: EdgeInsets.only(right: 10.0),
                                                     child: new TextField(
                                                       controller:IdEditingController,
                                                       decoration: const InputDecoration(
                                                           hintText: "Enter National ID"),
                                                       enabled: !_status,
                                                     ),
                                                   ),
                                                   flex: 2,
                                                 ),
                                                 Flexible(
                                                   child: new TextField(
                                                     controller:CityEditingController,
                                                     decoration: const InputDecoration(
                                                         hintText: "Enter City of resindence"),
                                                     enabled: !_status,
                                                   ),
                                                   flex: 2,
                                                 ),
                                               ],
                                             )),
                                         Padding(
                                             padding: EdgeInsets.only(
                                                 left: 25.0, right: 25.0, top: 25.0),
                                             child: new Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               mainAxisSize: MainAxisSize.max,
                                               children: <Widget>[
                                                 new Column(
                                                   mainAxisAlignment: MainAxisAlignment.start,
                                                   mainAxisSize: MainAxisSize.min,
                                                   children: <Widget>[
                                                     new Text(
                                                       'More Info About Me',
                                                       style: TextStyle(
                                                           fontSize: 18.0,
                                                           fontWeight: FontWeight.bold),
                                                     ),
                                                   ],
                                                 ),

                                               ],
                                             )),
                                         Padding(
                                             padding: EdgeInsets.only(
                                                 left: 25.0, right: 25.0, top: 25.0),
                                             child: new Row(
                                               mainAxisSize: MainAxisSize.max,
                                               children: <Widget>[
                                                 new Column(
                                                   mainAxisAlignment: MainAxisAlignment.start,
                                                   mainAxisSize: MainAxisSize.min,
                                                   children: <Widget>[
                                                     new Text(
                                                       'Employment Status',
                                                       style: TextStyle(
                                                           fontSize: 16.0,
                                                           fontWeight: FontWeight.bold),
                                                     ),
                                                   ],
                                                 ),
                                               ],
                                             )),

                                         RadioListTile(
                                           title: Text("Employeed"),
                                           subtitle: Text("You have secured a job somewhere."),
                                           activeColor: Colors.green,
                                           selected: false,
                                           groupValue: selectedRadioTile,
                                           value: 1,
                                           onChanged: (val){
                                             setSelectedRadioTile(val);
                                             print(selectedRadioTile);
                                           },
                                         ),
                                         Divider(height: 10, color: Colors.grey[400],),
                                         RadioListTile(
                                           title: Text("Unemployeed"),
                                           subtitle: Text("You got no job at all"),
                                           activeColor: Colors.green,
                                           selected: false,
                                           groupValue: selectedRadioTile,
                                           value: 0,
                                           onChanged: (val){
                                             setSelectedRadioTile(val);
                                             print(selectedRadioTile);
                                           },
                                         ),
                                         Divider(height: 10, color: Colors.grey[400],),
                                         RadioListTile(
                                           title: Text(" Self Employeed"),
                                           subtitle: Text("You have your own business"),
                                           activeColor: Colors.green,
                                           selected: false,
                                           groupValue: selectedRadioTile,
                                           value: 3,
                                           onChanged: (val){
                                             setSelectedRadioTile(val);
                                             print(selectedRadioTile);
                                           },
                                         ),
                                         Divider(height: 10, color: Colors.grey[400],),

                                         Padding(
                                             padding: EdgeInsets.only(
                                                 left: 25.0, right: 25.0, top: 25.0),
                                             child: new Row(
                                               mainAxisSize: MainAxisSize.max,
                                               children: <Widget>[
                                                 new Column(
                                                   mainAxisAlignment: MainAxisAlignment.start,
                                                   mainAxisSize: MainAxisSize.min,
                                                   children: <Widget>[
                                                     new Text(
                                                       'Occupation',
                                                       style: TextStyle(
                                                           fontSize: 16.0,
                                                           fontWeight: FontWeight.bold),
                                                     ),
                                                   ],
                                                 ),
                                               ],
                                             )),
                                         Padding(
                                             padding: EdgeInsets.only(
                                                 left: 25.0, right: 25.0, top: 2.0),
                                             child: new Row(
                                               mainAxisSize: MainAxisSize.max,
                                               children: <Widget>[
                                                 new Flexible(
                                                   child: new TextField(
                                                     controller:OccupationEditingController,
                                                     decoration: const InputDecoration(
                                                         hintText: "Enter your Occupation"),
                                                     enabled: !_status,
                                                   ),
                                                 ),
                                               ],
                                             )),
                                         Padding(
                                             padding: EdgeInsets.only(
                                                 left: 25.0, right: 25.0, top: 25.0),
                                             child: new Row(
                                               mainAxisSize: MainAxisSize.max,
                                               children: <Widget>[
                                                 new Column(
                                                   mainAxisAlignment: MainAxisAlignment.start,
                                                   mainAxisSize: MainAxisSize.min,
                                                   children: <Widget>[
                                                     new Text(
                                                       'Comapany/Organisation/Institution',
                                                       style: TextStyle(
                                                           fontSize: 16.0,
                                                           fontWeight: FontWeight.bold),
                                                     ),
                                                   ],
                                                 ),
                                               ],
                                             )),
                                         Padding(
                                             padding: EdgeInsets.only(
                                                 left: 25.0, right: 25.0, top: 2.0),
                                             child: new Row(
                                               mainAxisSize: MainAxisSize.max,
                                               children: <Widget>[
                                                 new Flexible(
                                                   child: new TextField(
                                                     controller:CompanyController,
                                                     decoration: const InputDecoration(
                                                         hintText: "Enter the Comapany/Organisation/Institution"),
                                                     enabled: !_status,
                                                   ),
                                                 ),
                                               ],
                                             )),
                                         Padding(
                                             padding: EdgeInsets.only(
                                                 left: 25.0, right: 25.0, top: 25.0),
                                             child: new Row(
                                               mainAxisSize: MainAxisSize.max,
                                               children: <Widget>[
                                                 new Column(
                                                   mainAxisAlignment: MainAxisAlignment.start,
                                                   mainAxisSize: MainAxisSize.min,
                                                   children: <Widget>[
                                                     new Text(
                                                       'Your Monthly Income',
                                                       style: TextStyle(
                                                           fontSize: 16.0,
                                                           fontWeight: FontWeight.bold),
                                                     ),
                                                   ],
                                                 ),
                                               ],
                                             )),
                                         Padding(
                                             padding: EdgeInsets.only(
                                                 left: 25.0, right: 25.0, top: 2.0),
                                             child: new Row(
                                               mainAxisSize: MainAxisSize.max,
                                               children: <Widget>[
                                                 new Flexible(
                                                   child: new TextField(
                                                     controller:MonthlyEditingController,
                                                     decoration: const InputDecoration(
                                                         hintText: "Enter Your Monthly Income"),
                                                     enabled: !_status,
                                                   ),
                                                 ),
                                               ],
                                             )),
                                         Padding(
                                             padding: EdgeInsets.only(
                                                 left: 25.0, right: 25.0, top: 25.0),
                                             child: new Row(
                                               mainAxisSize: MainAxisSize.max,
                                               children: <Widget>[
                                                 new Column(
                                                   mainAxisAlignment: MainAxisAlignment.start,
                                                   mainAxisSize: MainAxisSize.min,
                                                   children: <Widget>[
                                                     new Text(
                                                       'Your Annual Income',
                                                       style: TextStyle(
                                                           fontSize: 16.0,
                                                           fontWeight: FontWeight.bold),
                                                     ),
                                                   ],
                                                 ),
                                               ],
                                             )),
                                         Padding(
                                             padding: EdgeInsets.only(
                                                 left: 25.0, right: 25.0, top: 2.0),
                                             child: new Row(
                                               mainAxisSize: MainAxisSize.max,
                                               children: <Widget>[
                                                 new Flexible(
                                                   child: new TextField(
                                                     controller:AnnualEditingController,
                                                     decoration: const InputDecoration(
                                                         hintText: "Enter Your Annual Income"),
                                                     enabled: !_status,
                                                   ),
                                                 ),
                                               ],
                                             )),

                                         Padding(
                                             padding: EdgeInsets.only(
                                                 left: 25.0, right: 25.0, top: 25.0),
                                             child: new Row(
                                               mainAxisSize: MainAxisSize.max,
                                               children: <Widget>[
                                                 new Column(
                                                   mainAxisAlignment: MainAxisAlignment.start,
                                                   mainAxisSize: MainAxisSize.min,
                                                   children: <Widget>[
                                                     new Text(
                                                       'Education Level',
                                                       style: TextStyle(
                                                           fontSize: 16.0,
                                                           fontWeight: FontWeight.bold),
                                                     ),
                                                   ],
                                                 ),
                                               ],
                                             )),

                                         RadioListTile(
                                           title: Text("Post Graduate"),
                                           subtitle: Text("You holds Masters or Phd degree"),
                                           activeColor: Colors.green,
                                           groupValue: selectedRadioTile2,
                                           value: 1,
                                           onChanged: (val){
                                             setSelectedRadioTile2(val);
                                           },
                                         ),
                                         Divider(height: 10, color: Colors.grey[400],),
                                         RadioListTile(
                                           title: Text("Undergraduate"),
                                           subtitle: Text("You holds a Bachelors degree or a diploma"),
                                           activeColor: Colors.green,
                                           groupValue: selectedRadioTile2,
                                           value: 0,
                                           onChanged: (val){
                                             setSelectedRadioTile2(val);
                                             print(selectedRadioTile2);
                                           },
                                         ),
                                         Divider(height: 10, color: Colors.grey[400],),
                                         RadioListTile(
                                           title: Text("Others"),
                                           subtitle: Text("Not one of the above"),
                                           activeColor: Colors.green,
                                           groupValue: selectedRadioTile2,
                                           value: 3,
                                           onChanged: (val){
                                             setSelectedRadioTile2(val);
                                             print(selectedRadioTile2);
                                           },
                                         ),
                                         Divider(height: 10, color: Colors.grey[400],),


                                         !_status ? _getActionButtons() : new Container(),
                                       ],
                                     );
                                   }
                                   else return  Container(
                                       height: 200,
                                       child: Center(child: CircularProgressIndicator(),));
                                },
                              );
                            }
                            else return  Container(
                                height: 200,
                                child: Center(child: CircularProgressIndicator(),));

                          },

                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Save"),
                    textColor: Colors.white,
                    color: Colors.green,
                    onPressed: () {
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Cancel"),
                    textColor: Colors.white,
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }

  Future getImage(String selected) async {
    File image;
    if(selected == "Camera"){
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    }else{
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }

    setState(() {
      _image = image;
    });
  }


}