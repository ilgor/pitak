import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:taxi_app/blocs/trip_list_bloc.dart';
import 'package:taxi_app/database/database_helper.dart';
import 'package:taxi_app/network/response/trip_detail_response.dart';
import 'package:taxi_app/screens/choose_place.dart';
import 'package:taxi_app/utils/shared_pref.dart';

class ActiveTripScreen extends StatefulWidget {
  @override
  _ActiveTripScreenState createState() => _ActiveTripScreenState();
}

class _ActiveTripScreenState extends State<ActiveTripScreen> {
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  int selectedIndex = 0;

  var name = '';
  DatabaseHelper dbHelper = DatabaseHelper();
  TripListBloc tripListBloc = TripListBloc();

  TextEditingController fromWhere = TextEditingController();
  TextEditingController whereTo = TextEditingController();
  TextEditingController tripCost = TextEditingController();

  @override
  void initState() {
    getName().then((value) => name = value);
    dbHelper.getTripList().then((value) {
      tripListBloc2.mySink.add(value);
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
              dbHelper.getTripList().then((value) {
                tripListBloc.mySink.add(value);
                _refreshController.refreshCompleted();
              });
            },
            icon: Icon(
              Icons.sync,
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
                            controller: fromWhere,
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
                            controller: whereTo,
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
                  Text(
                    "",
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Expanded(
                child: StreamBuilder<List<TripDetailResponse>>(
                  stream: tripListBloc2.myStream,
                  builder: (context, snapshot) {
                    return snapshot.data != null
                        ? SmartRefresher(
                            controller: _refreshController,
                            onRefresh: () {
                              dbHelper.getTripList().then((value) {
                                tripListBloc2.mySink.add(value);
                                _refreshController.refreshCompleted();
                              });
                            },
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                ChoosePlaceScreen(
                                                    snapshot
                                                        .data[index].carNumber,
                                                    name)));
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
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  child: Text(snapshot
                                                      .data[index].fromWhere),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
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
                                                  margin:
                                                      EdgeInsets.only(top: 10),
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
                          )
                        : SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
