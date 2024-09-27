// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:ffi';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';

class Waveform extends StatefulWidget {
  const Waveform({
    super.key,
    this.width,
    this.height,
    this.audio,
    required this.state,
    required this.onRecordingComplete,
    required this.onPlayingComplete,
  });

  final double? width;
  final double? height;
  final String? audio;
  final MediaPlayerActions state;
  final Future Function(String? audioPath) onRecordingComplete;
  final Future Function() onPlayingComplete;

  @override
  State<Waveform> createState() => _WaveformState();
}

class _WaveformState extends State<Waveform> {
  late RecorderController rController;
  late PlayerController pController;
  bool tryouts = false;
  MediaPlayerActions? state;
  String? path;

  Future prep() async => path == null
      ? null
      : await pController.preparePlayer(
          path: path!,
          shouldExtractWaveform: true,
          noOfSamples: 100,
          volume: 1.0,
        );

  @override
  void initState() {
    super.initState();
    rController = RecorderController();
    pController = PlayerController();
    pController.onCompletion.listen((_) {
      print("COMPLETE");
      // await pController.stopPlayer();
      // await pController.;
      widget.onPlayingComplete.call();
    });
    print("INIT STATE -> ${widget.state}");
    // state = widget.state;
  }

  @override
  void setState(void Function() fn) {
    super.setState(fn);
    print("SET STATE -> ${widget.state}");
  }

  @override
  Widget build(BuildContext context) {
    final Color _p = FlutterFlowTheme.of(context).primary;
    final Color _s = FlutterFlowTheme.of(context).secondary;

    if (widget.state != state) {
      List<Future Function()> run = [];
      print("STATE CHANGE $state -> ${widget.state}");
      state = widget.state;
      if (state == MediaPlayerActions.record) {
        run.add(
          () async {
            print("RECORD");
            final dir = await getApplicationDocumentsDirectory();
            String _path =
                '${dir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a';
            print(_path);
            await rController.record(path: _path);
          },
        );
      } else if (rController.isRecording) {
        run.add(
          () async {
            print("COMPLETE");
            path = await rController.stop();
            print("GOT PATH: $path");
            await widget.onRecordingComplete(path);
            await prep();
            // if (path != null) {
            //   await pController.preparePlayer(
            //     path: path,
            //     shouldExtractWaveform: true,
            //     noOfSamples: 100,
            //     volume: 1.0,
            //   );
            // }
          },
        );
      }

      if (state == MediaPlayerActions.play) {
        run.add(
          () async {
            print("STARTTTT");
            // await prep();
            await pController.startPlayer(finishMode: FinishMode.pause);
            print("START DONE");
          },
        );
      } else {
        run.add(() async {
          await pController.pausePlayer();
          await prep();
        });
      }

      if (run.isNotEmpty) {
        FutureBuilder(
          future: Future.wait(run.map((r) => Future(r))),
          builder: (a, b) => Container(),
        );
      }
    }

    // if (widget.audio == null) return Container();

    if (state == MediaPlayerActions.record) {
      return AudioWaveforms(
        size: Size(
          widget.width ?? 100,
          widget.height ?? 100,
        ),
        recorderController: rController,
        enableGesture: true,
        waveStyle: WaveStyle(
          waveColor: _p,
          showDurationLabel: false,
          durationLinesColor: Colors.transparent,
          spacing: 8.0,
          showTop: true,
          showBottom: true,
          extendWaveform: true,
          showMiddleLine: false,
          gradient: ui.Gradient.linear(
            const Offset(70, 50),
            Offset(MediaQuery.of(context).size.width / 2, 0),
            [_s, _p],
          ),
        ),
      );
    } else {
      // if (widget.audio == null) return Container();
      // return InkWell(
      //   onTap: () => print(widget.state),
      //   child: FutureBuilder(
      //     future: pController.extractWaveformData(
      //       path: widget.audio!,
      //       noOfSamples: 100,
      //     ),
      //     builder: (ctx, sc) {
      //       List<double>? data = sc.data;

      //       if (data == null) return Container();

      return AudioFileWaveforms(
        size: Size(
          widget.width ?? 100,
          widget.height ?? 100,
        ),
        playerController: pController,
        enableSeekGesture: true,
        waveformType: WaveformType.long,
        // waveformData: [],
        playerWaveStyle: PlayerWaveStyle(
          fixedWaveColor: _p,
          liveWaveColor: _s,
          spacing: 6,
        ),
      );
      //     },
      //   ),
      // );
    }
  }
}
