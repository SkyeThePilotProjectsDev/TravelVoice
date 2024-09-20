import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'profile_icon_model.dart';
export 'profile_icon_model.dart';

class ProfileIconWidget extends StatefulWidget {
  const ProfileIconWidget({
    super.key,
    this.input,
    int? fontSize,
    int? padding,
  })  : this.fontSize = fontSize ?? 50,
        this.padding = padding ?? 10;

  final String? input;
  final int fontSize;
  final int padding;

  @override
  State<ProfileIconWidget> createState() => _ProfileIconWidgetState();
}

class _ProfileIconWidgetState extends State<ProfileIconWidget> {
  late ProfileIconModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileIconModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      height: MediaQuery.sizeOf(context).width * 1.0,
      decoration: BoxDecoration(
        color: colorFromCssString(
          widget!.input!,
          defaultColor: Colors.black,
        ),
        shape: BoxShape.circle,
      ),
      child: Align(
        alignment: AlignmentDirectional(0.0, 0.0),
        child: Padding(
          padding: EdgeInsets.all(valueOrDefault<double>(
            widget!.padding.toDouble(),
            0.0,
          )),
          child: AutoSizeText(
            (String? inp) {
              return inp == null
                  ? ":)"
                  : RegExp("\w+")
                      .allMatches(inp)
                      .map((m) => m.group(0))
                      .join()
                      .toUpperCase();
            }(widget!.input),
            textAlign: TextAlign.center,
            minFontSize: 10.0,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Inter',
                  color: valueOrDefault<Color>(
                    functions.getFontColourForBackground(valueOrDefault<Color>(
                      functions.stringToColour(widget!.input),
                      Colors.black,
                    )),
                    Colors.white,
                  ),
                  fontSize: valueOrDefault<double>(
                    widget!.fontSize.toDouble(),
                    50.0,
                  ),
                  letterSpacing: 0.0,
                ),
          ),
        ),
      ),
    );
  }
}
