import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/user/profile_icon/profile_icon_widget.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'trip_log_item_model.dart';
export 'trip_log_item_model.dart';

class TripLogItemWidget extends StatefulWidget {
  const TripLogItemWidget({
    super.key,
    this.log,
  });

  final LogRecord? log;

  @override
  State<TripLogItemWidget> createState() => _TripLogItemWidgetState();
}

class _TripLogItemWidgetState extends State<TripLogItemWidget> {
  late TripLogItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TripLogItemModel());
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
        boxShadow: [
          BoxShadow(
            blurRadius: 4.0,
            color: Color(0x33000000),
            offset: Offset(
              0.0,
              2.0,
            ),
          )
        ],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FutureBuilder<UsersRecord>(
                  future: UsersRecord.getDocumentOnce(widget!.log!.createdBy!),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              FlutterFlowTheme.of(context).primary,
                            ),
                          ),
                        ),
                      );
                    }

                    final containerUsersRecord = snapshot.data!;

                    return Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(),
                      child: Transform.scale(
                        scaleX: 0.9,
                        scaleY: 0.9,
                        child: wrapWithModel(
                          model: _model.profileIconModel,
                          updateCallback: () => safeSetState(() {}),
                          child: ProfileIconWidget(
                            input:
                                functions.getDisplayName(containerUsersRecord),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.pushNamed(
                            'ViewLog',
                            queryParameters: {
                              'log': serializeParam(
                                widget!.log,
                                ParamType.Document,
                              ),
                            }.withoutNulls,
                            extra: <String, dynamic>{
                              'log': widget!.log,
                            },
                          );
                        },
                        child: Text(
                          valueOrDefault<String>(
                            widget!.log?.location?.locationText,
                            '[location]',
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyLarge.override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                      Text(
                        dateTimeFormat("yMMMd", widget!.log!.eventDate!),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Inter',
                              color: FlutterFlowTheme.of(context).alternate,
                              letterSpacing: 0.0,
                            ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    _model.isExpanded = !_model.isExpanded;
                    safeSetState(() {});
                  },
                  child: Builder(
                    builder: (context) {
                      if (_model.isExpanded) {
                        return Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 30.0,
                        );
                      } else {
                        return Icon(
                          Icons.keyboard_arrow_left_rounded,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 30.0,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            if (widget!.log?.recordings != null &&
                (widget!.log?.recordings)!.isNotEmpty)
              ClipRRect(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  height: valueOrDefault<double>(
                    _model.isExpanded ? 120.0 : 0.0,
                    120.0,
                  ),
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              if (_model.playerState ==
                                  MediaPlayerActions.pause) {
                                _model.playerState = MediaPlayerActions.play;
                                safeSetState(() {});
                              } else {
                                _model.playerState = MediaPlayerActions.pause;
                                safeSetState(() {});
                              }
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                shape: BoxShape.circle,
                              ),
                              child: Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Builder(
                                  builder: (context) {
                                    if (_model.playerState ==
                                        MediaPlayerActions.pause) {
                                      return Icon(
                                        Icons.play_arrow_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 24.0,
                                      );
                                    } else {
                                      return Icon(
                                        Icons.pause_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 24.0,
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: 500.0,
                              height: 75.0,
                              child: custom_widgets.Waveform(
                                width: 500.0,
                                height: 75.0,
                                audio: widget!.log?.recordings?.first,
                                widgetHeight: 75.0,
                                state: _model.playerState!,
                                onRecordingComplete: (audioPath) async {},
                                onPlayingComplete: () async {},
                              ),
                            ),
                          ),
                        ].divide(SizedBox(width: 8.0)),
                      ),
                      Text(
                        functions.audioToString(valueOrDefault<String>(
                          widget!.log?.recordings?.first,
                          '~',
                        )),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Inter',
                              letterSpacing: 0.0,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
