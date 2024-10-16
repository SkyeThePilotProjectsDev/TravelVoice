import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/pages/trip/log/create_recording/create_recording_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import 'upload_audio_widget.dart' show UploadAudioWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UploadAudioModel extends FlutterFlowModel<UploadAudioWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Bottom Sheet - createRecording] action in Button widget.
  String? recording;
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // Stores action output result for [Custom Action - getFileAudioPath] action in Button widget.
  String? filePath;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
