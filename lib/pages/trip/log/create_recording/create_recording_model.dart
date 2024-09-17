import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/instant_timer.dart';
import 'create_recording_widget.dart' show CreateRecordingWidget;
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
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

  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  AudioPlayer? soundPlayer;
  String? recording;
  FFUploadedFile recordedFileBytes =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  InstantTimer? instantTimer;
  AudioRecorder? audioRecorder;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    instantTimer?.cancel();
  }
}
