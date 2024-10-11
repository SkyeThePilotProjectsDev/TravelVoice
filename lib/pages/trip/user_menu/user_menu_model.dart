import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/util_components/empty_list/empty_list_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import 'user_menu_widget.dart' show UserMenuWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UserMenuModel extends FlutterFlowModel<UserMenuWidget> {
  ///  Local state fields for this component.

  List<TripInvitationRecord> requests = [];
  void addToRequests(TripInvitationRecord item) => requests.add(item);
  void removeFromRequests(TripInvitationRecord item) => requests.remove(item);
  void removeAtIndexFromRequests(int index) => requests.removeAt(index);
  void insertAtIndexInRequests(int index, TripInvitationRecord item) =>
      requests.insert(index, item);
  void updateRequestsAtIndex(
          int index, Function(TripInvitationRecord) updateFn) =>
      requests[index] = updateFn(requests[index]);

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - getOrCreateUserInvitationsRef] action in userMenu widget.
  DocumentReference? userInvRef;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
