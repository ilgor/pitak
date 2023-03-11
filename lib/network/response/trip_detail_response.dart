class TripDetailResponse {
  String carNumber;
  String place1;
  String place2;
  String place3;
  String place4;
  String name;
  String phoneNumber;
  String fromWhere;
  String whereTo;
  String tripCost;
  int freePlace;
  int countPlace;
  int earned;

  TripDetailResponse(
      {this.carNumber,
      this.place1,
      this.place2,
      this.place3,
      this.place4,
      this.name,
      this.phoneNumber,
      this.fromWhere,
      this.whereTo,
      this.tripCost,
      this.freePlace,
      this.countPlace,
      this.earned});

  Map<String, dynamic> toJson() {
    return {
      'carNumber': carNumber,
      'place1': place1,
      'place2': place2,
      'place3': place3,
      'place4': place4,
      'name': name,
      'phoneNumber': phoneNumber,
      'fromWhere': fromWhere,
      'whereTo': whereTo,
      'tripCost': tripCost,
      'freePlace': freePlace,
      'countPlace': countPlace,
      'earned': earned
    };
  }

  factory TripDetailResponse.fromJson(Map<dynamic, dynamic> json) {
    return TripDetailResponse(
      carNumber: json['carNumber'],
      place1: json['place1'],
      place2: json['place2'],
      place3: json['place3'],
      place4: json['place4'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      fromWhere: json['fromWhere'],
      whereTo: json['whereTo'],
      tripCost: json['tripCost'],
      freePlace: json['freePlace'],
      countPlace: json['countPlace'],
      earned: json['earned'],
    );
  }
}
