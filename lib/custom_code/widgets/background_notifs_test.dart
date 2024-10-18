// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BackgroundNotifsTest extends StatefulWidget {
  const BackgroundNotifsTest({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<BackgroundNotifsTest> createState() => _BackgroundNotifsTestState();
}

class _BackgroundNotifsTestState extends State<BackgroundNotifsTest> {
  String text = "Stop Service";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<Map<String, dynamic>?>(
          stream: FlutterBackgroundService().on('update'),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final data = snapshot.data!;
            String? device = data["device"];
            DateTime? date = DateTime.tryParse(data["current_date"]);
            return Column(
              children: [
                Text(device ?? 'Unknown'),
                Text(date.toString()),
              ],
            );
          },
        ),
        ElevatedButton(
          child: const Text("Foreground Mode"),
          onPressed: () => FlutterBackgroundService().invoke("setAsForeground"),
        ),
        ElevatedButton(
          child: const Text("Background Mode"),
          onPressed: () => FlutterBackgroundService().invoke("setAsBackground"),
        ),
        ElevatedButton(
          child: Text(text),
          onPressed: () async {
            final service = FlutterBackgroundService();
            var isRunning = await service.isRunning();
            isRunning ? service.invoke("stopService") : service.startService();

            setState(() {
              text = isRunning ? 'Start Service' : 'Stop Service';
            });
          },
        ),
        const Expanded(
          child: LogView(),
        ),
      ],
    );
  }
}

class LogView extends StatefulWidget {
  const LogView({Key? key}) : super(key: key);

  @override
  State<LogView> createState() => _LogViewState();
}

class _LogViewState extends State<LogView> {
  late final Timer timer;
  List<String> logs = [];

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      await sp.reload();
      logs = sp.getStringList('log') ?? [];
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: logs.length,
      itemBuilder: (context, index) {
        final log = logs.elementAt(index);
        return Text(log);
      },
    );
  }
}
