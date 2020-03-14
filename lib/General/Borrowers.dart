import 'package:badges/badges.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mbanking/Borrows/BorrowDetail.dart';
import 'package:mbanking/General/Constants.dart';
import 'package:mbanking/Models/Borrow.dart';
import 'package:http/http.dart' as http;
import 'package:mbanking/Models/Profile.dart';
import 'package:mbanking/Models/User.dart';

class BorrowsList extends StatelessWidget {
  List<Borrow> borrows;

  BorrowsList({this.borrows});


  @override
  Widget build(BuildContext context) {
    //checkLoginStatus(context);
    return ListView.builder(
      itemBuilder: (context,index){
      return Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              Text(borrows[index].title.toUpperCase(),
                style: TextStyle(
                    fontFamily: 'BowlbyOneSC',
                    color: Color.fromRGBO(143, 148, 251, 1)
                ),),
              Image(
                image: NetworkImage(BASE_URL+'images/project/'+borrows[index].project_image),
                fit: BoxFit.fill,
                width: 100,
                height: 200,
              ),
              SizedBox(height: 10,),

              FutureBuilder(
                  future: User.fetchUser(
                     client: http.Client(),
                     id:  borrows[index].userId,
                     context:  context),
                  builder: (context,snapshot){
                    if(snapshot.hasError){
                      print(snapshot.error);
                    }
                    return snapshot.hasData ?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        FutureBuilder(
                          future: Profile.fetchProfile(context),
                          builder: (context,snapshotProfile){
                              if(snapshotProfile.hasError){
                              print(snapshotProfile.error);
                              }
                              return snapshotProfile.hasData ?
                              CircleAvatar(
                                backgroundImage: NetworkImage(BASE_URL+"images/avatar/"+snapshotProfile.data.Avatar.toString()),
                                radius: 15,
                              ) :
                              Center(
                                child: CircularProgressIndicator(),);

                          },
                        ),
                        SizedBox(width: 10,),
                        Text(snapshot.data.FirstName,
                        style: TextStyle(
                          fontSize:15,
                          fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(width: 2,),
                        Text(snapshot.data.MiddleName,
                        style: TextStyle(
                          fontSize:15,
                          fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(width: 2,),

                        Text(snapshot.data.LastName,
                        style: TextStyle(
                          fontSize:15,
                          fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(width: 20,),
                        GestureDetector(
                          onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>BorrowDetail(
                                borrow:borrows[index],
                            user:snapshot.data)));
                         },
                          child: Badge(
                            badgeColor: Colors.blue,
                            shape: BadgeShape.square,
                            borderRadius: 20,
                            toAnimate: false,
                            badgeContent:
                            Text('View loan Details', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ) :
                    Center(child: CircularProgressIndicator(),);

              }),

              Text(StringUtils.capitalize(borrows[index].description),
              style: TextStyle(
                color: Colors.black87,
                fontFamily: 'ptserif',
                fontSize: 16,

              ),),
              SizedBox(height: 10,),
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
                    Text( (borrows[index].amountBorrowed).toString(), style: TextStyle(color: Colors.white)),
                  ),
                  Text("Funded:"),
                  Badge(
                    badgeColor: Colors.blue,
                    shape: BadgeShape.square,
                    borderRadius: 20,
                    toAnimate: false,
                    badgeContent:
                    borrows[index].balance == 0 ? Text("Fully Funded",style: TextStyle(color: Colors.white)) :
                    Text(( borrows[index].amountBorrowed-borrows[index].balance ).toString(), style: TextStyle(color: Colors.white)),
                  ),
                  Text("Balance:"),
                  Badge(
                    badgeColor: Colors.red,
                    shape: BadgeShape.square,
                    borderRadius: 20,
                    toAnimate: false,
                    badgeContent:
                    Text(borrows[index].balance.toString(), style: TextStyle(color: Colors.white)),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
    itemCount: borrows.length,);
  }
}


class Borrowers extends StatefulWidget {
  @override
  _BorrowersState createState() => _BorrowersState();
}

class _BorrowersState extends State<Borrowers> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[400],
        appBar: AppBar(
          title: Text("Borrowers",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'ptserif',
          ),),
          backgroundColor: Color.fromRGBO(143, 148, 251, 1),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: Borrow().fetchBorrows(http.Client(),context),
          builder: (context,snapshot1){
            if(snapshot1.hasError){
              print(snapshot1.error);
            }
            return snapshot1.hasData ? BorrowsList(borrows:snapshot1.data) : Center(child: CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    checkLoginStatus(context);
  }
}
