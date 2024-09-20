import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/components/image_uploader_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'new_trip_model.dart';
export 'new_trip_model.dart';

class NewTripWidget extends StatefulWidget {
  const NewTripWidget({super.key});

  @override
  State<NewTripWidget> createState() => _NewTripWidgetState();
}

class _NewTripWidgetState extends State<NewTripWidget> {
  late NewTripModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NewTripModel());

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FFButtonWidget(
                              onPressed: () async {
                                context.safePop();
                              },
                              text: 'Back',
                              icon: Icon(
                                Icons.keyboard_backspace,
                                size: 15.0,
                              ),
                              options: FFButtonOptions(
                                height: 40.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: Colors.transparent,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Inter Tight',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                    ),
                                elevation: 0.0,
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).primary,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'New Trip',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context)
                              .displayMedium
                              .override(
                                fontFamily: 'Inter Tight',
                                letterSpacing: 0.0,
                              ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Give your trip a unique name:',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .override(
                                    fontFamily: 'Inter Tight',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            Container(
                              width: 200.0,
                              child: TextFormField(
                                controller: _model.textController1,
                                focusNode: _model.textFieldFocusNode1,
                                onChanged: (_) => EasyDebounce.debounce(
                                  '_model.textController1',
                                  Duration(milliseconds: 0),
                                  () => safeSetState(() {}),
                                ),
                                autofocus: false,
                                obscureText: false,
                                decoration: InputDecoration(
                                  isDense: true,
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                  hintText: 'Trip name',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        letterSpacing: 0.0,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                    ),
                                cursorColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                validator: _model.textController1Validator
                                    .asValidator(context),
                              ),
                            ),
                          ].divide(SizedBox(height: 16.0)),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Share this trip with someone?',
                                  style: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .override(
                                        fontFamily: 'Inter Tight',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                Text(
                                  'Enter their Travel Voice email below.',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                            Container(
                              width: 200.0,
                              child: TextFormField(
                                controller: _model.textController2,
                                focusNode: _model.textFieldFocusNode2,
                                onChanged: (_) => EasyDebounce.debounce(
                                  '_model.textController2',
                                  Duration(milliseconds: 0),
                                  () => safeSetState(() {}),
                                ),
                                autofocus: false,
                                obscureText: false,
                                decoration: InputDecoration(
                                  isDense: true,
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                  hintText: 'example@email.com',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        letterSpacing: 0.0,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                    ),
                                cursorColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                validator: _model.textController2Validator
                                    .asValidator(context),
                              ),
                            ),
                          ].divide(SizedBox(height: 16.0)),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 200.0,
                              height: 200.0,
                              decoration: BoxDecoration(),
                              child: wrapWithModel(
                                model: _model.imageUploaderModel,
                                updateCallback: () => safeSetState(() {}),
                                child: ImageUploaderWidget(
                                  onUpload: (file) async {
                                    if (file != null &&
                                        (file.bytes?.isNotEmpty ?? false)) {
                                      _model.photo = file;
                                      safeSetState(() {});
                                    }
                                  },
                                  onRemove: () async {
                                    _model.photo = null;
                                    safeSetState(() {});
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              32.0, 0.0, 32.0, 0.0),
                          child: FFButtonWidget(
                            onPressed: (_model.textController1.text == null ||
                                    _model.textController1.text == '')
                                ? null
                                : () async {
                                    _model.usersRequests =
                                        await actions.getOrCreateRequestOnce(
                                      currentUserReference!,
                                    );
                                    if (_model.photo != null &&
                                        (_model.photo?.bytes?.isNotEmpty ??
                                            false)) {
                                      {
                                        safeSetState(() =>
                                            _model.isDataUploading = true);
                                        var selectedUploadedFiles =
                                            <FFUploadedFile>[];
                                        var selectedMedia = <SelectedFile>[];
                                        var downloadUrls = <String>[];
                                        try {
                                          selectedUploadedFiles =
                                              _model.photo!.bytes!.isNotEmpty
                                                  ? [_model.photo!]
                                                  : <FFUploadedFile>[];
                                          selectedMedia =
                                              selectedFilesFromUploadedFiles(
                                            selectedUploadedFiles,
                                          );
                                          downloadUrls = (await Future.wait(
                                            selectedMedia.map(
                                              (m) async => await uploadData(
                                                  m.storagePath, m.bytes),
                                            ),
                                          ))
                                              .where((u) => u != null)
                                              .map((u) => u!)
                                              .toList();
                                        } finally {
                                          _model.isDataUploading = false;
                                        }
                                        if (selectedUploadedFiles.length ==
                                                selectedMedia.length &&
                                            downloadUrls.length ==
                                                selectedMedia.length) {
                                          safeSetState(() {
                                            _model.uploadedLocalFile =
                                                selectedUploadedFiles.first;
                                            _model.uploadedFileUrl =
                                                downloadUrls.first;
                                          });
                                        } else {
                                          safeSetState(() {});
                                          return;
                                        }
                                      }

                                      var tripRecordReference1 =
                                          TripRecord.collection.doc();
                                      await tripRecordReference1.set({
                                        ...createTripRecordData(
                                          name: _model.textController1.text,
                                          creationDate: getCurrentTimestamp,
                                          editDate: getCurrentTimestamp,
                                          image: _model.uploadedFileUrl,
                                          ownedBy: currentUserReference,
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'members': [currentUserReference],
                                          },
                                        ),
                                      });
                                      _model.newTripA =
                                          TripRecord.getDocumentFromData({
                                        ...createTripRecordData(
                                          name: _model.textController1.text,
                                          creationDate: getCurrentTimestamp,
                                          editDate: getCurrentTimestamp,
                                          image: _model.uploadedFileUrl,
                                          ownedBy: currentUserReference,
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'members': [currentUserReference],
                                          },
                                        ),
                                      }, tripRecordReference1);

                                      await _model.usersRequests!.reference
                                          .update({
                                        ...mapToFirestore(
                                          {
                                            'joinedTrips':
                                                FieldValue.arrayUnion([
                                              _model.newTripA?.reference
                                            ]),
                                          },
                                        ),
                                      });
                                      FFAppState().currentTrip =
                                          _model.newTripA?.reference;
                                      safeSetState(() {});
                                    } else {
                                      var tripRecordReference2 =
                                          TripRecord.collection.doc();
                                      await tripRecordReference2.set({
                                        ...createTripRecordData(
                                          name: _model.textController1.text,
                                          creationDate: getCurrentTimestamp,
                                          editDate: getCurrentTimestamp,
                                          ownedBy: currentUserReference,
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'members': [currentUserReference],
                                          },
                                        ),
                                      });
                                      _model.newTripB =
                                          TripRecord.getDocumentFromData({
                                        ...createTripRecordData(
                                          name: _model.textController1.text,
                                          creationDate: getCurrentTimestamp,
                                          editDate: getCurrentTimestamp,
                                          ownedBy: currentUserReference,
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'members': [currentUserReference],
                                          },
                                        ),
                                      }, tripRecordReference2);

                                      await _model.usersRequests!.reference
                                          .update({
                                        ...mapToFirestore(
                                          {
                                            'joinedTrips':
                                                FieldValue.arrayUnion([
                                              _model.newTripB?.reference
                                            ]),
                                          },
                                        ),
                                      });
                                      FFAppState().currentTrip =
                                          _model.newTripB?.reference;
                                      safeSetState(() {});
                                    }

                                    if (Navigator.of(context).canPop()) {
                                      context.pop();
                                    }
                                    context.pushNamed('Logs');

                                    safeSetState(() {});
                                  },
                            text: 'Create trip',
                            options: FFButtonOptions(
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Inter Tight',
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                  ),
                              elevation: 0.0,
                              borderRadius: BorderRadius.circular(8.0),
                              disabledColor:
                                  FlutterFlowTheme.of(context).tertiary,
                              disabledTextColor:
                                  FlutterFlowTheme.of(context).alternate,
                            ),
                          ),
                        ),
                      ]
                          .divide(SizedBox(height: 32.0))
                          .addToStart(SizedBox(height: 16.0))
                          .addToEnd(SizedBox(height: 16.0)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
