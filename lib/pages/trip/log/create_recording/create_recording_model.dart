import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'create_recording_widget.dart' show CreateRecordingWidget;
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

class CreateRecordingModel extends FlutterFlowModel<CreateRecordingWidget> {
  ///  Local state fields for this component.

  bool isRecording = false;

  String? newRecording;

  double beatSize = 0.0;

  bool isPlaying = false;

  List<String> prompts = [];
  void addToPrompts(String item) => prompts.add(item);
  void removeFromPrompts(String item) => prompts.remove(item);
  void removeAtIndexFromPrompts(int index) => prompts.removeAt(index);
  void insertAtIndexInPrompts(int index, String item) =>
      prompts.insert(index, item);
  void updatePromptsAtIndex(int index, Function(String) updateFn) =>
      prompts[index] = updateFn(prompts[index]);

  MediaPlayerActions? playerState = MediaPlayerActions.record;

  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  AudioRecorder? audioRecorder;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // State field(s) for Timer widget.
  final timerInitialTimeMs = 0;
  int timerMilliseconds = 0;
  String timerValue = StopWatchTimer.getDisplayTime(
    0,
    hours: false,
    minute: false,
  );
  FlutterFlowTimerController timerController =
      FlutterFlowTimerController(StopWatchTimer(mode: StopWatchMode.countUp));

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    timerController.dispose();
  }
}
