import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/utils/shared_pref.dart';

import 'active_trip_screen.dart';
import 'add_trip_screen.dart';
import 'choose_role.dart';
import 'sign_in.dart';
import 'sign_up_driver.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          // child: Stack(
          //   children: <Widget>[
          //     Align(
          //       alignment: Alignment.center,
          //       child: Image.asset('images/cooking1.png',
          //           height: MediaQuery.of(context).size.height / 2),
          //     ),
          //     Align(
          //       alignment: Alignment.bottomCenter,
          //       child: Padding(
          //         padding: EdgeInsets.only(bottom: margin_padding_24),
          //         child: Container(
          //           height: 50,
          //           child: Image.asset('images/base_logo.png'),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          ),
    );
  }

  void initState() {

    super.initState();
    startTime();
  }

  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, route);
  }

  route() {
    getPhoneNumber().then((value) {
      print("SplashScreen ${value}");
      switch (value) {
        case 'xxx':
          {
            Navigator.pushReplacement(context,
                CupertinoPageRoute(builder: (context) => SignInScreen()));
            break;
          }
        default:
          {
            getRole().then((value) {
              print("SplashScreen ${value}");
              switch (value) {
                case 'driver':
                  {
                    Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => AddTripScreen()));
                    break;
                  }
                case 'client':
                  {
                    Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => ActiveTripScreen()));
                    break;
                  }
              }
            });
          }
      }
    });
  }
}
