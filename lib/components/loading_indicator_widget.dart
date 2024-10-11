import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'loading_indicator_model.dart';
export 'loading_indicator_model.dart';

class LoadingIndicatorWidget extends StatefulWidget {
  const LoadingIndicatorWidget({
    super.key,
    this.message,
  });

  final String? message;

  @override
  State<LoadingIndicatorWidget> createState() => _LoadingIndicatorWidgetState();
}

class _LoadingIndicatorWidgetState extends State<LoadingIndicatorWidget> {
  late LoadingIndicatorModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoadingIndicatorModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget!.message != null && widget!.message != '')
              Text(
                valueOrDefault<String>(
                  widget!.message,
                  '~',
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Inter',
                      letterSpacing: 0.0,
                    ),
              ),
            Container(
              width: 150.0,
              height: 150.0,
              child: custom_widgets.LoadingWidget(
                width: 150.0,
                height: 150.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
