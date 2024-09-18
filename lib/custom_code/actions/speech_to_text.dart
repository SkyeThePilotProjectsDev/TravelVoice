// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:google_speech/google_speech.dart' as stt;
import 'package:http/http.dart' as http;

Future<String> speechToText(List<String>? recordings) async {
  // Add your function code here!
  if (recordings == null) return "";
  List<Future<http.Response>> futureResponses = recordings
      .map(
        (r) => http.get(
          Uri.parse(r),
        ),
      )
      .toList();
  http.Response response = await http.get(
    Uri.parse('https://flutter.io/images/flutter-mark-square-100.png'),
  );
  List<http.Response> responses = await Future.wait(futureResponses);

  stt.ServiceAccount.fromFile(
    File(
      'assets/images/travel-voice-b342b-f5305026157a.json',
    ),
  );

// final response = await stt..recognize(config, audio);
//   if (recordings == null) return "";
  return "";
}
