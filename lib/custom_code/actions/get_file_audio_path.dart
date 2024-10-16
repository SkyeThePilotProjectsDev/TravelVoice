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

import 'dart:io';
import 'package:path_provider/path_provider.dart' as syspaths;

Future<String?> getFileAudioPath(FFUploadedFile? file) async {
  // Add your function code here!
  try {
    if (file == null || file.bytes == null) return null;
    final appDir = await syspaths.getTemporaryDirectory();
    String path = '${appDir.path}/${file.name}';
    File file_ = File(path);
    File fin = await file_.writeAsBytes(file.bytes!);
    return fin.path;
  } catch (e) {
    return null;
  }
}
