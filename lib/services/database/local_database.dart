import "package:flutter/material.dart";
import "package:hive_flutter/adapters.dart";
import "package:mrwebbeast/core/config/app_config.dart";


class LocalDatabase extends ChangeNotifier {
  ///Hive Database Initialization....

  static Future initialize() async {
    await Hive.initFlutter();
    await Hive.openBox(AppConfig.databaseName);
  }

  ///Hive Database Box....
  Box database = Hive.box(AppConfig.databaseName);

  ///Access Local Database data...

  late String? name = database.get("name");
  late String? email = database.get("email");
  late String? mobile = database.get("mobile");
  late String? profilePhoto = database.get("photoUrl");
  late String? accessToken = database.get("accessToken");
  late String? deviceToken = database.get("deviceToken");

  late double? latitude = database.get("latitude");
  late double? longitude = database.get("longitude");
  late String? themeMode = database.get("themeMode");

  ///Setting Local Database data...
  ///
  // Future updateUser({required UserData user}) async {
  //   _currentUser = user;
  //   notifyListeners();
  //   database.put("uid", user.uid);
  //   database.put("name", user.name);
  //   database.put("email", user.email);
  //   database.put("username", user.username);
  //   database.put("photoUrl", user.photoUrl);
  //   database.put("role", user.role);
  //   database.put("status", user.status);
  //   database.put("points", user.points);
  //   database.put("isPremium", user.isPremium);
  //   database.put("isAnonymous", user.isAnonymous);
  //   database.put("creationTime", user.creationTime);
  //   database.put("lastSignInTime", user.lastSignInTime);
  // }

  setDeviceToken(String? token) {
    deviceToken = token;
    database.put("deviceToken", token ?? "");
    notifyListeners();
  }

  setThemeMode({required ThemeMode mode}) {
    themeMode = mode.name;
    database.put("themeMode", themeMode ?? "");
    notifyListeners();
  }

  setLatLong(
    double? latitude,
    double? longitude,
  ) {
    latitude = latitude;
    longitude = longitude;
    database.put("latitude", latitude);
    database.put("longitude", longitude);
    notifyListeners();
  }
}
