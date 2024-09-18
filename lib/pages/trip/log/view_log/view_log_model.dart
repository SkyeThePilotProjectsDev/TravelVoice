import '/flutter_flow/flutter_flow_util.dart';
import 'view_log_widget.dart' show ViewLogWidget;
import 'package:flutter/material.dart';

class ViewLogModel extends FlutterFlowModel<ViewLogWidget> {
  ///  Local state fields for this page.

  FFUploadedFile? image;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for TextField_Notes widget.
  FocusNode? textFieldNotesFocusNode1;
  TextEditingController? textFieldNotesTextController1;
  String? Function(BuildContext, String?)?
      textFieldNotesTextController1Validator;
  // State field(s) for TextField_Notes widget.
  FocusNode? textFieldNotesFocusNode2;
  TextEditingController? textFieldNotesTextController2;
  String? Function(BuildContext, String?)?
      textFieldNotesTextController2Validator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldNotesFocusNode1?.dispose();
    textFieldNotesTextController1?.dispose();

    textFieldNotesFocusNode2?.dispose();
    textFieldNotesTextController2?.dispose();
  }
}
