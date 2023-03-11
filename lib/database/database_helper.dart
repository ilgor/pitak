import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:taxi_app/blocs/trip_detail_bloc.dart';
import 'package:taxi_app/blocs/trip_list_bloc.dart';
import 'package:taxi_app/network/response/trip_detail_response.dart';
import 'package:taxi_app/utils/shared_pref.dart';

class DatabaseHelper {
  final ref = FirebaseDatabase.instance.reference();
  List<TripDetailResponse> trips = List();
  TripDetailBloc tripDetailBloc = TripDetailBloc();
  TripListBloc tripListBloc = TripListBloc();

  Future<List<TripDetailResponse>> getTripList() async {
    try {
      var snap = await ref.child('taxi_app').child('trip_detail').once();
      var keys = snap.value.keys;
      var data = snap.value;
      trips.clear();
      for (var key in keys) {
        TripDetailResponse d = TripDetailResponse(
            carNumber: data[key]['carNumber'],
            place1: data[key]['place1'],
            place2: data[key]['place2'],
            place3: data[key]['place3'],
            place4: data[key]['place4'],
            name: data[key]['name'],
            phoneNumber: data[key]['phoneNumber'],
            fromWhere: data[key]['fromWhere'],
            whereTo: data[key]['whereTo'],
            tripCost: data[key]['tripCost'],
            freePlace: data[key]['freePlace'],
            countPlace: data[key]['countPlace']);
        trips.add(d);
        var push = ref.push().key;
      }
    } catch (e) {
      trips = List();
    }

    return trips;
  }

  Future<TripDetailResponse> getTripDetail(String carNumber) async {
    TripDetailResponse d = TripDetailResponse();
    var snap = await ref.child('taxi_app').child('trip_detail').once();
    var keys = snap.value.keys;
    var data = snap.value;
    trips.clear();
    for (var key in keys) {
      if (carNumber == data[key]['carNumber']) {
        d = TripDetailResponse(
            carNumber: data[key]['carNumber'],
            place1: data[key]['place1'],
            place2: data[key]['place2'],
            place3: data[key]['place3'],
            place4: data[key]['place4'],
            name: data[key]['name'],
            phoneNumber: data[key]['phoneNumber'],
            fromWhere: data[key]['fromWhere'],
            whereTo: data[key]['whereTo'],
            tripCost: data[key]['tripCost'],
            freePlace: data[key]['freePlace'],
            countPlace: data[key]['countPlace']);
      }
    }
    return d;
  }

  Future<void> updateTripDetail(TripDetailResponse tripDetailResponse) async {
    var data = await ref
        .child("taxi_app")
        .child("trip_detail")
        .child(tripDetailResponse.carNumber)
        .set(tripDetailResponse.toJson());
    isCanCreateTrip(true);

    return data;
  }

  Future<void> createTripDetail(TripDetailResponse tripDetailResponse) async {
    var push = ref
        .child("taxi_app")
        .child("trip_detail")
        .child(tripDetailResponse.carNumber);
    isCanCreateTrip(true);

    return await push.set(tripDetailResponse.toJson());
  }

  Future<void> deleteTripDetail(TripDetailResponse tripDetailResponse) async {
    var remove = ref
        .child("taxi_app")
        .child("trip_detail")
        .child(tripDetailResponse.carNumber);
    isCanCreateTrip(false);

    return await remove.remove();
  }

  getTripListListener() {
    ref.child("taxi_app").child("trip_detail").onChildAdded.listen((event) {
      getTripList().then((tripLIst) {
        tripListBloc2.mySink.add(tripLIst);
      });
    });
  }

  getTripListListenerStop() {
    tripListBloc.dispose();
  }

  getTripDetailListener(String carNumber) {
    ref.child("taxi_app").child("trip_detail").onChildAdded.listen((event) {
      getTripDetail(carNumber).then((tripDetail) {
        tripDetailBloc.mySink.add(tripDetail);
      });
    });
  }

  getTripDetailListenerStop() {
    tripDetailBloc.dispose();
  }
}
