import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_manager.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future saveLogRecordingsBackground(
  BuildContext context, {
  DocumentReference? logRef,
  List<String>? recordingPaths,
}) async {
  List<String>? recordingUploads;

  FFAppState().isRecordingsUploading = true;
  FFAppState().update(() {});
  recordingUploads = await actions.uploadRecordings(
    recordingPaths?.toList(),
  );
  if (recordingUploads != null && (recordingUploads)!.isNotEmpty) {
    await logRef!.update({
      ...mapToFirestore(
        {
          'recordings': recordingUploads,
        },
      ),
    });
  }
  FFAppState().isRecordingsUploading = false;
  FFAppState().update(() {});
}
