import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_audio_player.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'view_log_widget.dart' show ViewLogWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
