import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/pages/trip/log/create_recording/create_recording_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'upload_audio_model.dart';
export 'upload_audio_model.dart';

class UploadAudioWidget extends StatefulWidget {
  const UploadAudioWidget({super.key});

  @override
  State<UploadAudioWidget> createState() => _UploadAudioWidgetState();
}

class _UploadAudioWidgetState extends State<UploadAudioWidget> {
  late UploadAudioModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UploadAudioModel());
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
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FFButtonWidget(
              onPressed: () async {
                await showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor:
                      FlutterFlowTheme.of(context).primaryBackground,
                  enableDrag: false,
                  useSafeArea: true,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: MediaQuery.viewInsetsOf(context),
                      child: CreateRecordingWidget(),
                    );
                  },
                ).then((value) => safeSetState(() => _model.recording = value));

                Navigator.pop(context, _model.recording);

                safeSetState(() {});
              },
              text: 'Record',
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
            FFButtonWidget(
              onPressed: () async {
                final selectedFiles = await selectFiles(
                  allowedExtensions: ['mp3'],
                  multiFile: false,
                );
                if (selectedFiles != null) {
                  safeSetState(() => _model.isDataUploading = true);
                  var selectedUploadedFiles = <FFUploadedFile>[];

                  try {
                    selectedUploadedFiles = selectedFiles
                        .map((m) => FFUploadedFile(
                              name: m.storagePath.split('/').last,
                              bytes: m.bytes,
                            ))
                        .toList();
                  } finally {
                    _model.isDataUploading = false;
                  }
                  if (selectedUploadedFiles.length == selectedFiles.length) {
                    safeSetState(() {
                      _model.uploadedLocalFile = selectedUploadedFiles.first;
                    });
                  } else {
                    safeSetState(() {});
                    return;
                  }
                }

                if (_model.uploadedLocalFile != null &&
                    (_model.uploadedLocalFile.bytes?.isNotEmpty ?? false)) {
                  _model.filePath = await actions.getFileAudioPath(
                    _model.uploadedLocalFile,
                  );
                  Navigator.pop(context, _model.filePath);
                }

                safeSetState(() {});
              },
              text: 'Upload',
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
          ].divide(SizedBox(width: 16.0)),
        ),
      ),
    );
  }
}
