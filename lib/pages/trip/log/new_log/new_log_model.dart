import '/flutter_flow/flutter_flow_util.dart';
import '/pages/trip/log/create_recording/create_recording_widget.dart';
import 'new_log_widget.dart' show NewLogWidget;
import 'package:flutter/material.dart';

class NewLogModel extends FlutterFlowModel<NewLogWidget> {
  ///  Local state fields for this page.

  String? image;

  DateTime? selectedDate;

  ///  State fields for stateful widgets in this page.

  // Model for createRecording component.
  late CreateRecordingModel createRecordingModel;

  @override
  void initState(BuildContext context) {
    createRecordingModel = createModel(context, () => CreateRecordingModel());
  }

  @override
  void dispose() {
    createRecordingModel.dispose();
  }
}
