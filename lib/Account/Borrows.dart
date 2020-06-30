import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbanking/Borrows/LoanDetail.dart';
import 'package:mbanking/General/Constants.dart';
import 'package:mbanking/Models/UserLoans.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Borrows extends StatefulWidget {
  @override
  _BorrowsState createState() => _BorrowsState();
}

class _BorrowsState extends State<Borrows> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();
    sharedPreferences.then((value) => {
      print(value.get("token"))
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(143, 148, 251, 1),
          title: Text("My Loans",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'ptserif',
          ),),
          elevation: 0.00,
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: UserLoan().fetchUserLoans(),
          builder: (context, snapshot){
            if(snapshot.hasError){
              print(snapshot.error);
            }

            if (snapshot.hasData) {
               return ListView.builder(
                   itemCount: snapshot.data.length,
                   itemBuilder: (context, index){
                     return Column(
                       children: <Widget>[
                         ListTile(
                           leading: CircleAvatar(
                             backgroundImage: NetworkImage(BASE_URL+"images/project/"+snapshot.data[index].project_image),
                           ),
                           title:Text(snapshot.data[index].title,
                           style: TextStyle(
                             color: Color.fromRGBO(143, 148, 251, 1),
                             fontFamily: 'BowlbyOneSC'
                           ),),
                            subtitle: Text(snapshot.data[index].description),
                           onTap: (){
                             Navigator.push(context,MaterialPageRoute(builder: (context)=>LoanDetail(snapshot.data[index])));
                           },

                         ),
                         Divider(height: 10,color: Colors.grey[500],)
                       ],
                     );
                   });
            }
            else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
