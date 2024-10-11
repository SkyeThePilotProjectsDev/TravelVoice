import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/upload_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'image_uploader_model.dart';
export 'image_uploader_model.dart';

class ImageUploaderWidget extends StatefulWidget {
  const ImageUploaderWidget({
    super.key,
    this.defaultImage,
    this.onUpload,
    required this.onRemove,
  });

  final String? defaultImage;
  final Future Function(FFUploadedFile file)? onUpload;
  final Future Function()? onRemove;

  @override
  State<ImageUploaderWidget> createState() => _ImageUploaderWidgetState();
}

class _ImageUploaderWidgetState extends State<ImageUploaderWidget> {
  late ImageUploaderModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ImageUploaderModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (_model.newImage != null &&
            (_model.newImage?.bytes?.isNotEmpty ?? false)) {
          return Stack(
            children: [
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  _model.showMenu = !_model.showMenu;
                  safeSetState(() {});
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0.0),
                  child: Image.memory(
                    _model.newImage?.bytes ?? Uint8List.fromList([]),
                    width: 200.0,
                    height: 200.0,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Opacity(
                opacity: 0.5,
                child: Align(
                  alignment: AlignmentDirectional(-1.0, 1.0),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    curve: Curves.easeInOut,
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: valueOrDefault<double>(
                      _model.showMenu ? 40.0 : 0.0,
                      40.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: FlutterFlowIconButton(
                            borderRadius: 0.0,
                            buttonSize: 40.0,
                            fillColor: FlutterFlowTheme.of(context).primary,
                            icon: Icon(
                              Icons.upload_rounded,
                              color: FlutterFlowTheme.of(context).info,
                              size: 24.0,
                            ),
                            onPressed: () async {
                              // ChangeUploaded
                              final selectedMedia =
                                  await selectMediaWithSourceBottomSheet(
                                context: context,
                                allowPhoto: true,
                              );
                              if (selectedMedia != null &&
                                  selectedMedia.every((m) => validateFileFormat(
                                      m.storagePath, context))) {
                                safeSetState(
                                    () => _model.isDataUploading1 = true);
                                var selectedUploadedFiles = <FFUploadedFile>[];

                                try {
                                  selectedUploadedFiles = selectedMedia
                                      .map((m) => FFUploadedFile(
                                            name: m.storagePath.split('/').last,
                                            bytes: m.bytes,
                                            height: m.dimensions?.height,
                                            width: m.dimensions?.width,
                                            blurHash: m.blurHash,
                                          ))
                                      .toList();
                                } finally {
                                  _model.isDataUploading1 = false;
                                }
                                if (selectedUploadedFiles.length ==
                                    selectedMedia.length) {
                                  safeSetState(() {
                                    _model.uploadedLocalFile1 =
                                        selectedUploadedFiles.first;
                                  });
                                } else {
                                  safeSetState(() {});
                                  return;
                                }
                              }

                              _model.newImage = _model.uploadedLocalFile1;
                              _model.removedImage = false;
                              _model.showMenu = false;
                              safeSetState(() {});
                              await widget.onUpload?.call(
                                _model.newImage!,
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 0.0,
                            buttonSize: 40.0,
                            fillColor: FlutterFlowTheme.of(context).error,
                            icon: Icon(
                              Icons.clear_rounded,
                              color: FlutterFlowTheme.of(context).info,
                              size: 24.0,
                            ),
                            onPressed: () async {
                              _model.newImage = null;
                              _model.showMenu = false;
                              _model.removedImage = true;
                              safeSetState(() {});
                              await widget.onRemove?.call();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        } else if ((widget!.defaultImage != null &&
                widget!.defaultImage != '') &&
            !_model.removedImage) {
          return Stack(
            children: [
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  _model.showMenu = !_model.showMenu;
                  safeSetState(() {});
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0.0),
                  child: Image.network(
                    widget!.defaultImage!,
                    width: 200.0,
                    height: 200.0,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Opacity(
                opacity: 0.75,
                child: Align(
                  alignment: AlignmentDirectional(-1.0, 1.0),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    curve: Curves.easeInOut,
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: valueOrDefault<double>(
                      _model.showMenu ? 40.0 : 0.0,
                      40.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Opacity(
                            opacity: 0.75,
                            child: FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 0.0,
                              buttonSize: 40.0,
                              fillColor: FlutterFlowTheme.of(context).primary,
                              icon: Icon(
                                Icons.upload_rounded,
                                color: FlutterFlowTheme.of(context).info,
                                size: 24.0,
                              ),
                              onPressed: () async {
                                // ChangeUploaded
                                final selectedMedia =
                                    await selectMediaWithSourceBottomSheet(
                                  context: context,
                                  allowPhoto: true,
                                );
                                if (selectedMedia != null &&
                                    selectedMedia.every((m) =>
                                        validateFileFormat(
                                            m.storagePath, context))) {
                                  safeSetState(
                                      () => _model.isDataUploading2 = true);
                                  var selectedUploadedFiles =
                                      <FFUploadedFile>[];

                                  try {
                                    selectedUploadedFiles = selectedMedia
                                        .map((m) => FFUploadedFile(
                                              name:
                                                  m.storagePath.split('/').last,
                                              bytes: m.bytes,
                                              height: m.dimensions?.height,
                                              width: m.dimensions?.width,
                                              blurHash: m.blurHash,
                                            ))
                                        .toList();
                                  } finally {
                                    _model.isDataUploading2 = false;
                                  }
                                  if (selectedUploadedFiles.length ==
                                      selectedMedia.length) {
                                    safeSetState(() {
                                      _model.uploadedLocalFile2 =
                                          selectedUploadedFiles.first;
                                    });
                                  } else {
                                    safeSetState(() {});
                                    return;
                                  }
                                }

                                _model.newImage = _model.uploadedLocalFile2;
                                _model.removedImage = false;
                                _model.showMenu = false;
                                safeSetState(() {});
                                await widget.onUpload?.call(
                                  _model.newImage!,
                                );
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Opacity(
                            opacity: 0.75,
                            child: FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 0.0,
                              buttonSize: 40.0,
                              fillColor: FlutterFlowTheme.of(context).error,
                              icon: Icon(
                                Icons.clear_rounded,
                                color: FlutterFlowTheme.of(context).info,
                                size: 24.0,
                              ),
                              onPressed: () async {
                                _model.newImage = null;
                                _model.showMenu = false;
                                _model.removedImage = true;
                                safeSetState(() {});
                                await widget.onRemove?.call();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return Stack(
            children: [
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  if (widget!.defaultImage == null ||
                      widget!.defaultImage == '') {
                    final selectedMedia =
                        await selectMediaWithSourceBottomSheet(
                      context: context,
                      allowPhoto: true,
                    );
                    if (selectedMedia != null &&
                        selectedMedia.every((m) =>
                            validateFileFormat(m.storagePath, context))) {
                      safeSetState(() => _model.isDataUploading3 = true);
                      var selectedUploadedFiles = <FFUploadedFile>[];

                      try {
                        selectedUploadedFiles = selectedMedia
                            .map((m) => FFUploadedFile(
                                  name: m.storagePath.split('/').last,
                                  bytes: m.bytes,
                                  height: m.dimensions?.height,
                                  width: m.dimensions?.width,
                                  blurHash: m.blurHash,
                                ))
                            .toList();
                      } finally {
                        _model.isDataUploading3 = false;
                      }
                      if (selectedUploadedFiles.length ==
                          selectedMedia.length) {
                        safeSetState(() {
                          _model.uploadedLocalFile3 =
                              selectedUploadedFiles.first;
                        });
                      } else {
                        safeSetState(() {});
                        return;
                      }
                    }

                    _model.newImage = _model.uploadedLocalFile3;
                    _model.showMenu = false;
                    _model.removedImage = false;
                    safeSetState(() {});
                    await widget.onUpload?.call(
                      _model.newImage!,
                    );
                  } else {
                    _model.showMenu = !_model.showMenu;
                    safeSetState(() {});
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).primaryText,
                      width: 2.0,
                    ),
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).primaryText,
                          width: 2.0,
                        ),
                      ),
                      child: Icon(
                        Icons.add_rounded,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 40.0,
                      ),
                    ),
                  ),
                ),
              ),
              Opacity(
                opacity: 0.5,
                child: Align(
                  alignment: AlignmentDirectional(-1.0, 1.0),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    curve: Curves.easeInOut,
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: valueOrDefault<double>(
                      _model.showMenu ? 40.0 : 0.0,
                      40.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 0.0,
                            buttonSize: 40.0,
                            fillColor: FlutterFlowTheme.of(context).primary,
                            icon: Icon(
                              Icons.upload_rounded,
                              color: FlutterFlowTheme.of(context).info,
                              size: 24.0,
                            ),
                            onPressed: () async {
                              // ChangeUploaded
                              final selectedMedia =
                                  await selectMediaWithSourceBottomSheet(
                                context: context,
                                allowPhoto: true,
                              );
                              if (selectedMedia != null &&
                                  selectedMedia.every((m) => validateFileFormat(
                                      m.storagePath, context))) {
                                safeSetState(
                                    () => _model.isDataUploading4 = true);
                                var selectedUploadedFiles = <FFUploadedFile>[];

                                try {
                                  selectedUploadedFiles = selectedMedia
                                      .map((m) => FFUploadedFile(
                                            name: m.storagePath.split('/').last,
                                            bytes: m.bytes,
                                            height: m.dimensions?.height,
                                            width: m.dimensions?.width,
                                            blurHash: m.blurHash,
                                          ))
                                      .toList();
                                } finally {
                                  _model.isDataUploading4 = false;
                                }
                                if (selectedUploadedFiles.length ==
                                    selectedMedia.length) {
                                  safeSetState(() {
                                    _model.uploadedLocalFile4 =
                                        selectedUploadedFiles.first;
                                  });
                                } else {
                                  safeSetState(() {});
                                  return;
                                }
                              }

                              _model.newImage = _model.uploadedLocalFile4;
                              _model.removedImage = false;
                              _model.showMenu = false;
                              safeSetState(() {});
                              await widget.onUpload?.call(
                                _model.newImage!,
                              );
                            },
                          ),
                        ),
                        if (widget!.defaultImage != null &&
                            widget!.defaultImage != '')
                          Expanded(
                            child: FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 0.0,
                              buttonSize: 40.0,
                              fillColor: FlutterFlowTheme.of(context).warning,
                              icon: Icon(
                                Icons.restart_alt_rounded,
                                color: FlutterFlowTheme.of(context).info,
                                size: 24.0,
                              ),
                              onPressed: () async {
                                _model.removedImage = false;
                                _model.showMenu = false;
                                _model.newImage = null;
                                safeSetState(() {});
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
