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
  late PlayerController controller;
  bool tryouts = false;

  @override
  void initState() {
    super.initState();
    controller = PlayerController();
    print("INIT STATE -> ${widget.state}");
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
    if (widget.audio == null) return Container();
    return FutureBuilder(
        future: controller.extractWaveformData(
          path: widget.audio!,
          noOfSamples: 100,
        ),
        builder: (ctx, sc) {
          List<double>? data = sc.data;

          if (data == null) return Container();

          return AudioFileWaveforms(
            size: Size(MediaQuery.of(context).size.width, 100.0),
            playerController: controller,
            enableSeekGesture: true,
            waveformType: WaveformType.long,
            waveformData: data,
            playerWaveStyle: PlayerWaveStyle(
              fixedWaveColor: _p,
              liveWaveColor: _s,
              spacing: 6,
            ),
          );
        });
  }
}
