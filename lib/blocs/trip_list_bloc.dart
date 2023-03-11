import 'dart:async';

import 'package:taxi_app/network/response/trip_detail_response.dart';

class TripListBloc {

  var _stateStreamController = StreamController<List<TripDetailResponse>>();

  StreamSink<List<TripDetailResponse>> get mySink =>
      _stateStreamController.sink;

  Stream<List<TripDetailResponse>> get myStream =>
      _stateStreamController.stream;

  void dispose() {
    _stateStreamController.close();
  }

}
var tripListBloc2 = TripListBloc();
