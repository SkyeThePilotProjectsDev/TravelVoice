import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/instant_timer.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
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
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Form(
            key: _model.formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                    child: Row(
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
                  ),
                  Text(
                    'New Log',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).headlineLarge.override(
                          fontFamily: 'Inter Tight',
                          letterSpacing: 0.0,
                        ),
                  ),
                  Text(
                    'Need some insperation? Swipe through the prompts below while you record.',
                    textAlign: TextAlign.justify,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Inter',
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                        ),
                  ),
                  Container(
                    height: 300.0,
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
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 40.0),
                                      child: PageView.builder(
                                        controller: _model
                                                .pageViewController ??=
                                            PageController(
                                                initialPage: max(
                                                    0,
                                                    min(
                                                        0,
                                                        chosenPrompts.length -
                                                            1))),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: chosenPrompts.length,
                                        itemBuilder:
                                            (context, chosenPromptsIndex) {
                                          final chosenPromptsItem =
                                              chosenPrompts[chosenPromptsIndex];
                                          return Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                width: 2.0,
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 200.0,
                                                  decoration: BoxDecoration(),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: AutoSizeText(
                                                        chosenPromptsItem,
                                                        minFontSize: 20.0,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                      alignment: AlignmentDirectional(0.0, 1.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
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
                                                          chosenPrompts.length -
                                                              1))),
                                          count: chosenPrompts.length,
                                          axisDirection: Axis.horizontal,
                                          onDotClicked: (i) async {
                                            await _model.pageViewController!
                                                .animateToPage(
                                              i,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              curve: Curves.ease,
                                            );
                                            safeSetState(() {});
                                          },
                                          effect:
                                              smooth_page_indicator.SlideEffect(
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
                  Divider(
                    thickness: 2.0,
                    color: FlutterFlowTheme.of(context).alternate,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 50.0,
                          height: 50.0,
                          child: Stack(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            children: [
                              AnimatedContainer(
                                duration: Duration(milliseconds: 200),
                                curve: Curves.easeInOut,
                                width: _model.isRecording
                                    ? (_model.beatSize * 50)
                                    : 0.0,
                                height: _model.isRecording
                                    ? (_model.beatSize * 50)
                                    : 0.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  if (_model.newRecording != null &&
                                      _model.newRecording != '') {
                                    if (_model.isPlaying) {
                                      _model.soundPlayer?.stop();
                                      _model.isPlaying = false;
                                      safeSetState(() {});
                                    } else {
                                      _model.soundPlayer ??= AudioPlayer();
                                      if (_model.soundPlayer!.playing) {
                                        await _model.soundPlayer!.stop();
                                      }
                                      _model.soundPlayer!.setVolume(1.0);
                                      _model.soundPlayer!
                                          .setUrl(_model.newRecording!)
                                          .then((_) =>
                                              _model.soundPlayer!.play());

                                      _model.isPlaying = true;
                                      safeSetState(() {});
                                    }
                                  } else {
                                    if (_model.isRecording) {
                                      _model.instantTimer?.cancel();
                                      await stopAudioRecording(
                                        audioRecorder: _model.audioRecorder,
                                        audioName: 'recordedFileBytes.mp3',
                                        onRecordingComplete:
                                            (audioFilePath, audioBytes) {
                                          _model.recording = audioFilePath;
                                          _model.recordedFileBytes = audioBytes;
                                        },
                                      );

                                      _model.isRecording = false;
                                      _model.newRecording = _model.recording;
                                      safeSetState(() {});
                                    } else {
                                      await Future.wait([
                                        Future(() async {
                                          _model.instantTimer =
                                              InstantTimer.periodic(
                                            duration:
                                                Duration(milliseconds: 200),
                                            callback: (timer) async {
                                              _model.beatSize = random_data
                                                  .randomDouble(0.7, 1.0);
                                              safeSetState(() {});
                                            },
                                            startImmediately: true,
                                          );
                                        }),
                                        Future(() async {
                                          _model.isRecording = true;
                                          safeSetState(() {});
                                          await startAudioRecording(
                                            context,
                                            audioRecorder:
                                                _model.audioRecorder ??=
                                                    AudioRecorder(),
                                          );
                                        }),
                                      ]);
                                    }
                                  }

                                  safeSetState(() {});
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                    ),
                                  ),
                                  child: Builder(
                                    builder: (context) {
                                      if ((_model.newRecording == null ||
                                              _model.newRecording == '') &&
                                          !_model.isRecording) {
                                        return Icon(
                                          Icons.mic,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 35.0,
                                        );
                                      } else {
                                        return Builder(
                                          builder: (context) {
                                            if (_model.isRecording ||
                                                _model.isPlaying) {
                                              return Icon(
                                                Icons.pause,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                size: 35.0,
                                              );
                                            } else {
                                              return Icon(
                                                Icons.play_arrow,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                size: 35.0,
                                              );
                                            }
                                          },
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Record',
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                fontFamily: 'Inter Tight',
                                letterSpacing: 0.0,
                              ),
                        ),
                      ].divide(SizedBox(width: 8.0)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        FFButtonWidget(
          onPressed: () async {
            Navigator.pop(
                context,
                _model.newRecording != null && _model.newRecording != ''
                    ? _model.newRecording
                    : functions.defaultRecording());
          },
          text: 'Next',
          icon: Icon(
            Icons.arrow_right_alt_sharp,
            size: 15.0,
          ),
          options: FFButtonOptions(
            height: 40.0,
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
            iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
            color: FlutterFlowTheme.of(context).primary,
            textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                  fontFamily: 'Inter Tight',
                  color: Colors.white,
                  letterSpacing: 0.0,
                ),
            elevation: 0.0,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ].addToStart(SizedBox(height: 16.0)).addToEnd(SizedBox(height: 16.0)),
    );
  }
}
