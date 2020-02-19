import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:mbanking/General/Constants.dart';
import 'package:mbanking/Models/UserLoans.dart';

class LoanDetail extends StatefulWidget {

  UserLoan userLoan;


  LoanDetail(this.userLoan);

  @override
  _LoanDetailState createState() => _LoanDetailState();
}

class _LoanDetailState extends State<LoanDetail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(143, 148, 251, 1),
          title: Text(widget.userLoan.title.toUpperCase()),
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20, top: 8),
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(
                    image: NetworkImage(BASE_URL+"images/project/"+ widget.userLoan.project_image),
                    height: 200,
                    fit: BoxFit.fill,
                  ),
                ),
              ),

            ),

            SizedBox(height: 20,),

            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text("Project Descritpion", style: TextStyle(
                color: Color.fromRGBO(143, 148, 251, 1),
                fontFamily: 'BowlbyOneSC'
              ),),
            ),
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(widget.userLoan.description,
              style: TextStyle(
                fontFamily: 'ptserif',
                fontSize: 16,
                color: Colors.grey[700]
              ),),
            ),

            SizedBox(height: 8,),

            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text("Project Status", style: TextStyle(
                  color: Color.fromRGBO(143, 148, 251, 1),
                  fontFamily: 'BowlbyOneSC'
              ),),
            ),

            Divider(height: 10, color: Colors.grey[400],),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  SizedBox(width: 10,),
                  Text("Payment: "),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: widget.userLoan.paymentstatus == 0 ?
                    Badge(
                      badgeColor: Colors.green,
                      shape: BadgeShape.square,
                      borderRadius: 20,
                      toAnimate: false,
                      badgeContent:
                      Text("Fully Paid", style: TextStyle(color: Colors.white,fontFamily: 'YeonSung',fontSize: 12)),
                    )
                        : Badge(
                      badgeColor: Colors.red,
                      shape: BadgeShape.square,
                      borderRadius: 20,
                      toAnimate: false,
                      badgeContent:
                      Text("Pending Payment", style: TextStyle(color: Colors.white,fontFamily: 'YeonSung',fontSize: 12)),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Text("Funding: "),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: widget.userLoan.status == 0 ?
                    Badge(
                      badgeColor: Colors.green,
                      shape: BadgeShape.square,
                      borderRadius: 20,
                      toAnimate: false,
                      badgeContent:
                      Text("Fully Funded", style: TextStyle(color: Colors.white,fontFamily: 'YeonSung',fontSize: 12)),
                    )
                        : Badge(
                      badgeColor: Colors.red,
                      shape: BadgeShape.square,
                      borderRadius: 20,
                      toAnimate: false,
                      badgeContent:
                      Text("Pending Funding", style: TextStyle(color: Colors.white,fontFamily: 'YeonSung',fontSize: 12)),
                    ),
                  )
                ],
              ),
            ),
            Divider(height: 10, color: Colors.grey[400],),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  SizedBox(width: 10,),
                  Text("Request Amnt: "),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                    Badge(
                      badgeColor: Colors.blue,
                      shape: BadgeShape.square,
                      borderRadius: 20,
                      toAnimate: false,
                      badgeContent:
                      Text("KES "+(widget.userLoan.amountBorrowed).toString(), style: TextStyle(color: Colors.white,fontFamily: 'YeonSung',fontSize: 12)),
                    )

                  ),
                  SizedBox(width: 10,),
                  Text("Funded: "),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: widget.userLoan.status == 0 ?
                    Badge(
                      badgeColor: Colors.green,
                      shape: BadgeShape.square,
                      borderRadius: 20,
                      toAnimate: false,
                      badgeContent:
                      Text((widget.userLoan.amountBorrowed-widget.userLoan.balance).toString(), style: TextStyle(color: Colors.white,fontFamily: 'YeonSung',fontSize: 12)),
                    )
                        : Badge(
                      badgeColor: Colors.red,
                      shape: BadgeShape.square,
                      borderRadius: 20,
                      toAnimate: false,
                      badgeContent:
                      Text("Pending Funding", style: TextStyle(color: Colors.white,fontFamily: 'YeonSung',fontSize: 12)),
                    ),
                  )
                ],
              ),
            ),
            Divider(height: 10, color: Colors.grey[400],),

          ],
        ),
      ),
    );
  }
}
