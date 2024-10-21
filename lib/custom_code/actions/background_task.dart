// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';
import 'package:flutter_background_service/flutter_background_service.dart';

Future backgroundTask(Future Function() action) async {
  // Add your function code here!
  unawaited(() async {
    FlutterBackgroundService service = FlutterBackgroundService();
    await service.startService();
    service.invoke('setAsForeground');
    await action();
    service.invoke('setAsBackground');
  }());
}
