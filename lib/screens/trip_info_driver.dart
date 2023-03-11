import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/blocs/trip_detail_bloc.dart';
import 'package:taxi_app/database/database_helper.dart';
import 'package:taxi_app/network/response/trip_detail_response.dart';
import 'package:taxi_app/screens/add_trip_screen.dart';

class TripInfoDriverScreen extends StatefulWidget {
  String carNumber;
  String name;

  TripInfoDriverScreen(this.carNumber, this.name);

  @override
  _TripInfoDriverScreenState createState() => _TripInfoDriverScreenState();
}

class _TripInfoDriverScreenState extends State<TripInfoDriverScreen> {
  DatabaseHelper dbHelper = DatabaseHelper();
  TripDetailBloc tripDetailBloc = TripDetailBloc();

  var index = "";
  bool isExpanded = false;
  var earned = 0;

  TripDetailResponse data = TripDetailResponse();

  @override
  void initState() {
    dbHelper.getTripList().then((value) {
      for (var item in value) {
        if (widget.carNumber == item.carNumber) {
          tripDetailBloc.mySink.add(item);
        }
      }
    });
    dbHelper.getTripDetailListener(widget.carNumber);
    super.initState();
  }

  @override
  void dispose() {
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
              data = snapshot.data;
              return data != null
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
                                              color: snapshot.data.place1 != ''
                                                  ? Colors.grey[300]
                                                  : Color.fromRGBO(
                                                      195, 212, 255, 1),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              border: Border.all(
                                                  width: 5,
                                                  color:
                                                      snapshot.data.place1 != ''
                                                          ? Colors.grey[400]
                                                          : Colors.blue[800]),
                                            ),
                                            child: Text(
                                              "1",
                                              style: TextStyle(
                                                  color:
                                                      snapshot.data.place1 != ''
                                                          ? Colors.grey[400]
                                                          : Colors.blue[800],
                                                  fontSize: 38),
                                            ),
                                          ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 120,
                                  left: 30,
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
                                              color: snapshot.data.place2 != ''
                                                  ? Colors.grey[300]
                                                  : Color.fromRGBO(
                                                      195, 212, 255, 1),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              border: Border.all(
                                                  width: 5,
                                                  color:
                                                      snapshot.data.place2 != ''
                                                          ? Colors.grey[400]
                                                          : Colors.blue[800]),
                                            ),
                                            child: Text(
                                              "2",
                                              style: TextStyle(
                                                  color:
                                                      snapshot.data.place2 != ''
                                                          ? Colors.grey[400]
                                                          : Colors.blue[800],
                                                  fontSize: 38),
                                            ),
                                          ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 120,
                                  left: 100,
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
                                              color: snapshot.data.place3 != ''
                                                  ? Colors.grey[300]
                                                  : Color.fromRGBO(
                                                      195, 212, 255, 1),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              border: Border.all(
                                                  width: 5,
                                                  color:
                                                      snapshot.data.place3 != ''
                                                          ? Colors.grey[400]
                                                          : Colors.blue[800]),
                                            ),
                                            child: Text(
                                              "3",
                                              style: TextStyle(
                                                  color:
                                                      snapshot.data.place3 != ''
                                                          ? Colors.grey[400]
                                                          : Colors.blue[800],
                                                  fontSize: 38),
                                            ),
                                          ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 120,
                                  left: 170,
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
                                              color: snapshot.data.place4 != ''
                                                  ? Colors.grey[300]
                                                  : Color.fromRGBO(
                                                      195, 212, 255, 1),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              border: Border.all(
                                                  width: 5,
                                                  color:
                                                      snapshot.data.place4 != ''
                                                          ? Colors.grey[400]
                                                          : Colors.blue[800]),
                                            ),
                                            child: Text(
                                              "4",
                                              style: TextStyle(
                                                  color:
                                                      snapshot.data.place4 != ''
                                                          ? Colors.grey[400]
                                                          : Colors.blue[800],
                                                  fontSize: 38),
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
    dbHelper.getTripList().then((value) {
      for (var item in value) {
        if (widget.carNumber == item.carNumber) {
          tripDetailBloc.mySink.add(item);
        }
      }
    });
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return data != null
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
                                    child: Text(data.fromWhere),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(vertical: 15.0),
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                  Container(
                                    child: Text(data.whereTo),
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
                                            "${data.freePlace}/${data.countPlace}"),
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
                                          "${data.tripCost}",
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
                            "Место 1:",
                            style:
                                TextStyle(color: Colors.black, fontSize: 15.0),
                          ),
                          Text(
                            "${data.place1}",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 14.0),
                          ),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 2,
                        color: Colors.grey[100],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Место 2:",
                            style:
                                TextStyle(color: Colors.black, fontSize: 15.0),
                          ),
                          Expanded(
                            child: Text(
                              "${data.place2}",
                              textAlign: TextAlign.end,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 2,
                        color: Colors.grey[100],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Место 3:",
                            style:
                                TextStyle(color: Colors.black, fontSize: 15.0),
                          ),
                          Text(
                            "${data.place3}",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 14.0),
                          ),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 2,
                        color: Colors.grey[100],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Место 4:",
                            style:
                                TextStyle(color: Colors.black, fontSize: 15.0),
                          ),
                          Text(
                            "${data.place4}",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 14.0),
                          ),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 2,
                        color: Colors.grey[100],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       "Заработано:",
                      //       style: TextStyle(
                      //           color: Colors.black,
                      //           fontSize: 15.0,
                      //           fontWeight: FontWeight.bold),
                      //     ),
                      //     Text(
                      //       "${data.earned} сум",
                      //       style:
                      //           TextStyle(color: Colors.grey, fontSize: 13.0),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: 15.0,
                      // ),
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
                            'В путь',
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1.5,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                          onPressed: () {
                            dbHelper.deleteTripDetail(data).then((value) {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => AddTripScreen()));
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : SizedBox.shrink();
        });
  }
}
