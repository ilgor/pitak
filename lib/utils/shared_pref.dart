import 'package:shared_preferences/shared_preferences.dart';

Future<bool> savePhoneNumber(String number) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print("Saved: $number");
  return prefs.setString('PHONE_NUMBER', number);
}

Future<String> getPhoneNumber() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String number = prefs.getString('PHONE_NUMBER');
  print("getPhoneNumber: $number");
  if (number == null)
    return "xxx";
  else
    return number;
}

Future<bool> isCanCreateTrip(bool canCreate) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print("Saved: $canCreate");
  return prefs.setBool('IS_CAN_CREATE_TRIP', canCreate);
}

Future<bool> getCanCreateTrip() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool canCreate = prefs.getBool('IS_CAN_CREATE_TRIP');
  print("canCreate: $canCreate");
  if (canCreate == null) {
    return false;
  } else {
    return canCreate;
  }
}

Future<bool> isCanBookTrip(bool canCreate) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print("Saved: $canCreate");
  return prefs.setBool('IS_CAN_BOOK_TRIP', canCreate);
}

Future<bool> getCanBookTrip() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool canCreate = prefs.getBool('IS_CAN_BOOK_TRIP');
  print("canBook: $canCreate");
  return canCreate;
}

Future<bool> saveCarNumber(String number) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print("Saved: $number");
  return prefs.setString('CAR_NUMBER', number);
}

Future<String> getCarNumber() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String number = prefs.getString('CAR_NUMBER');
  print("getCarNumber: $number");
  if (number == null)
    return "xxx";
  else
    return number;
}

Future<bool> saveRole(String role) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print("Saved: $role");
  return prefs.setString('ROLE', role);
}

Future<String> getRole() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String role = prefs.getString('ROLE');
  print("getRole: $role");
  if (role == null)
    return 'xxxx';
  else
    return role;
}

Future<bool> saveName(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print("Saved: $name");
  return prefs.setString('NAME', name);
}

Future<String> getName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String name = prefs.getString('NAME');
  print("name: $name");
  if (name == null)
    return "xxx";
  else
    return name;
}
