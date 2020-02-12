import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mbanking/login/Otp.dart';

class PersonalInfo extends StatefulWidget {
  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:Color.fromRGBO(143, 148, 251, 1),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromRGBO(143, 148, 251, 1),
          elevation: 0.00,
          title: Text("Personal Info",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(height: 15,),
            CircleAvatar(
              radius: 45.0,
             child: Image(
               width: 60.0,
               height: 60.0,
               image: AssetImage('assets/images/register.png'),
             ) ,
              backgroundColor: Colors.white60,
            ),
            Text("Register your personal Info",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
                fontFamily: 'YeonSung'
            ),),
            SizedBox(height: 20.0,),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(78.0),
                    topRight: Radius.circular(10.0)
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 22,right: 8,top: 20,bottom: 20),
                  child: ListView(
                    children: <Widget>[
                      Text("About Me",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(143, 148, 251, 1),
                        fontFamily: 'BowlbyOneSC',
                        fontSize: 18,
                      ),),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(143, 143, 251, 1)
                              )
                          ),
                          labelText: "Enter your first name",
                          hintText: "First Name",
                          hintStyle: TextStyle(color: Colors.grey[400],
                          ),
                          fillColor: Colors.green,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(

                            ),
                          ),
                        ),
                      ),


                      SizedBox(height: 10,),

                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Color.fromRGBO(143, 143, 251, 1)
                            )
                          ),
                          labelText: "Enter your middle name",
                          hintText: "Middle Name eg.githinji",
                          hintStyle: TextStyle(color: Colors.grey[400],
                          ),
                          fillColor: Colors.green,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(

                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 10,),

                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(143, 143, 251, 1)
                              )
                          ),
                          labelText: "Enter your Last Name",
                          hintText: "Last Name",
                          hintStyle: TextStyle(color: Colors.grey[400],
                          ),
                          fillColor: Colors.green,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(

                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 10,),
                      Text("Contact Info",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(143, 148, 251, 1),
                          fontFamily: 'BowlbyOneSC',
                          fontSize: 18,
                        ),),

                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(143, 143, 251, 1)
                              )
                          ),
                          labelText: "Enter your Email Address",
                          hintText: "Email Address eg.example@gmail.com",
                          hintStyle: TextStyle(color: Colors.grey[400],
                          ),
                          fillColor: Colors.green,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(

                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 10,),

                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(143, 143, 251, 1)
                              )
                          ),
                          labelText: "Enter your Phone Number",
                          hintText: "Phone Number eg. 0712345678",
                          hintStyle: TextStyle(color: Colors.grey[400],
                          ),
                          fillColor: Colors.green,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(

                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 10,),

                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(143, 143, 251, 1)
                              )
                          ),
                          labelText: "Enter your city",
                          hintText: "City eg. Nairobi",
                          hintStyle: TextStyle(color: Colors.grey[400],
                          ),
                          fillColor: Colors.green,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(

                            ),
                          ),
                        ),
                      ),


                      SizedBox(height: 10,),

                      Text("Security Info",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(143, 148, 251, 1),
                          fontFamily: 'BowlbyOneSC',
                          fontSize: 18,
                        ),),

                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(143, 143, 251, 1)
                              )
                          ),
                          labelText: "Enter your National ID",
                          hintText: "National ID",
                          hintStyle: TextStyle(color: Colors.grey[400],
                          ),
                          fillColor: Colors.green,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(

                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 10,),


                      TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(143, 143, 251, 1)
                              )
                          ),
                          labelText: "Enter your Password",
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.grey[400],
                          ),
                          fillColor: Colors.green,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(

                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 25,),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.all(Radius.circular(50.0))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Continue',
                            style: TextStyle(
                              color: Colors.blue,
                              fontFamily: 'YeonSung',
                              fontSize: 16,
                            ),),
                            IconButton(
                              iconSize: 30,
                                icon:Icon(
                                    Icons.arrow_forward,
                                    color: Colors.blue,
                                ) ,
                                onPressed: (){


                                Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPVerification()));

                            }),
                          ],
                        ),
                      )


                    ],
                  ),
                ),
              ),
            ),
          ],

        ),
      ),
    );
  }
}
