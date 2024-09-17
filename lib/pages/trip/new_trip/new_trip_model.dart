import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'new_trip_widget.dart' show NewTripWidget;
import 'package:flutter/material.dart';

class NewTripModel extends FlutterFlowModel<NewTripWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // Stores action output result for [Custom Action - getOrCreateRequest] action in Button widget.
  RequestsRecord? usersRequests;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  TripRecord? newTrip;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();
  }
}
