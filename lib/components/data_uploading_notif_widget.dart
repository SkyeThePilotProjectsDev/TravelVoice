import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'data_uploading_notif_model.dart';
export 'data_uploading_notif_model.dart';

class DataUploadingNotifWidget extends StatefulWidget {
  const DataUploadingNotifWidget({super.key});

  @override
  State<DataUploadingNotifWidget> createState() =>
      _DataUploadingNotifWidgetState();
}

class _DataUploadingNotifWidgetState extends State<DataUploadingNotifWidget> {
  late DataUploadingNotifModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DataUploadingNotifModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      height: valueOrDefault<double>(
        FFAppState().isRecordingsUploading ? 30.0 : 0.0,
        30.0,
      ),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondary,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
            child: Text(
              'Data uploading...',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Inter',
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
