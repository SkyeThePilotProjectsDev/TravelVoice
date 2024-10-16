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

import 'package:travel_voice/backend/firebase_storage/storage.dart';

import '/flutter_flow/upload_data.dart';

Future<List<String>> uploadRecordings(List<String>? audioPaths) async {
  // Add your function code here!
  // safeSetState(() => _model.isDataUploading2 = true);
  audioPaths = audioPaths ?? [];
  List<String> waitingForUpload =
      audioPaths.where((i) => !i.startsWith("http")).toList() ?? [];
  if (waitingForUpload.isEmpty) return audioPaths;

  var selectedUploadedFiles = await getStorageAudioFiles(waitingForUpload);
  if (selectedUploadedFiles == null) return audioPaths;

  // var selectedUploadedFiles = <FFUploadedFile>[];
  var selectedMedia = <SelectedFile>[];
  var downloadUrls = <String>[];
  try {
    // selectedUploadedFiles =
    //     functions.addFile(_model.recordingBytes?.toList(), _model.image);
    selectedMedia = selectedFilesFromUploadedFiles(
      selectedUploadedFiles,
      isMultiData: true,
    );
    // FFAppState().isRecordingsUploading = true;
    downloadUrls = (await Future.wait(
      selectedMedia.map(
        (m) async => await uploadData(m.storagePath, m.bytes),
      ),
    ))
        .where((u) => u != null)
        .map((u) => u!)
        .toList();
  } finally {
    // FFAppState().isRecordingsUploading = false;
    // _model.isDataUploading2 = false;
  }
  if (selectedUploadedFiles.length == selectedMedia.length &&
      downloadUrls.length == selectedMedia.length) {
  } else {
    // safeSetState(() {});
    // return;
  }
  return downloadUrls.length == waitingForUpload.length
      ? downloadUrls
      : audioPaths;
}
