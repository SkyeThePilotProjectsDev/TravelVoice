import '/flutter_flow/flutter_flow_util.dart';
import 'edit_trip_widget.dart' show EditTripWidget;
import 'package:flutter/material.dart';

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
