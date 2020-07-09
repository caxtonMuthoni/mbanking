import 'package:flutter/material.dart';
import 'package:mbanking/Account/account_home.dart';
import 'package:mbanking/OtherAccounts/my_accounts.dart';
import 'package:mbanking/Account/open_account.dart';
import 'package:mbanking/General/constants.dart';
import 'package:mbanking/General/profile.dart';
import 'package:mbanking/General/about_us.dart';
import 'package:mbanking/Home/home.dart';
import 'package:mbanking/Models/profile.dart';
import 'package:mbanking/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: <Widget>[
                FutureBuilder(
                  future: Profile.fetchProfile(context),
                  builder: (context,snapshotP){
                    if(snapshotP.hasData){
                      return GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
                        },
                        child: CircleAvatar(
                          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                          backgroundImage: NetworkImage(BASE_URL+"images/avatar/"+snapshotP.data.Avatar),
                          radius: 50,
                        ),
                      );
                    }else{
                      return CircularProgressIndicator();
                    }
                  },
                ),
                Text('M~Banking',
                style: TextStyle(
                  fontFamily: 'BowlbyOneSC',
                  fontSize: 25,
                  color: Colors.white,
                ),),
              ],
            ),
            decoration: BoxDecoration(
              color: Color.fromRGBO(143, 148, 251, 1),
            ),
          ),

          ListTile(
            leading: Icon(Icons.supervised_user_circle,
              color: Color.fromRGBO(143, 148, 251, 1),),
            title: Text('Update profile',
              style: TextStyle(
                color: Color.fromRGBO(143, 148, 251, 1),
                fontFamily: 'ptserif',
                fontSize: 15,
              ),),
            subtitle: Text("update my profile",
              style: TextStyle(
                  fontFamily: 'YeonSung',
                  color: Colors.grey[400]
              ),),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.open_with,
            color: Color.fromRGBO(143, 148, 251, 1),),
            title: Text('Open Account',
              style: TextStyle(
                  color: Color.fromRGBO(143, 148, 251, 1),
                  fontFamily: 'ptserif',
                  fontSize: 15,
              ),),
            subtitle: Text("Create a new account here",
            style: TextStyle(
              fontFamily: 'YeonSung',
              color: Colors.grey[400]
            ),),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>OpenAccount()));
            },
          ),
          SizedBox(height: 1,
          child: Container(
            color: Colors.grey[200],
          ),
          ),
          ListTile(
            leading: Icon(Icons.list,color: Color.fromRGBO(143, 148, 251, 1),),
            title: Text('My Accounts',
            style: TextStyle(
              color: Color.fromRGBO(143, 148, 251, 1),
              fontFamily: 'ptserif'
            ),),
            subtitle: Text("View your registered accounts.",
              style: TextStyle(
                  fontFamily: 'YeonSung',
                  color: Colors.grey[400],
              ),),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MyAccounts()));
            },
          ),

          SizedBox(height: 1,
            child: Container(
              color: Colors.grey[200],
            ),
          ),

          ListTile(
            leading: Icon(Icons.g_translate,color: Color.fromRGBO(143, 148, 251, 1),),
            title: Text('About us',
              style: TextStyle(
                  color: Color.fromRGBO(143, 148, 251, 1),
                  fontFamily: 'ptserif'
              ),),
            subtitle: Text("Who are we ????",
              style: TextStyle(
                  fontFamily: 'YeonSung',
                  color: Colors.grey[400],
              ),),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutUs()));
            },
          ),

          SizedBox(height: 1,
            child: Container(
              color: Colors.grey[200],
            ),
          ),

          ListTile(
            leading: Icon(Icons.phone,color: Color.fromRGBO(143, 148, 251, 1),),
            title: Text('Contact',
              style: TextStyle(
                  color: Color.fromRGBO(143, 148, 251, 1),
                  fontFamily: 'ptserif'
              ),),
            subtitle: Text("Get in touch with our staff",
              style: TextStyle(
                  fontFamily: 'YeonSung',
                  color: Colors.grey[400],
              ),),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),

          SizedBox(height: 1,
            child: Container(
              color: Colors.grey[200],
            ),
          ),

          ListTile(
            leading: Icon(Icons.share,color: Color.fromRGBO(143, 148, 251, 1),),
            title: Text('Share',
              style: TextStyle(
                  color: Color.fromRGBO(143, 148, 251, 1),
                  fontFamily: 'ptserif'
              ),),
            subtitle: Text("Share the app with friends",
              style: TextStyle(
                  fontFamily: 'YeonSung',
                  color: Colors.grey[400],
              ),),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),

          SizedBox(height: 1,
            child: Container(
              color: Colors.grey[200],
            ),
          ),

          ListTile(
            leading: Icon(Icons.exit_to_app,color: Colors.red[300],),
            title: Text('Logout',
            style: TextStyle(
              color: Colors.red[200],
              fontSize: 18,
              fontFamily: 'ptserif',
            ),),
            subtitle: Text("Exit the app completely.",
              style: TextStyle(
                  fontFamily: 'YeonSung',
                  color: Colors.redAccent[100],
              ),),
            onTap: () async {

              SharedPreferences sharedPref = await SharedPreferences.getInstance();
              sharedPref.clear();
              sharedPref.commit();

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeMain()));
            },
          ),
        ],
      ),
    );
  }
}
