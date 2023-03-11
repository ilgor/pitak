import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/screens/add_trip_screen.dart';
import 'package:taxi_app/utils/shared_pref.dart';

import 'active_trip_screen.dart';

class SignUpScreenCar extends StatefulWidget {
  @override
  _SignUpScreenCarState createState() => _SignUpScreenCarState();
}

class _SignUpScreenCarState extends State<SignUpScreenCar> {
  final ref = FirebaseDatabase.instance.reference();

  TextEditingController carNumberController = TextEditingController();
  TextEditingController typeCarController = TextEditingController();

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
          "Регистрация",
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
            margin: EdgeInsets.only(top: 40.0, bottom: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(160.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(160.0),
                        child: Align(
                            alignment: Alignment.center,
                            child:
                                Image.asset('assets/images/car_left_side.png')),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      "Водитель",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    TextFormField(
                      controller: carNumberController,
                      decoration: InputDecoration(
                          filled: true,
                          hintText: "Номер авто",
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide.none)),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: typeCarController,
                      decoration: InputDecoration(
                          // suffixIcon: Icon(Icons.arrow_forward_ios),
                          filled: true,
                          hintText: "Марка",
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide.none)),
                    ),
                  ],
                ),
                Container(
                  height: 60.0,
                  margin: EdgeInsets.only(bottom: 10),
                  width: double.infinity,
                  child: RaisedButton(
                    elevation: 0.0,
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.blue[800],
                    child: Text(
                      'Продолжить',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                    onPressed: () {
                      if (carNumberController.text != '' &&
                          typeCarController.text != '') {
                        ref.child('register_car').push().set({
                          'car_number': carNumberController.text,
                          'type_car': typeCarController.text
                        }).then((value) {
                          saveCarNumber(carNumberController.text).then((value) {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => AddTripScreen()));
                          });
                        });
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
