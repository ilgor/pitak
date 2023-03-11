import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/utils/always_disable_focus_node.dart';
import 'package:taxi_app/utils/shared_pref.dart';

import 'active_trip_screen.dart';

class SignUpScreenClient extends StatefulWidget {
  @override
  _SignUpScreenClientState createState() => _SignUpScreenClientState();
}

class _SignUpScreenClientState extends State<SignUpScreenClient> {
  final ref = FirebaseDatabase.instance.reference();

  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  String genderText = '';
  bool checkBoxMaleValue = false;
  bool checkBoxFemaleValue = false;

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
            margin: EdgeInsets.only(top: 40.0, bottom: 20),
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
                            widthFactor: 1,
                            alignment: Alignment.bottomCenter,
                            heightFactor: 1,
                            child: Image.asset('assets/images/clientIcon.png')),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      "Пассажир",
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
                      controller: nameController,
                      decoration: InputDecoration(
                          filled: true,
                          hintText: "Имя Фамилия",
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide.none)),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: genderController,
                      focusNode: AlwaysDisabledFocusNode(),
                      onTap: () {
                        displayBottomSheet(context);
                      },
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.arrow_forward_ios),
                          filled: true,
                          hintText: "Пол",
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide.none)),
                    ),
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
                      if (nameController.text != '' && genderText != '') {
                        ref.child('register_client').push().set({
                          'name': nameController.text,
                          'gender': genderText
                        }).then((value) {
                          saveName(nameController.text).then((value) =>
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          ActiveTripScreen())));
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

  void displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState
                /*You can rename this!*/) {
              return Container(
                height: 250,
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      width: 45,
                      height: 5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.grey[300]),
                    ),
                    Container(
                      alignment: AlignmentDirectional.centerStart,
                      margin: EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        "Выберите ваш пол:",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      alignment: AlignmentDirectional.centerStart,
                      margin: EdgeInsets.only(bottom: 20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Мужской",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                          ),
                          Checkbox(
                              value: checkBoxMaleValue,
                              onChanged: (bool value) {
                                setState(() {
                                  if (genderText == '') {
                                    checkBoxMaleValue = !checkBoxMaleValue;
                                  } else {
                                    checkBoxMaleValue = !checkBoxMaleValue;
                                    checkBoxFemaleValue = !checkBoxFemaleValue;
                                  }
                                  if (value) {
                                    genderText = 'male';
                                    genderController.text = 'Мужской';
                                  } else {
                                    genderText = '';
                                    genderController.text = '';
                                  }
                                });
                              }),
                        ],
                      ),
                    ),
                    Container(
                      alignment: AlignmentDirectional.centerStart,
                      margin: EdgeInsets.only(bottom: 20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Женский",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                          ),
                          Checkbox(
                              value: checkBoxFemaleValue,
                              onChanged: (bool value) {
                                setState(() {
                                  if (genderText == '') {
                                    checkBoxMaleValue = !checkBoxMaleValue;
                                  } else {
                                    checkBoxMaleValue = !checkBoxMaleValue;
                                    checkBoxFemaleValue = !checkBoxFemaleValue;
                                  }
                                  if (value) {
                                    genderText = 'female';
                                    genderController.text = 'Женский';
                                  } else {
                                    genderText = '';
                                    genderController.text = '';
                                  }
                                });
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );
  }
}
