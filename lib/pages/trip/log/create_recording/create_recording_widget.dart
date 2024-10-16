import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'create_recording_model.dart';
export 'create_recording_model.dart';

class CreateRecordingWidget extends StatefulWidget {
  const CreateRecordingWidget({super.key});

  @override
  State<CreateRecordingWidget> createState() => _CreateRecordingWidgetState();
}

class _CreateRecordingWidgetState extends State<CreateRecordingWidget> {
  late CreateRecordingModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateRecordingModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.prompts = functions
          .getPrompts(5, FFAppConstants.prompts.toList())
          .toList()
          .cast<String>();
      safeSetState(() {});
      _model.timerController.onStartTimer();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
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
        color: FlutterFlowTheme.of(context).primaryBackground,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.chevron_left_rounded,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 40.0,
                ),
              ),
            ],
          ),
          Expanded(
            child: Form(
              key: _model.formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          await startAudioRecording(
                            context,
                            audioRecorder: _model.audioRecorder ??=
                                AudioRecorder(),
                          );
                        },
                        child: Text(
                          'New Log',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context)
                              .headlineLarge
                              .override(
                                fontFamily: 'Inter Tight',
                                letterSpacing: 0.0,
                              ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        height: _model.newRecording != null &&
                                _model.newRecording != ''
                            ? 0.0
                            : 300.0,
                        decoration: BoxDecoration(),
                        child: Builder(
                          builder: (context) {
                            if (_model.prompts.isNotEmpty) {
                              return Builder(
                                builder: (context) {
                                  final chosenPrompts = _model.prompts.toList();

                                  return Container(
                                    width: double.infinity,
                                    height: 500.0,
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 40.0),
                                          child: PageView.builder(
                                            controller: _model
                                                    .pageViewController ??=
                                                PageController(
                                                    initialPage: max(
                                                        0,
                                                        min(
                                                            0,
                                                            chosenPrompts
                                                                    .length -
                                                                1))),
                                            scrollDirection: Axis.horizontal,
                                            itemCount: chosenPrompts.length,
                                            itemBuilder:
                                                (context, chosenPromptsIndex) {
                                              final chosenPromptsItem =
                                                  chosenPrompts[
                                                      chosenPromptsIndex];
                                              return Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    width: 2.0,
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 200.0,
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: AutoSizeText(
                                                            chosenPromptsItem,
                                                            minFontSize: 20.0,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .displayMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter Tight',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 1.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 16.0),
                                            child: smooth_page_indicator
                                                .SmoothPageIndicator(
                                              controller: _model
                                                      .pageViewController ??=
                                                  PageController(
                                                      initialPage: max(
                                                          0,
                                                          min(
                                                              0,
                                                              chosenPrompts
                                                                      .length -
                                                                  1))),
                                              count: chosenPrompts.length,
                                              axisDirection: Axis.horizontal,
                                              onDotClicked: (i) async {
                                                await _model.pageViewController!
                                                    .animateToPage(
                                                  i,
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.ease,
                                                );
                                                safeSetState(() {});
                                              },
                                              effect: smooth_page_indicator
                                                  .SlideEffect(
                                                spacing: 8.0,
                                                radius: 8.0,
                                                dotWidth: 8.0,
                                                dotHeight: 8.0,
                                                dotColor:
                                                    FlutterFlowTheme.of(context)
                                                        .accent1,
                                                activeDotColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                paintStyle: PaintingStyle.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            } else {
                              return Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: FlutterFlowTimer(
                          initialTime: _model.timerInitialTimeMs,
                          getDisplayTime: (value) =>
                              StopWatchTimer.getDisplayTime(
                            value,
                            hours: false,
                          ),
                          controller: _model.timerController,
                          updateStateInterval: Duration(milliseconds: 1000),
                          onChanged: (value, displayTime, shouldUpdate) {
                            _model.timerMilliseconds = value;
                            _model.timerValue = displayTime;
                            if (shouldUpdate) safeSetState(() {});
                          },
                          textAlign: TextAlign.start,
                          style: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .override(
                                fontFamily: 'Inter Tight',
                                letterSpacing: 0.0,
                              ),
                        ),
                      ),
                      Container(
                        height: _model.newRecording != null &&
                                _model.newRecording != ''
                            ? 300.0
                            : 75.0,
                        decoration: BoxDecoration(),
                        child: Builder(
                          builder: (context) {
                            if (!isWeb) {
                              return Container(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                height: 100.0,
                                child: custom_widgets.Waveform(
                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                  height: 100.0,
                                  audio: _model.newRecording,
                                  state: _model.playerState!,
                                  widgetHeight: _model.newRecording != null &&
                                          _model.newRecording != ''
                                      ? 300.0
                                      : 75.0,
                                  onRecordingComplete: (audioPath) async {
                                    _model.newRecording =
                                        functions.audioPathFix(audioPath);
                                    _model.isPlaying = false;
                                    safeSetState(() {});
                                  },
                                  onPlayingComplete: () async {
                                    _model.isPlaying = false;
                                    _model.playerState =
                                        MediaPlayerActions.pause;
                                    safeSetState(() {});
                                  },
                                ),
                              );
                            } else {
                              return AutoSizeText(
                                'This functionality is only supported within the app',
                                textAlign: TextAlign.center,
                                minFontSize: 5.0,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      color: FlutterFlowTheme.of(context).error,
                                      fontSize: 25.0,
                                      letterSpacing: 0.0,
                                    ),
                              );
                            }
                          },
                        ),
                      ),
                    ].divide(SizedBox(height: 16.0)),
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                width: valueOrDefault<double>(
                  _model.newRecording != null && _model.newRecording != ''
                      ? MediaQuery.sizeOf(context).width
                      : 120.0,
                  120.0,
                ),
                height: valueOrDefault<double>(
                  _model.newRecording != null && _model.newRecording != ''
                      ? 90.0
                      : 125.0,
                  120.0,
                ),
                decoration: BoxDecoration(),
                child: Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional(1.0, 0.0),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 32.0, 0.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            _model.newRecording = null;
                            safeSetState(() {});
                            _model.timerController.onResetTimer();
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            width: _model.newRecording != null &&
                                    _model.newRecording != ''
                                ? 64.0
                                : 32.0,
                            height: _model.newRecording != null &&
                                    _model.newRecording != ''
                                ? 64.0
                                : 32.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).error,
                              shape: BoxShape.circle,
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: FaIcon(
                                FontAwesomeIcons.trashAlt,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 30.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(-1.0, 0.0),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(32.0, 0.0, 0.0, 0.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            Navigator.pop(
                                context,
                                _model.newRecording != null &&
                                        _model.newRecording != ''
                                    ? _model.newRecording
                                    : functions.defaultRecording());
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            width: _model.newRecording != null &&
                                    _model.newRecording != ''
                                ? 64.0
                                : 32.0,
                            height: _model.newRecording != null &&
                                    _model.newRecording != ''
                                ? 64.0
                                : 32.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).primary,
                              shape: BoxShape.circle,
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Icon(
                                Icons.check_rounded,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 36.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          if (_model.newRecording != null &&
                              _model.newRecording != '') {
                            if (_model.isPlaying) {
                              await actions.printToConsoleAction(
                                'Stopping play',
                              );
                              _model.isPlaying = false;
                              _model.playerState = MediaPlayerActions.pause;
                              safeSetState(() {});
                            } else {
                              await actions.printToConsoleAction(
                                'Starting play',
                              );
                              _model.isPlaying = true;
                              _model.playerState = MediaPlayerActions.play;
                              safeSetState(() {});
                            }
                          } else {
                            if (_model.isRecording) {
                              await actions.printToConsoleAction(
                                'Stopping recording',
                              );
                              _model.timerController.onStopTimer();
                              _model.isRecording = false;
                              _model.playerState = MediaPlayerActions.pause;
                              safeSetState(() {});
                            } else {
                              await actions.printToConsoleAction(
                                'Starting recording',
                              );
                              _model.timerController.onResetTimer();

                              _model.timerController.onStartTimer();
                              _model.isRecording = true;
                              _model.playerState = MediaPlayerActions.record;
                              safeSetState(() {});
                            }
                          }
                        },
                        child: Container(
                          width: 125.0,
                          height: 125.0,
                          child: Stack(
                            children: [
                              Opacity(
                                opacity: valueOrDefault<double>(
                                  _model.isRecording &&
                                          (_model.newRecording == null ||
                                              _model.newRecording == '')
                                      ? 1.0
                                      : 0.0,
                                  0.0,
                                ),
                                child: Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Container(
                                    width: 125.0,
                                    height: 125.0,
                                    decoration: BoxDecoration(
                                      color: Color(0x80FF5963),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Transform.scale(
                                      scaleX: 0.8,
                                      scaleY: 0.8,
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        height:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.square_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 75.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Opacity(
                                opacity: valueOrDefault<double>(
                                  _model.isRecording ||
                                          (_model.newRecording != null &&
                                              _model.newRecording != '')
                                      ? 0.0
                                      : 1.0,
                                  1.0,
                                ),
                                child: Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Container(
                                    width: 125.0,
                                    height: 125.0,
                                    decoration: BoxDecoration(
                                      color: Color(0x808FBFBF),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Transform.scale(
                                      scaleX: 0.8,
                                      scaleY: 0.8,
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        height:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.mic,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 75.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Opacity(
                                opacity: valueOrDefault<double>(
                                  _model.newRecording != null &&
                                          _model.newRecording != ''
                                      ? 1.0
                                      : 0.0,
                                  0.0,
                                ),
                                child: Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Container(
                                    width: 70.0,
                                    height: 70.0,
                                    decoration: BoxDecoration(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Builder(
                                        builder: (context) {
                                          if (_model.isPlaying) {
                                            return Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: Icon(
                                                Icons.pause_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 50.0,
                                              ),
                                            );
                                          } else {
                                            return Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: Icon(
                                                Icons.play_arrow_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 50.0,
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ].addToStart(SizedBox(height: 16.0)).addToEnd(SizedBox(height: 16.0)),
      ),
    );
  }
}
