import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/utils/shared_pref.dart';

import 'choose_role.dart';

class SignInScreen extends StatefulWidget {
  final FirebaseApp app;

  SignInScreen({this.app});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final databaseReference = FirebaseDatabase.instance.reference();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Вход в систему",
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
            margin: EdgeInsets.only(top: 120, bottom: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/images/car_top.png'),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 50.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.grey[100]),
                      child: Row(
                        children: [
                          Text(
                            '+99 8',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            width: 0.0,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: phoneNumberController,
                              style: TextStyle(fontSize: 16, letterSpacing: 1),
                              decoration: InputDecoration(
                                hintText: "номер телефона",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide.none),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "или",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          padding: EdgeInsets.all(15.0),
                          child: Image.asset('assets/images/google.png'),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          padding: EdgeInsets.all(15.0),
                          child: Image.asset('assets/images/facebook.png'),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          padding: EdgeInsets.all(15.0),
                          child: Image.asset('assets/images/twitter.png'),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  height: 60,
                  margin: EdgeInsets.only(bottom: 90),
                  width: double.infinity,
                  child: RaisedButton(
                    elevation: 2.0,
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.blue[800],
                    child: Text(
                      'Войти',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                    onPressed: () {
                      createData();
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

  void createData() {
    if (phoneNumberController.text == "") {
      print("phone number is empty");
      return;
    }

    var check = false;
    databaseReference
        .child('register_phone')
        .once()
        .then((DataSnapshot snapshot) {
      var keys = snapshot.value.keys;
      var data = snapshot.value;
      for (var key in keys) {
        if ("+998${phoneNumberController.text}" == data[key]['phoneNumber']) {
          check = true;
        }
      }
      if (check) {
        print("this phone number already exist");
        return;
      }
      databaseReference.child('register_phone').push().set(
          {'phoneNumber': "+998${phoneNumberController.text}"}).then((value) {
        savePhoneNumber("+998${phoneNumberController.text}").then((value) =>
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => ChooseRoleScreen())));
      });

      print("phone number added");
    });
  }
}
