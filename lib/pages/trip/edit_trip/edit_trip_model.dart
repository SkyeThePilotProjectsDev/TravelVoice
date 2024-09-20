import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'edit_trip_widget.dart' show EditTripWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditTripModel extends FlutterFlowModel<EditTripWidget> {
  ///  Local state fields for this page.

  List<String> newMembers = [];
  void addToNewMembers(String item) => newMembers.add(item);
  void removeFromNewMembers(String item) => newMembers.remove(item);
  void removeAtIndexFromNewMembers(int index) => newMembers.removeAt(index);
  void insertAtIndexInNewMembers(int index, String item) =>
      newMembers.insert(index, item);
  void updateNewMembersAtIndex(int index, Function(String) updateFn) =>
      newMembers[index] = updateFn(newMembers[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - getOrCreateRequestOnce] action in Icon widget.
  RequestsRecord? request;
  // State field(s) for TextField_Name widget.
  FocusNode? textFieldNameFocusNode;
  TextEditingController? textFieldNameTextController;
  String? Function(BuildContext, String?)? textFieldNameTextControllerValidator;
  // State field(s) for TextField_Email widget.
  FocusNode? textFieldEmailFocusNode;
  TextEditingController? textFieldEmailTextController;
  String? Function(BuildContext, String?)?
      textFieldEmailTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldNameFocusNode?.dispose();
    textFieldNameTextController?.dispose();

    textFieldEmailFocusNode?.dispose();
    textFieldEmailTextController?.dispose();
  }
}
