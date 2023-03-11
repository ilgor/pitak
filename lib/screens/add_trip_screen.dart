import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:taxi_app/blocs/trip_list_bloc.dart';
import 'package:taxi_app/database/database_helper.dart';
import 'package:taxi_app/network/response/trip_detail_response.dart';
import 'package:taxi_app/screens/trip_info_driver.dart';
import 'package:taxi_app/utils/shared_pref.dart';

class AddTripScreen extends StatefulWidget {
  @override
  _AddTripScreenState createState() => _AddTripScreenState();
}

class _AddTripScreenState extends State<AddTripScreen> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  int selectedIndex = 0;

  TripListBloc tripListBloc = TripListBloc();

  final ref = FirebaseDatabase.instance.reference();
  DatabaseHelper dbHelper = DatabaseHelper();

  var name = '';
  var carNumber = '';
  var phoneNumber = '';
  var canCreate = false;
  TextEditingController fromWhereController = TextEditingController();
  TextEditingController whereToController = TextEditingController();
  TextEditingController tripCostController = TextEditingController();

  @override
  void initState() {
    getCanCreateTrip().then((value) => canCreate = value);
    getName().then((value) => name = value);
    getCarNumber().then((value) => carNumber = value);
    getPhoneNumber().then((value) => phoneNumber = value);
    dbHelper.getTripList().then((value) {
      tripListBloc.mySink.add(value);
    });
    dbHelper.getTripListListener();
    super.initState();
  }

  @override
  void dispose() {
    tripListBloc.dispose();
    dbHelper.getTripListListenerStop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // Navigator.pop(context);
            SystemNavigator.pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.blueAccent,
          ),
        ),
        title: Text(
          "Рейсы",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => TripInfoDriverScreen(
                            carNumber,
                            name,
                          )));
            },
            icon: Icon(
              Icons.info,
              color: Colors.blueAccent,
            ),
          )
        ],
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          margin: EdgeInsets.only(top: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Icon(
                        Icons.arrow_drop_down_circle,
                        color: Colors.blueAccent,
                        size: 15,
                      ),
                      Container(
                        width: 1,
                        height: 60,
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
                          child: TextFormField(
                            controller: fromWhereController,
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey[300],
                                size: 20,
                              ),
                              border: InputBorder.none,
                              hintText: "Откуда",
                              hintStyle: TextStyle(color: Colors.grey[400]),
                            ),
                          ),
                        ),
                        Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                        Container(
                          child: TextFormField(
                            controller: whereToController,
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey[300],
                                size: 20.0,
                              ),
                              border: InputBorder.none,
                              hintText: "Куда",
                              hintStyle: TextStyle(color: Colors.grey[400]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                controller: tripCostController,
                decoration: InputDecoration(
                    filled: true,
                    hintText: "Стоимость одного места",
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide.none)),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                height: 60.0,
                margin: EdgeInsets.only(bottom: 20),
                width: double.infinity,
                child: RaisedButton(
                  elevation: 0.0,
                  padding: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.blue[800],
                  child: Text(
                    'Создать рейс',
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                  onPressed: () async {
                      createTrip();
                    if (!canCreate) {
                    }
                  },
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Активные рейсы",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2),
                  ),
                  // Text(
                  //   snapshot.data != null ? "${snapshot.data.length}" : "0",
                  //   style: TextStyle(color: Colors.blueAccent),
                  // ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              StreamBuilder<List<TripDetailResponse>>(
                  stream: tripListBloc.myStream,
                  builder: (context, snapshot) {
                    return snapshot.data != null
                        ? Expanded(
                            child: SmartRefresher(
                              controller: _refreshController,
                              onRefresh: () {
                                dbHelper.getTripList().then((value) {
                                  tripListBloc.mySink.add(value);
                                  _refreshController.refreshCompleted();
                                });
                              },
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     CupertinoPageRoute(
                                      //         builder: (context) => ChoosePlaceScreen(
                                      //               carNumber,
                                      //             )));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5.0,
                                        vertical: 10.0,
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(15.0),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Container(
                                                    child: Text(snapshot
                                                        .data[index].fromWhere),
                                                  ),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 15.0),
                                                    height: 1,
                                                    color: Colors.grey,
                                                  ),
                                                  Container(
                                                    child: Text(snapshot
                                                        .data[index].whereTo),
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
                                                    margin: EdgeInsets.only(
                                                        bottom: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Свободно:"),
                                                        Text(
                                                            "${snapshot.data[index].freePlace}/${snapshot.data[index].countPlace}"),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Цена::"),
                                                        Text(
                                                          snapshot.data[index]
                                                              .tripCost,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .blueAccent),
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
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        : SizedBox.shrink();
                  }),
            ],
          ),
        ),
      ),
    );
  }

  void createTrip() async {
    if (fromWhereController.text != '' &&
        whereToController.text != '' &&
        tripCostController.text != '') {
      dbHelper
          .createTripDetail(TripDetailResponse(
        carNumber: carNumber,
        place1: '',
        place2: '',
        place3: '',
        place4: '',
        name: name,
        phoneNumber: phoneNumber,
        fromWhere: fromWhereController.text,
        whereTo: whereToController.text,
        tripCost: tripCostController.text,
        freePlace: 4,
        countPlace: 4,
        earned: 0,
      ))
          .then((value) {
        fromWhereController.text = '';
        whereToController.text = '';
        tripCostController.text = '';
        dbHelper.getTripList().then((value) {
          tripListBloc.mySink.add(value);
        });
      });
    }
  }
}
