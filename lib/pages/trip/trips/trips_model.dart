import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/components/data_uploading_notif_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/user/profile_icon/profile_icon_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'trips_widget.dart' show TripsWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TripsModel extends FlutterFlowModel<TripsWidget> {
  ///  Local state fields for this page.

  bool update = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - getOrCreateUserInvitationsRef] action in Trips widget.
  DocumentReference? userInvRef;
  // Model for dataUploadingNotif component.
  late DataUploadingNotifModel dataUploadingNotifModel;
  // Model for profileIcon component.
  late ProfileIconModel profileIconModel;
  // Stores action output result for [Custom Action - getOrCreateUserInvitationsRef] action in Container widget.
  DocumentReference? userInvRefx;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {
    dataUploadingNotifModel =
        createModel(context, () => DataUploadingNotifModel());
    profileIconModel = createModel(context, () => ProfileIconModel());
  }

  @override
  void dispose() {
    dataUploadingNotifModel.dispose();
    profileIconModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
