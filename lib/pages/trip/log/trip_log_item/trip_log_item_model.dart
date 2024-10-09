import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/user/profile_icon/profile_icon_widget.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'trip_log_item_widget.dart' show TripLogItemWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TripLogItemModel extends FlutterFlowModel<TripLogItemWidget> {
  ///  Local state fields for this component.

  bool isExpanded = false;

  MediaPlayerActions? playerState = MediaPlayerActions.pause;

  ///  State fields for stateful widgets in this component.

  // Model for profileIcon component.
  late ProfileIconModel profileIconModel;

  @override
  void initState(BuildContext context) {
    profileIconModel = createModel(context, () => ProfileIconModel());
  }

  @override
  void dispose() {
    profileIconModel.dispose();
  }
}
