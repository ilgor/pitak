import 'dart:async';

import 'package:taxi_app/network/response/trip_detail_response.dart';

class TripDetailBloc {
  var _stateStreamController = StreamController<TripDetailResponse>();

  StreamSink<TripDetailResponse> get mySink => _stateStreamController.sink;

  Stream<TripDetailResponse> get myStream => _stateStreamController.stream;

  void dispose() {
    _stateStreamController.close();
  }
}

var tripDetailBloc2 = TripDetailBloc();
