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
    required this.audio,
  });

  final double? width;
  final double? height;
  final String audio;

  @override
  State<Waveform> createState() => _WaveformState();
}

class _WaveformState extends State<Waveform> {
  late PlayerController controller;

  @override
  void initState() {
    controller = PlayerController();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: controller.extractWaveformData(
          path: widget.audio,
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
            playerWaveStyle: const PlayerWaveStyle(
              fixedWaveColor: Colors.white54,
              liveWaveColor: Colors.blueAccent,
              spacing: 6,
            ),
          );
        });
  }
}
