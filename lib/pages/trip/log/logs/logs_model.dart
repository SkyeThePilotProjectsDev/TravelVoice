import '/backend/backend.dart';
import '/components/data_uploading_notif_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/trip/log/trip_log_item/trip_log_item_widget.dart';
import '/util_components/empty_list/empty_list_widget.dart';
import 'logs_widget.dart' show LogsWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LogsModel extends FlutterFlowModel<LogsWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for dataUploadingNotif component.
  late DataUploadingNotifModel dataUploadingNotifModel;

  @override
  void initState(BuildContext context) {
    dataUploadingNotifModel =
        createModel(context, () => DataUploadingNotifModel());
  }

  @override
  void dispose() {
    dataUploadingNotifModel.dispose();
  }
}
