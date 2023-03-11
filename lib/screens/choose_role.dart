import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/screens/sign_up_client.dart';
import 'package:taxi_app/screens/sign_up_driver.dart';
import 'package:taxi_app/utils/shared_pref.dart';

import 'active_trip_screen.dart';
import 'add_trip_screen.dart';

class ChooseRoleScreen extends StatefulWidget {
  @override
  _ChooseRoleScreenState createState() => _ChooseRoleScreenState();
}

class _ChooseRoleScreenState extends State<ChooseRoleScreen> {
  String role = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.blueAccent,
          ),
        ),
        title: Text(
          "Выберите тип",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            margin: EdgeInsets.only(top: 40.0, bottom: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (role == 'driver') {
                            role = '';
                          } else {
                            role = 'driver';
                          }
                        });
                      },
                      child: Container(
                        child: role == 'driver'
                            ? Container(
                                width: 160,
                                height: 160,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(160.0),
                                  border: Border.all(
                                      color: Colors.blue[900], width: 7),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(160.0),
                                  child: Align(
                                      widthFactor: 1,
                                      alignment: Alignment.bottomCenter,
                                      heightFactor: 1,
                                      child: Image.asset(
                                          'assets/images/driverIcon.png')),
                                ),
                              )
                            : Container(
                                width: 160,
                                height: 160,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(160.0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(160.0),
                                  child: Align(
                                      widthFactor: 1,
                                      alignment: Alignment.bottomCenter,
                                      heightFactor: 1,
                                      child: Image.asset(
                                          'assets/images/driverIcon.png')),
                                ),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text("Водитель"),
                    SizedBox(
                      height: 30.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (role == 'client') {
                            role = '';
                          } else {
                            role = 'client';
                          }
                        });
                      },
                      child: Container(
                        child: role == 'client'
                            ? Container(
                                width: 160,
                                height: 160,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(160.0),
                                    border: Border.all(
                                        color: Colors.blue[900], width: 7)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(160.0),
                                  child: Align(
                                      widthFactor: 1,
                                      alignment: Alignment.bottomCenter,
                                      heightFactor: 1,
                                      child: Image.asset(
                                          'assets/images/clientIcon.png')),
                                ),
                              )
                            : Container(
                                width: 160,
                                height: 160,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(160.0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(160.0),
                                  child: Align(
                                      widthFactor: 1,
                                      alignment: Alignment.bottomCenter,
                                      heightFactor: 1,
                                      child: Image.asset(
                                          'assets/images/clientIcon.png')),
                                ),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text("Пассажир"),
                  ],
                ),
                Container(
                  height: 60.0,
                  margin: EdgeInsets.only(bottom: 30),
                  width: double.infinity,
                  child: RaisedButton(
                    elevation: 0.0,
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: role == '' ? Colors.grey[300] : Colors.blue[800],
                    child: Text(
                      'Выбрать',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                    onPressed: () {
                      if (role == 'driver') {
                        saveRole(role).then((value) => Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => SignUpScreenDriver())));
                      } else if (role == 'client') {
                        saveRole(role).then((value) => Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => SignUpScreenClient())));
                      }
                    },
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
