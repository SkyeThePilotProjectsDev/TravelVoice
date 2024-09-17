import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/trip/log/create_recording/create_recording_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'new_log_model.dart';
export 'new_log_model.dart';

class NewLogWidget extends StatefulWidget {
  const NewLogWidget({
    super.key,
    required this.trip,
  });

  final DocumentReference? trip;

  @override
  State<NewLogWidget> createState() => _NewLogWidgetState();
}

class _NewLogWidgetState extends State<NewLogWidget> {
  late NewLogModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NewLogModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.selectedDate = getCurrentTimestamp;
      safeSetState(() {});
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: wrapWithModel(
            model: _model.createRecordingModel,
            updateCallback: () => safeSetState(() {}),
            child: const CreateRecordingWidget(),
          ),
        ),
      ),
    );
  }
}
