import "package:flutter/material.dart";
import "package:mrwebbeast/services/database/local_database.dart";


String decodeQueryParameter({required Map<String, String>? body}) {
  String formattedData = "";
  List<String>? bodyList = [];

  if (body != null) {
    body.forEach((key, value) {
      bodyList.add("&$key=$value");
    });
    formattedData = bodyList.join("").replaceFirst("&", "?");
  }

  if (formattedData.isNotEmpty) {
    debugPrint("Query Params are :- $formattedData");
  }
  return formattedData;
}

///Seconds
Map<String, String> defaultHeaders() {
  return {"Authorization": "Bearer ${LocalDatabase().accessToken}"};
}
