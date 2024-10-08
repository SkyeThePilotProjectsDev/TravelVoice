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

// import 'dart:ffi';

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
    required this.widgetHeight,
  });

  final double? width;
  final double? height;
  final String? audio;
  final MediaPlayerActions state;
  final Future Function(String? audioPath) onRecordingComplete;
  final Future Function() onPlayingComplete;
  final double widgetHeight;

  @override
  State<Waveform> createState() => _WaveformState();
}

class _WaveformState extends State<Waveform> {
  late RecorderController rController;
  late PlayerController pController;
  bool tryouts = false;
  MediaPlayerActions? state;
  String? path;

  PlayerWaveStyle Function({Color p, Color s}) playerWaveStyle =
      ({p = Colors.black, s = Colors.black}) => PlayerWaveStyle(
            fixedWaveColor: p,
            liveWaveColor: s,
            spacing: 6,
            scaleFactor: 300,
          );

  double _initialDragPosition = 0.0;
  double _scrollDirection = 0.0;
  bool _isScrolled = false;
  double scrollScale = 1.0;
  double _proportion = 0.0;

  Offset _totalBackDistance = Offset.zero;
  Offset _dragOffset = Offset.zero;

  void _handleHorizontalDragStart(DragStartDetails details) =>
      _initialDragPosition = details.localPosition.dx;

  void _handleDragGestures(DragUpdateDetails details) {
    _handleScrollUpdate(details);
  }

  void _handleOnDragEnd() {
    _isScrolled = false;
    scrollScale = 1.0;
    if (mounted) setState(() {});

    pController.seekTo(
      (pController.maxDuration * _proportion).toInt(),
    );
  }

  ///This method handles horizontal scrolling of the wave
  void _handleScrollUpdate(DragUpdateDetails details) {
    // Direction of the scroll. Negative value indicates scroll left to right
    // and positive value indicates scroll right to left
    _scrollDirection = details.localPosition.dx - _initialDragPosition;
    pController.setRefresh(false);
    _isScrolled = true;

    scrollScale = playerWaveStyle().scrollScale;

    // left to right
    if (-_totalBackDistance.dx +
                _dragOffset.dx +
                details.delta.dx +
                (playerWaveStyle().spacing) <
            playerWaveStyle().spacing / 2 &&
        _scrollDirection > 0) {
      _dragOffset += details.delta;
    }

    // right to left
    else if (-_totalBackDistance.dx +
                _dragOffset.dx +
                (playerWaveStyle().spacing * pController.waveformData.length) +
                details.delta.dx >
            -playerWaveStyle().spacing / 2 &&
        _scrollDirection < 0) {
      _dragOffset += details.delta;
    }

    // Indicates location of first wave
    var start = -_totalBackDistance.dx +
        _dragOffset.dx -
        (playerWaveStyle().spacing / 2);

    if (_scrollDirection < 0) {
      _proportion = (start.abs() + details.delta.dx) /
          (pController.waveformData.length * playerWaveStyle().spacing);
    } else {
      _proportion = (details.delta.dx - start) /
          (pController.waveformData.length * playerWaveStyle().spacing);
    }
    if (mounted) setState(() {});
  }

  /// This method handles tap seek gesture
  void _handleScrubberSeekStart(TapUpDetails details) {
    _proportion = details.localPosition.dx / (widget.width ?? 1);
    var seekPosition = pController.maxDuration * _proportion;

    pController.seekTo(seekPosition.toInt());
  }

  Future prep() async {
    print("path: $path");
    _initialDragPosition = 0.0;
    if (path == null) return;
    // await pController.release();
    await pController.preparePlayer(
      path: path!,
      // shouldExtractWaveform: true,
      noOfSamples: 100,
      volume: 1.0,
    );
  }

  @override
  void initState() {
    super.initState();
    rController = RecorderController();
    pController = PlayerController();
    // pController.
    pController.onCurrentDurationChanged.listen((i) {
      print("DUREATION CHANGED: $i");
    });
    pController.onCompletion.listen((_) {
      print("COMPLETE");
      // await pController.stopPlayer();
      // await pController.;
      // widget.onPlayingComplete.call();
      FutureBuilder(
        future: widget.onPlayingComplete(),
        builder: (_, __) {
          print("Almost done");
          return Container();
        },
      );
      print("Done done");
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
          },
        );
      }

      if (state == MediaPlayerActions.play) {
        run.add(
          () async {
            print("STARTTTT");
            // await prep();
            print(
                "State: ${pController.playerState}, Key: ${pController.playerKey}, Data: ${pController.waveformData}");
            await pController.startPlayer(finishMode: FinishMode.pause);
            print(
                "State: ${pController.playerState}, Key: ${pController.playerKey}, Data: ${pController.waveformData}");
            print("START DONE");
          },
        );
      } else {
        run.add(() async {
          await pController.pausePlayer();
          // await prep();
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
          widget.widgetHeight ?? 100,
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
          scaleFactor: 70,
          gradient: ui.Gradient.linear(
            const Offset(70, 50),
            Offset(MediaQuery.of(context).size.width / 2, 0),
            [_s, _p],
          ),
        ),
      );
    } else {
      if (path == null) return Container();
      return InkWell(
        onTap: () => print(widget.state),
        child: FutureBuilder(
          future: pController.extractWaveformData(
            path: path!,
            noOfSamples: 100,
          ),
          builder: (ctx, sc) {
            List<double>? data = sc.data;

            if (data == null) return Container();

            return GestureDetector(
              onHorizontalDragUpdate: _handleDragGestures,
              onTapUp: _handleScrubberSeekStart,
              onHorizontalDragStart: _handleHorizontalDragStart,
              onHorizontalDragEnd: (_) => _handleOnDragEnd(),
              child: AudioFileWaveforms(
                size: Size(
                  widget.width ?? 100,
                  widget.widgetHeight ?? 100,
                ),
                playerController: pController,
                enableSeekGesture: true,
                waveformType: WaveformType.long,
                continuousWaveform: true,
                // waveformData: data,
                playerWaveStyle: PlayerWaveStyle(
                  fixedWaveColor: _p,
                  liveWaveColor: _s,
                  spacing: 6,
                  scaleFactor: 300,
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
