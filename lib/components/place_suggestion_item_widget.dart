import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'place_suggestion_item_model.dart';
export 'place_suggestion_item_model.dart';

class PlaceSuggestionItemWidget extends StatefulWidget {
  const PlaceSuggestionItemWidget({
    super.key,
    required this.place,
  });

  final PlaceSearchStruct? place;

  @override
  State<PlaceSuggestionItemWidget> createState() =>
      _PlaceSuggestionItemWidgetState();
}

class _PlaceSuggestionItemWidgetState extends State<PlaceSuggestionItemWidget> {
  late PlaceSuggestionItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PlaceSuggestionItemModel());
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
        color: _model.mouseRegionHovered!
            ? FlutterFlowTheme.of(context).secondary
            : Color(0x00000000),
      ),
      child: MouseRegion(
        opaque: false,
        cursor: MouseCursor.defer ?? MouseCursor.defer,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            valueOrDefault<String>(
              widget!.place?.formattedAddress,
              '[Address]',
            ),
            style: FlutterFlowTheme.of(context).bodyLarge.override(
                  fontFamily: 'Inter',
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        onEnter: ((event) async {
          safeSetState(() => _model.mouseRegionHovered = true);
        }),
        onExit: ((event) async {
          safeSetState(() => _model.mouseRegionHovered = false);
        }),
      ),
    );
  }
}
