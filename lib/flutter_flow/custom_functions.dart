import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/auth/firebase_auth/auth_util.dart';

String encryptPassword(String password) {
  return base64.encode(utf8.encode(password));
}

LatLng? locationParser(LocationStruct? location) {
  if (location == null) return null;

  return LatLng(location.lat, location.lng);
}

DateTime dateBuilder(
  String? day,
  String? month,
  String? year,
  DateTime previousDate,
) {
  var pullNumbers = (String str) {
    var matches = RegExp(r'\d+').allMatches(str);
    if (matches.length == 0) return 0;
    return int.parse(matches.map((m) => m.group(0)).join(""));
  };

  int _year = pullNumbers("000" + (year ?? ""));
  if (_year == 0)
    _year = previousDate.year;
  else
    _year = math.min(9999, math.max(1000, _year));
  int _month = pullNumbers("000" + (month ?? ""));
  if (_month == 0)
    _month = previousDate.month;
  else
    _month = math.min(31, math.max(1, _month));
  // print("000" + (day ?? ""));
  // print(pullNumbers("000" + (day ?? "")));
  int _day = pullNumbers("000" + (day ?? ""));
  print("Pulled day: ${'000' + (day ?? '')} -> $_day");
  // print("Pulled day $_day");
  if (_day == 0)
    _day = previousDate.day;
  else
    math.max(0, _day);

  print("$year/$month/$day -> $_year/$_month/$_day ($previousDate)");

  return DateTime(_year, _month, _day);
}

List<String> getPrompts(
  int count,
  List<String>? prompts,
) {
  if (prompts == null || prompts.isEmpty) return [];
  List<String> _prompts = [...prompts];
  _prompts.shuffle();
  List<String> sub = _prompts.sublist(0, math.min(_prompts.length, count));
  return sub;
}

String? defaultRecording() {
  return "https://assets.mixkit.co/active_storage/sfx/1741/1741.wav";
}

String recordingToString(String? recording) {
  return recording ?? "";
}

LocationStruct? reverseLocationParser(LatLng? location) {
  if (location == null) return null;

  return LocationStruct(
    lat: location.latitude,
    lng: location.longitude,
  );
}

Color stringToColour(String? input) {
  if (input == null) return Colors.black;
  try {
    String hash = input.hashCode.toString();
    // int a = int.parse(input.substring(0, 2));
    String r = (hash.substring(2, 4));
    String g = (hash.substring(4, 6));
    String b = (hash.substring(6, 8));

    return Color(int.parse("0xff$r$g$b"));
  } catch (e) {}

  return Colors.black;
}

Color getFontColourForBackground(Color background) {
  print(
      "Font $background ${background.computeLuminance()} ${(background.computeLuminance() > 0.179) ? Colors.black : Colors.white}");
  return (background.computeLuminance() > 0.179) ? Colors.black : Colors.white;
}

bool contains(
  String? outer,
  String? inner,
  bool? caseSensetive,
) {
  if (inner == null) return true;
  if (outer == null) return false;

  return (caseSensetive ?? false)
      ? outer.contains(inner)
      : outer.toLowerCase().contains(inner.toLowerCase());
}

String? getAcronym(String? inp) {
  return inp == null
      ? ":)"
      : RegExp(r"[^\s\-_]+")
          .allMatches(inp)
          .map((m) => m.group(0)![0])
          .join()
          .toUpperCase();
}

String getDisplayName(UsersRecord? user) {
  if (user == null) return "";
  if (user.displayName != null && user.displayName.isNotEmpty)
    return user.displayName;
  return user.email;
}

bool stringEquality(
  String? a,
  String? b,
) {
  if (a == null && b == null) return true;
  if (a == null || b == null) return false;

  return a.trim().toLowerCase() == b.trim().toLowerCase();
}

DocumentReference getPlainInvetationsRef(String email) {
  String _email = email.trim().toLowerCase();
  return FirebaseFirestore.instance.collection('invitations').doc(_email);
}
