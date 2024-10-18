import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'test_widget.dart' show TestWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TestModel extends FlutterFlowModel<TestWidget> {
  ///  Local state fields for this page.

  bool recorded = false;

  bool playing = false;

  bool recording = false;

  double? tickX = 0.0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
