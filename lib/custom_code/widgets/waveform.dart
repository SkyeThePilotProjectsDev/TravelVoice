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

import 'package:audio_waveforms/audio_waveforms.dart';
import 'dart:ui' as ui;

class Waveform extends StatefulWidget {
  const Waveform({
    super.key,
    this.width,
    this.height,
    this.audio,
    required this.state,
  });

  final double? width;
  final double? height;
  final String? audio;
  final MediaPlayerActions state;

  @override
  State<Waveform> createState() => _WaveformState();
}

class _WaveformState extends State<Waveform> {
  late PlayerController pController;
  late RecorderController rController;
  bool tryouts = false;
  MediaPlayerActions? state;

  @override
  void initState() {
    super.initState();
    pController = PlayerController();
    rController = RecorderController();
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
      print("STATE CHANGE $state -> ${widget.state}");
      state = widget.state;
      if (state == MediaPlayerActions.record)
        FutureBuilder(
          future: rController.record(),
          builder: (a, b) => Container(),
        );
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
          showDurationLabel: true,
          spacing: 8.0,
          showBottom: false,
          extendWaveform: true,
          showMiddleLine: false,
          gradient: ui.Gradient.linear(
            const Offset(70, 50),
            Offset(MediaQuery.of(context).size.width / 2, 0),
            [Colors.red, Colors.green],
          ),
        ),
      );
    } else
      return InkWell(
        onTap: () => print(widget.state),
        child: FutureBuilder(
          future: pController.extractWaveformData(
            path: widget.audio!,
            noOfSamples: 100,
          ),
          builder: (ctx, sc) {
            List<double>? data = sc.data;

            if (data == null) return Container();

            return AudioFileWaveforms(
              size: Size(
                widget.width ?? 100,
                widget.height ?? 100,
              ),
              playerController: pController,
              enableSeekGesture: true,
              waveformType: WaveformType.long,
              waveformData: data,
              playerWaveStyle: PlayerWaveStyle(
                fixedWaveColor: _p,
                liveWaveColor: _s,
                spacing: 6,
              ),
            );
          },
        ),
      );
  }
}
