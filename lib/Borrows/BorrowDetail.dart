import 'package:badges/badges.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:mbanking/Borrows/lend.dart';
import 'package:mbanking/General/Constants.dart';
import 'package:mbanking/Models/Borrow.dart';
import 'package:mbanking/Models/Profile.dart';
import 'package:mbanking/Models/User.dart';

class BorrowDetail extends StatefulWidget {

Borrow borrow;
User user;
Profile profile;


BorrowDetail({this.borrow, this.user,this.profile});

@override
  _BorrowDetailState createState() => _BorrowDetailState();
}


class _BorrowDetailState extends State<BorrowDetail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.borrow.title,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'BowlbyOneSC'
          ),),
          backgroundColor: Color.fromRGBO(143, 148, 251, 1),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Image(
                    image: NetworkImage(BASE_URL+'images/project/'+widget.borrow.project_image),
                    fit: BoxFit.fill,
                    height: 250,
                  ),
                  Text('Project Description',
                  style: TextStyle(
                    color: Color.fromRGBO(143, 148, 251, 1),
                    fontFamily: 'BowlbyOneSC'
                  ),),
                  SizedBox(height: 7,),
                  Row(
                    children: <Widget>[
                      Text("Posted at : "+ widget.borrow.created_at,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontFamily: 'YeonSung',
                      ),),
                    ],
                  ),
                  Text(widget.borrow.description,
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'ptserif',
                    fontSize: 15,
                  ),),
                  SizedBox(height: 8,),
                  Divider(height: 20,),
                  Text('Project Funding Status',
                    style: TextStyle(
                        color: Color.fromRGBO(143, 148, 251, 1),
                        fontFamily: 'BowlbyOneSC'
                    ),),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Amount:"),
                      Badge(
                        badgeColor: Colors.green,
                        shape: BadgeShape.square,
                        borderRadius: 20,
                        toAnimate: false,
                        badgeContent:
                        Text(widget.borrow.amountBorrowed.toString(), style: TextStyle(color: Colors.white)),
                      ),
                      Text("Funded:"),
                      Badge(
                        badgeColor: Colors.blue,
                        shape: BadgeShape.square,
                        borderRadius: 20,
                        toAnimate: false,
                        badgeContent:
                        widget.borrow.balance == 0 ? Text("Fully Funded",style: TextStyle(color: Colors.white)):Text(( widget.borrow.amountBorrowed - widget.borrow.balance ).toString(), style: TextStyle(color: Colors.white)),
                      ),
                      Text("Balance:"),
                      Badge(
                        badgeColor: Colors.red,
                        shape: BadgeShape.square,
                        borderRadius: 20,
                        toAnimate: false,
                        badgeContent:
                        Text(widget.borrow.balance.toString(), style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                  SizedBox(height: 12,),
                  Divider(height: 20,),
                  Text('About The Owner',
                    style: TextStyle(
                        color: Color.fromRGBO(143, 148, 251, 1),
                        fontFamily: 'BowlbyOneSC'
                    ),),
                  FutureBuilder(
                    future: Profile.fetchProfile(context),
                    builder: (context,snapshotProfile){
                      if(snapshotProfile.hasError){
                        print(snapshotProfile.error);
                      }
                      return snapshotProfile.hasData ?
                      Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage: NetworkImage(BASE_URL+"images/avatar/"+snapshotProfile.data.Avatar.toString()),
                                radius: 15,
                              ),
                              SizedBox(width: 10,),
                              Text(widget.user.FirstName,
                                style: TextStyle(
                                  fontSize:15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue
                                ),),
                              SizedBox(width: 2,),
                              Text(widget.user.MiddleName,
                                style: TextStyle(
                                  fontSize:15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),),
                              SizedBox(width: 2,),

                              Text(widget.user.LastName,
                                style: TextStyle(
                                  fontSize:15,
                                  fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                ),),
                            ],
                          ),
                      SizedBox(height: 8,),
                      Row(
                        children: <Widget>[
                          Text('BIO',
                          style: TextStyle(
                            color: Colors.blue[400],
                            fontWeight: FontWeight.bold
                          ),),
                        ],
                      ),
                      Text(snapshotProfile.data.Bio,
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'ptserif'
                      ),),

                          Row(
                            children: <Widget>[
                              Text('More Info',
                                style: TextStyle(
                                    color: Colors.blue[400],
                                    fontWeight: FontWeight.bold
                                ),),
                            ],
                          ),
                      SizedBox(height: 8,),
                      Table(

                      border: TableBorder.all(
                      color: Colors.black26, width: 1,
                          style: BorderStyle.solid),
                      children: [
                      TableRow(children: [
                      TableCell(child: Center(child: Text('#',style: TextStyle(fontWeight: FontWeight.bold),))),
                      TableCell(
                      child: Center(child: Text('Title',style: TextStyle(fontWeight: FontWeight.bold),)),
                      ),
                      TableCell(child: Center(child: Text('Description',style: TextStyle(fontWeight: FontWeight.bold),))),
                      ]),
                      TableRow(
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            ),
                          children: [
                      TableCell(
                      child: Center(child: Text('1')),
                      verticalAlignment: TableCellVerticalAlignment.bottom,
                      ),
                      TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Center(child: Text('Employment Status')),
                      ),
                      TableCell(
                      child: Center(
                      child: snapshotProfile.data.EmploymentStatus == 1 ?
                      Badge(
                        badgeColor: Colors.green,
                        shape: BadgeShape.square,
                        borderRadius: 20,
                        toAnimate: false,
                        badgeContent:
                        Text("Employed", style: TextStyle(color: Colors.white)),
                      ) :
                      Badge(
                        badgeColor: Colors.red,
                        shape: BadgeShape.square,
                        borderRadius: 20,
                        toAnimate: false,
                        badgeContent:
                        Text("Unemployed", style: TextStyle(color: Colors.white)),
                      ),
                      )),

                      ]),
                      TableRow(children: [
                      TableCell(child: Center(child: Text('2'))),

                      TableCell(child: Center(child: Text('Occupation'))),
                      TableCell(child: Center(child: Text(snapshotProfile.data.Occupation))),
                      ]),
                      TableRow(children: [
                      TableCell(
                      child: Center(child: Text('3')),
                      ),
                      TableCell(child: Center(child: Text('Company'))),
                      TableCell(child: Center(child: Text(snapshotProfile.data.Company))),
                      ]),
                        TableRow(children: [
                          TableCell(child: Center(child: Text('4'))),

                          TableCell(child: Center(child: Text('AnualIncome'))),
                          TableCell(child: Center(child: Text(snapshotProfile.data.AnualIncome))),
                        ]),
                        TableRow(children: [
                          TableCell(
                            child: Center(child: Text('5')),
                          ),
                          TableCell(child: Center(child: Text('MonthlyIncome'))),
                          TableCell(child: Center(child: Text(snapshotProfile.data.MonthlyIncome))),
                        ]),
                        TableRow(children: [
                          TableCell(child: Center(child: Text('6'))),

                          TableCell(child: Center(child: Text('Enducation Level'))),
                          TableCell(child: Center(child: Text(snapshotProfile.data.EducationLevel))),
                        ]),

                      ],
                      )

                      ]
                      )
                     :
                      Center(
                        child: CircularProgressIndicator(),);

                    },
                  ),
                  SizedBox(height: 25,),

                  widget.borrow.balance == 0 ? Container() : RaisedButton(
                    color: Colors.blue[400],
                    child: Text("Fund Loan",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'ptserif'
                    ),),
                    onPressed: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>LendNow(
                         borrowerId: widget.user.id.toString(),
                         borrowId: widget.borrow.id.toString(),
                       )));
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
