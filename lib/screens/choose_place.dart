import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/blocs/trip_detail_bloc.dart';
import 'package:taxi_app/blocs/trip_list_bloc.dart';
import 'package:taxi_app/database/database_helper.dart';
import 'package:taxi_app/network/response/trip_detail_response.dart';

class ChoosePlaceScreen extends StatefulWidget {
  String carNumber;
  String name;

  ChoosePlaceScreen(this.carNumber, this.name);

  @override
  _ChoosePlaceScreenState createState() => _ChoosePlaceScreenState();
}

class _ChoosePlaceScreenState extends State<ChoosePlaceScreen> {
  DatabaseHelper dbHelper = DatabaseHelper();
  final ref = FirebaseDatabase.instance.reference();
  TripListBloc tripListBloc = TripListBloc();
  TripDetailBloc tripDetailBloc = TripDetailBloc();

  TripDetailResponse tripData = TripDetailResponse();
  TripDetailResponse tripDetailData;

  var refKey;
  var data;

  var index = "";
  bool isExpanded = false;

  @override
  void initState() {
    dbHelper.getTripDetail(widget.carNumber).then((value) {
      tripDetailBloc.mySink.add(value);
    });
    dbHelper.getTripDetailListener(widget.carNumber);
    super.initState();
  }

  @override
  void dispose() {
    tripListBloc.dispose();
    tripDetailBloc.dispose();
    dbHelper.getTripDetailListenerStop();
    super.dispose();
  }

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
          "Проверка",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.delta.dy < -5) {
            //Swipe up
            displayBottomSheet(context);
          }
        },
        child: StreamBuilder<TripDetailResponse>(
            stream: tripDetailBloc.myStream,
            builder: (context, snapshot) {
              tripData = snapshot.data;
              return tripData != null
                  ? Container(
                      color: Colors.white,
                      child: Stack(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(vertical: 40.0),
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Stack(
                              children: [
                                Image.asset('assets/images/car_top_big.png'),
                                Positioned(
                                  bottom: 250,
                                  left: 30,
                                  child: Container(
                                    width: 69,
                                    height: 69,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        border: Border.all(
                                            width: 5, color: Colors.grey[400])),
                                    child: Icon(
                                      Icons.lock,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 250,
                                  right: 30,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (snapshot.data.place1 == '') {
                                        setState(() {
                                          displayBottomSheet(context);
                                          isExpanded = !isExpanded;
                                          if (index == "1") {
                                            index = "";
                                          } else {
                                            index = "1";
                                          }
                                        });
                                      }
                                    },
                                    child: Container(
                                      child: index == "1"
                                          ? Container(
                                              width: 69,
                                              height: 69,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    195, 212, 255, 1),
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                border: Border.all(
                                                    width: 5,
                                                    color: Colors.blue[800]),
                                              ),
                                              child: SizedBox(
                                                height: 30.0,
                                                width: 30.0,
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  child: Icon(
                                                    Icons.check,
                                                    size: 30.0,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              width: 69,
                                              height: 69,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color:
                                                    snapshot.data.place1 != ''
                                                        ? Colors.grey[300]
                                                        : Color.fromRGBO(
                                                            195, 212, 255, 1),
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                border: Border.all(
                                                    width: 5,
                                                    color:
                                                        snapshot.data.place1 !=
                                                                ''
                                                            ? Colors.grey[400]
                                                            : Colors.blue[800]),
                                              ),
                                              child: Text(
                                                "1",
                                                style: TextStyle(
                                                    color:
                                                        snapshot.data.place1 !=
                                                                ''
                                                            ? Colors.grey[400]
                                                            : Colors.blue[800],
                                                    fontSize: 38),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 120,
                                  left: 30,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (snapshot.data.place2 == '') {
                                        setState(() {
                                          displayBottomSheet(context);
                                          isExpanded = !isExpanded;
                                          if (index == "2") {
                                            index = "";
                                          } else {
                                            index = "2";
                                          }
                                        });
                                      }
                                    },
                                    child: Container(
                                      child: index == "2"
                                          ? Container(
                                              width: 69,
                                              height: 69,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    195, 212, 255, 1),
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                border: Border.all(
                                                    width: 5,
                                                    color: Colors.blue[800]),
                                              ),
                                              child: SizedBox(
                                                height: 30.0,
                                                width: 30.0,
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  child: Icon(
                                                    Icons.check,
                                                    size: 30.0,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              width: 69,
                                              height: 69,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color:
                                                    snapshot.data.place2 != ''
                                                        ? Colors.grey[300]
                                                        : Color.fromRGBO(
                                                            195, 212, 255, 1),
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                border: Border.all(
                                                    width: 5,
                                                    color:
                                                        snapshot.data.place2 !=
                                                                ''
                                                            ? Colors.grey[400]
                                                            : Colors.blue[800]),
                                              ),
                                              child: Text(
                                                "2",
                                                style: TextStyle(
                                                    color:
                                                        snapshot.data.place2 !=
                                                                ''
                                                            ? Colors.grey[400]
                                                            : Colors.blue[800],
                                                    fontSize: 38),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 120,
                                  left: 100,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (snapshot.data.place3 == '') {
                                        setState(() {
                                          displayBottomSheet(context);
                                          isExpanded = !isExpanded;
                                          if (index == "3") {
                                            index = "";
                                          } else {
                                            index = "3";
                                          }
                                        });
                                      }
                                    },
                                    child: Container(
                                      child: index == "3"
                                          ? Container(
                                              width: 69,
                                              height: 69,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    195, 212, 255, 1),
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                border: Border.all(
                                                    width: 5,
                                                    color: Colors.blue[800]),
                                              ),
                                              child: SizedBox(
                                                height: 30.0,
                                                width: 30.0,
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  child: Icon(
                                                    Icons.check,
                                                    size: 30.0,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              width: 69,
                                              height: 69,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color:
                                                    snapshot.data.place3 != ''
                                                        ? Colors.grey[300]
                                                        : Color.fromRGBO(
                                                            195, 212, 255, 1),
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                border: Border.all(
                                                    width: 5,
                                                    color:
                                                        snapshot.data.place3 !=
                                                                ''
                                                            ? Colors.grey[400]
                                                            : Colors.blue[800]),
                                              ),
                                              child: Text(
                                                "3",
                                                style: TextStyle(
                                                    color:
                                                        snapshot.data.place3 !=
                                                                ''
                                                            ? Colors.grey[400]
                                                            : Colors.blue[800],
                                                    fontSize: 38),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 120,
                                  left: 170,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (snapshot.data.place4 == '') {
                                        setState(() {
                                          displayBottomSheet(context);
                                          isExpanded = !isExpanded;
                                          if (index == "4") {
                                            index = "";
                                          } else {
                                            index = "4";
                                          }
                                        });
                                      }
                                    },
                                    child: Container(
                                      child: index == "4"
                                          ? Container(
                                              width: 69,
                                              height: 69,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    195, 212, 255, 1),
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                border: Border.all(
                                                    width: 5,
                                                    color: Colors.blue[800]),
                                              ),
                                              child: SizedBox(
                                                height: 30.0,
                                                width: 30.0,
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  child: Icon(
                                                    Icons.check,
                                                    size: 30.0,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              width: 69,
                                              height: 69,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color:
                                                    snapshot.data.place4 != ''
                                                        ? Colors.grey[300]
                                                        : Color.fromRGBO(
                                                            195, 212, 255, 1),
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                border: Border.all(
                                                    width: 5,
                                                    color:
                                                        snapshot.data.place4 !=
                                                                ''
                                                            ? Colors.grey[400]
                                                            : Colors.blue[800]),
                                              ),
                                              child: Text(
                                                "4",
                                                style: TextStyle(
                                                    color:
                                                        snapshot.data.place4 !=
                                                                ''
                                                            ? Colors.grey[400]
                                                            : Colors.blue[800],
                                                    fontSize: 38),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox.shrink();
            }),
      ),
    );
  }

  void displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return tripData != null
                  ? Container(
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
                            margin: EdgeInsets.only(bottom: 20.0, top: 10.0),
                            padding: EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Icon(
                                      Icons.arrow_drop_down_circle,
                                      color: Colors.blueAccent,
                                      size: 10,
                                    ),
                                    Container(
                                      width: 1,
                                      height: 30,
                                      color: Colors.black,
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black,
                                      size: 15,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Text(tripData.fromWhere),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 15.0),
                                        height: 1,
                                        color: Colors.grey,
                                      ),
                                      Container(
                                        child: Text(tripData.whereTo),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: 60,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 15.0,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Свободно:"),
                                            Text(
                                                "${tripData.freePlace}/${tripData.countPlace}"),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Цена::"),
                                            Text(
                                              "${tripData.tripCost}",
                                              style: TextStyle(
                                                  color: Colors.blueAccent),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            alignment: AlignmentDirectional.centerStart,
                            margin: EdgeInsets.only(bottom: 20.0),
                            child: Text(
                              "Сводка по рейсу:",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Водитель:",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15.0),
                              ),
                              Text(
                                "${tripData.name}",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 13.0),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Номер телефона:",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15.0),
                              ),
                              Expanded(
                                child: Text(
                                  "${tripData.phoneNumber}",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 13.0),
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                "Позвонить",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12.0,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Цена:",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15.0),
                              ),
                              Text(
                                "${tripData.tripCost}",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 13.0),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            // padding: EdgeInsets.symmetric(vertical: 25.0),
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
                                'Забронировать',
                                style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 1.5,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'OpenSans',
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (index != '') {
                                    switch (index) {
                                      case '1':
                                        {
                                          dbHelper
                                              .updateTripDetail(
                                                  TripDetailResponse(
                                            carNumber: tripData.carNumber,
                                            place1: widget.name,
                                            place2: tripData.place2,
                                            place3: tripData.place3,
                                            place4: tripData.place4,
                                            name: tripData.name,
                                            phoneNumber: tripData.phoneNumber,
                                            fromWhere: tripData.fromWhere,
                                            whereTo: tripData.whereTo,
                                            tripCost: tripData.tripCost,
                                            freePlace: tripData.freePlace - 1,
                                            countPlace: 4,
                                            earned: int.parse(
                                                    tripData.tripCost) +
                                                int.parse(tripData.tripCost),
                                          ))
                                              .then((value) {
                                            dbHelper
                                                .getTripList()
                                                .then((value) {
                                              tripListBloc.mySink.add(value);
                                            });
                                          });
                                          break;
                                        }
                                      case '2':
                                        {
                                          dbHelper
                                              .updateTripDetail(
                                                  TripDetailResponse(
                                            carNumber: tripData.carNumber,
                                            place1: tripData.place1,
                                            place2: widget.name,
                                            place3: tripData.place3,
                                            place4: tripData.place4,
                                            name: tripData.name,
                                            phoneNumber: tripData.phoneNumber,
                                            fromWhere: tripData.fromWhere,
                                            whereTo: tripData.whereTo,
                                            tripCost: tripData.tripCost,
                                            freePlace: tripData.freePlace - 1,
                                            countPlace: 4,
                                            earned: int.parse(
                                                    tripData.tripCost) +
                                                int.parse(tripData.tripCost),
                                          ))
                                              .then((value) {
                                            dbHelper
                                                .getTripList()
                                                .then((value) {
                                              tripListBloc.mySink.add(value);
                                            });
                                          });
                                          break;
                                        }
                                      case '3':
                                        {
                                          dbHelper
                                              .updateTripDetail(
                                                  TripDetailResponse(
                                            carNumber: tripData.carNumber,
                                            place1: tripData.place1,
                                            place2: tripData.place2,
                                            place3: widget.name,
                                            place4: tripData.place4,
                                            name: tripData.name,
                                            phoneNumber: tripData.phoneNumber,
                                            fromWhere: tripData.fromWhere,
                                            whereTo: tripData.whereTo,
                                            tripCost: tripData.tripCost,
                                            freePlace: tripData.freePlace - 1,
                                            countPlace: 4,
                                            earned: int.parse(
                                                    tripData.tripCost) +
                                                int.parse(tripData.tripCost),
                                          ))
                                              .then((value) {
                                            dbHelper
                                                .getTripList()
                                                .then((value) {
                                              tripListBloc.mySink.add(value);
                                            });
                                          });
                                          break;
                                        }
                                      case '4':
                                        {
                                          dbHelper
                                              .updateTripDetail(
                                                  TripDetailResponse(
                                            carNumber: tripData.carNumber,
                                            place1: tripData.place1,
                                            place2: tripData.place2,
                                            place3: tripData.place3,
                                            place4: widget.name,
                                            name: tripData.name,
                                            phoneNumber: tripData.phoneNumber,
                                            fromWhere: tripData.fromWhere,
                                            whereTo: tripData.whereTo,
                                            tripCost: tripData.tripCost,
                                            freePlace: tripData.freePlace - 1,
                                            countPlace: 4,
                                            earned: int.parse(
                                                    tripData.tripCost) +
                                                int.parse(tripData.tripCost),
                                          ))
                                              .then((value) {
                                            setState(() {
                                              dbHelper
                                                  .getTripDetail(
                                                      widget.carNumber)
                                                  .then((value) {
                                                tripDetailBloc.mySink
                                                    .add(value);
                                              });
                                            });
                                          });
                                          break;
                                        }
                                    }
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox.shrink();
            },
          );
        });
  }
}
