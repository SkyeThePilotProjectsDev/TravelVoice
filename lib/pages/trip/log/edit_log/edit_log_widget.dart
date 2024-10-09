import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/schema/structs/index.dart';
import '/components/date_picker_widget.dart';
import '/components/image_uploader_widget.dart';
import '/components/place_suggestions_widget.dart';
import '/flutter_flow/flutter_flow_audio_player.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/pages/trip/log/create_recording/create_recording_widget.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'edit_log_model.dart';
export 'edit_log_model.dart';

class EditLogWidget extends StatefulWidget {
  const EditLogWidget({
    super.key,
    required this.trip,
    this.log,
  });

  final DocumentReference? trip;
  final LogRecord? log;

  @override
  State<EditLogWidget> createState() => _EditLogWidgetState();
}

class _EditLogWidgetState extends State<EditLogWidget> {
  late EditLogModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditLogModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (widget!.log != null) {
        _model.selectedDate = widget!.log?.eventDate;
        _model.recordings = widget!.log!.recordings.toList().cast<String>();
        _model.selectedPlace = functions.locationToPlace(widget!.log?.location);
        safeSetState(() {});
      } else {
        _model.selectedDate = getCurrentTimestamp;
        _model.addToRecordings(functions.emptyAudio());
        safeSetState(() {});
        await showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          enableDrag: false,
          useSafeArea: true,
          context: context,
          builder: (context) {
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Padding(
                padding: MediaQuery.viewInsetsOf(context),
                child: CreateRecordingWidget(),
              ),
            );
          },
        ).then((value) => safeSetState(() => _model.recordingInit = value));

        if (_model.recordingInit != null && _model.recordingInit != '') {
          _model.addToRecordings(_model.recordingInit!);
          safeSetState(() {});
        }
        await _model.cleanAudio(context);
        safeSetState(() {});
      }
    });

    _model.textFieldCityTextController ??= TextEditingController(
        text: widget!.log != null ? widget!.log?.location?.locationText : '');
    _model.textFieldCityFocusNode ??= FocusNode();

    _model.textFieldNotesTextController ??= TextEditingController(
        text: (widget!.log != null) &&
                (widget!.log?.notes != null && widget!.log?.notes != '')
            ? widget!.log?.notes
            : '');
    _model.textFieldNotesFocusNode ??= FocusNode();
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          var confirmDialogResponse = await showDialog<bool>(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('Discard Log'),
                                    content: Text(
                                        'If you leave this page this log\'s data will be lost'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(
                                            alertDialogContext, false),
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pop(
                                            alertDialogContext, true),
                                        child: Text('Confirm'),
                                      ),
                                    ],
                                  );
                                },
                              ) ??
                              false;
                          if (confirmDialogResponse) {
                            context.safePop();
                          }
                        },
                        child: Icon(
                          Icons.chevron_left_rounded,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 40.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 1.0, 0.0),
                    child: Form(
                      key: _model.formKey,
                      autovalidateMode: AutovalidateMode.disabled,
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Builder(
                                          builder: (context) {
                                            final takenRecordings =
                                                _model.recordings.toList();

                                            return Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: List.generate(
                                                  takenRecordings.length,
                                                  (takenRecordingsIndex) {
                                                final takenRecordingsItem =
                                                    takenRecordings[
                                                        takenRecordingsIndex];
                                                return Builder(
                                                  builder: (context) {
                                                    if (takenRecordingsItem !=
                                                        functions
                                                            .emptyAudio()) {
                                                      return Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Expanded(
                                                            child: Container(
                                                              height: 85.0,
                                                              child: Stack(
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          50.0,
                                                                      height:
                                                                          50.0,
                                                                      child: custom_widgets
                                                                          .LoadingWidget(
                                                                        width:
                                                                            50.0,
                                                                        height:
                                                                            50.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                    ),
                                                                    child:
                                                                        FlutterFlowAudioPlayer(
                                                                      audio: Audio
                                                                          .network(
                                                                        takenRecordingsItem,
                                                                        metas:
                                                                            Metas(
                                                                          title:
                                                                              'Recording ${(takenRecordingsIndex + 1).toString()}',
                                                                        ),
                                                                      ),
                                                                      titleTextStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleLarge
                                                                          .override(
                                                                            fontFamily:
                                                                                'Inter Tight',
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                      playbackDurationTextStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Inter',
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondary,
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                      fillColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .primaryBackground,
                                                                      playbackButtonColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .primary,
                                                                      activeTrackColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .primary,
                                                                      inactiveTrackColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .alternate,
                                                                      elevation:
                                                                          0.0,
                                                                      playInBackground:
                                                                          PlayInBackground
                                                                              .disabledRestoreOnForeground,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              var confirmDialogResponse =
                                                                  await showDialog<
                                                                          bool>(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (alertDialogContext) {
                                                                          return AlertDialog(
                                                                            title:
                                                                                Text('Are you sure you want to delete this recording?'),
                                                                            content:
                                                                                Text('You won\'t be able to get it back.'),
                                                                            actions: [
                                                                              TextButton(
                                                                                onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                                child: Text('Cancel'),
                                                                              ),
                                                                              TextButton(
                                                                                onPressed: () => Navigator.pop(alertDialogContext, true),
                                                                                child: Text('Delete'),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        },
                                                                      ) ??
                                                                      false;
                                                              if (confirmDialogResponse) {
                                                                _model.removeAtIndexFromRecordings(
                                                                    takenRecordingsIndex);
                                                                safeSetState(
                                                                    () {});
                                                              }
                                                            },
                                                            child: FaIcon(
                                                              FontAwesomeIcons
                                                                  .trash,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                              size: 20.0,
                                                            ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            width: 8.0)),
                                                      );
                                                    } else {
                                                      return Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            width: 50.0,
                                                            height: 50.0,
                                                            child: custom_widgets
                                                                .LoadingWidget(
                                                              width: 50.0,
                                                              height: 50.0,
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    }
                                                  },
                                                );
                                              }).divide(SizedBox(height: 4.0)),
                                            );
                                          },
                                        ),
                                        FFButtonWidget(
                                          onPressed: () async {
                                            await showModalBottomSheet(
                                              isScrollControlled: true,
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              enableDrag: false,
                                              useSafeArea: true,
                                              context: context,
                                              builder: (context) {
                                                return GestureDetector(
                                                  onTap: () =>
                                                      FocusScope.of(context)
                                                          .unfocus(),
                                                  child: Padding(
                                                    padding:
                                                        MediaQuery.viewInsetsOf(
                                                            context),
                                                    child:
                                                        CreateRecordingWidget(),
                                                  ),
                                                );
                                              },
                                            ).then((value) => safeSetState(() =>
                                                _model.recording = value));

                                            _model.addToRecordings(
                                                functions.emptyAudio());
                                            safeSetState(() {});
                                            if (_model.recording != null &&
                                                _model.recording != '') {
                                              _model.addToRecordings(
                                                  _model.recording!);
                                              safeSetState(() {});
                                            }
                                            await _model.cleanAudio(context);
                                            safeSetState(() {});

                                            safeSetState(() {});
                                          },
                                          text: 'Add Recording +',
                                          options: FFButtonOptions(
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Inter Tight',
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                    ),
                                            elevation: 0.0,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 8.0)),
                                    ),
                                    Divider(
                                      thickness: 2.0,
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              'City: ',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                width: 200.0,
                                                child: TextFormField(
                                                  controller: _model
                                                      .textFieldCityTextController,
                                                  focusNode: _model
                                                      .textFieldCityFocusNode,
                                                  onChanged: (_) =>
                                                      EasyDebounce.debounce(
                                                    '_model.textFieldCityTextController',
                                                    Duration(milliseconds: 0),
                                                    () async {
                                                      _model.placeSelected =
                                                          false;
                                                      safeSetState(() {});
                                                    },
                                                  ),
                                                  autofocus: false,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    isDense: false,
                                                    labelStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          letterSpacing: 0.0,
                                                        ),
                                                    hintText: 'Tokyo, Japan',
                                                    hintStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .alternate,
                                                          letterSpacing: 0.0,
                                                        ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    filled: true,
                                                    fillColor: FlutterFlowTheme
                                                            .of(context)
                                                        .secondaryBackground,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        letterSpacing: 0.0,
                                                      ),
                                                  cursorColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                  validator: _model
                                                      .textFieldCityTextControllerValidator
                                                      .asValidator(context),
                                                ),
                                              ),
                                            ),
                                          ].divide(SizedBox(width: 8.0)),
                                        ),
                                        if ((_model.textFieldCityFocusNode
                                                    ?.hasFocus ??
                                                false) &&
                                            (_model.textFieldCityTextController
                                                        .text !=
                                                    null &&
                                                _model.textFieldCityTextController
                                                        .text !=
                                                    '') &&
                                            !_model.placeSelected)
                                          wrapWithModel(
                                            model: _model.placeSuggestionsModel,
                                            updateCallback: () =>
                                                safeSetState(() {}),
                                            child: PlaceSuggestionsWidget(
                                              query: _model
                                                  .textFieldCityTextController
                                                  .text,
                                              onSelect: (suggestion) async {
                                                if (suggestion != null) {
                                                  _model.selectedPlace =
                                                      suggestion;
                                                  _model.placeSelected = true;
                                                  safeSetState(() {});
                                                  safeSetState(() {
                                                    _model.textFieldCityTextController
                                                            ?.text =
                                                        suggestion
                                                            .formattedAddress;
                                                    _model.textFieldCityTextController
                                                            ?.selection =
                                                        TextSelection.collapsed(
                                                            offset: _model
                                                                .textFieldCityTextController!
                                                                .text
                                                                .length);
                                                  });
                                                }
                                              },
                                            ),
                                          ),
                                      ].divide(SizedBox(
                                          height: (_model.textFieldCityFocusNode
                                                          ?.hasFocus ??
                                                      false) &&
                                                  (_model.textFieldCityTextController
                                                              .text !=
                                                          null &&
                                                      _model.textFieldCityTextController
                                                              .text !=
                                                          '')
                                              ? 8.0
                                              : 0.0)),
                                    ),
                                    Divider(
                                      thickness: 2.0,
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          'Date: ',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Inter',
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                        Expanded(
                                          child: wrapWithModel(
                                            model: _model.datePickerModel,
                                            updateCallback: () =>
                                                safeSetState(() {}),
                                            child: DatePickerWidget(
                                              defaultDate:
                                                  _model.selectedDate != null
                                                      ? _model.selectedDate!
                                                      : getCurrentTimestamp,
                                              onChange: (setDate) async {
                                                _model.selectedDate = setDate;
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      thickness: 2.0,
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Notes:',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Inter',
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                        TextFormField(
                                          controller: _model
                                              .textFieldNotesTextController,
                                          focusNode:
                                              _model.textFieldNotesFocusNode,
                                          autofocus: false,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            isDense: false,
                                            labelStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                      fontFamily: 'Inter',
                                                      letterSpacing: 0.0,
                                                    ),
                                            hintText: 'Type notes here',
                                            hintStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                      fontFamily: 'Inter',
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      letterSpacing: 0.0,
                                                    ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            filled: true,
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Inter',
                                                letterSpacing: 0.0,
                                              ),
                                          maxLines: null,
                                          minLines: 3,
                                          cursorColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryText,
                                          validator: _model
                                              .textFieldNotesTextControllerValidator
                                              .asValidator(context),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      thickness: 2.0,
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Photo:',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Inter',
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Container(
                                            width: 200.0,
                                            height: 200.0,
                                            decoration: BoxDecoration(),
                                            child: wrapWithModel(
                                              model: _model.imageUploaderModel,
                                              updateCallback: () =>
                                                  safeSetState(() {}),
                                              child: ImageUploaderWidget(
                                                defaultImage: (widget!.log !=
                                                            null) &&
                                                        (widget!.log?.photo !=
                                                                null &&
                                                            widget!.log
                                                                    ?.photo !=
                                                                '')
                                                    ? widget!.log?.photo
                                                    : null,
                                                onUpload: (file) async {
                                                  _model.image = file;
                                                  safeSetState(() {});
                                                },
                                                onRemove: () async {
                                                  _model.image = null;
                                                  safeSetState(() {});
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!(_model.recordings.isNotEmpty))
                        Text(
                          '* There needs to be at least 1 recording',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Inter',
                                    color: FlutterFlowTheme.of(context).error,
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      if (_model.selectedPlace == null)
                        Text(
                          '* A city needs to be selected',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Inter',
                                    color: FlutterFlowTheme.of(context).error,
                                    letterSpacing: 0.0,
                                  ),
                        ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FFButtonWidget(
                      onPressed: (!(_model.recordings.isNotEmpty) ||
                              (_model.selectedPlace == null))
                          ? null
                          : () async {
                              if (_model.image != null &&
                                  (_model.image?.bytes?.isNotEmpty ?? false)) {
                                {
                                  safeSetState(
                                      () => _model.isDataUploading = true);
                                  var selectedUploadedFiles =
                                      <FFUploadedFile>[];
                                  var selectedMedia = <SelectedFile>[];
                                  var downloadUrls = <String>[];
                                  try {
                                    selectedUploadedFiles =
                                        _model.image!.bytes!.isNotEmpty
                                            ? [_model.image!]
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

                                _model.newImage = _model.uploadedFileUrl;
                              }
                              if (widget!.log != null) {
                                await widget!.log!.reference.update({
                                  ...createLogRecordData(
                                    location: updateLocationDataStruct(
                                      functions.placeToLocation(
                                          _model.selectedPlace),
                                      clearUnsetFields: false,
                                    ),
                                    eventDate: _model.selectedDate,
                                    notes: _model
                                        .textFieldNotesTextController.text,
                                    photo: _model.newImage,
                                    editDate: getCurrentTimestamp,
                                  ),
                                  ...mapToFirestore(
                                    {
                                      'recordings': _model.recordings,
                                    },
                                  ),
                                });
                              } else {
                                var logRecordReference =
                                    LogRecord.createDoc(widget!.trip!);
                                await logRecordReference.set({
                                  ...createLogRecordData(
                                    eventDate: _model.selectedDate,
                                    notes: _model
                                        .textFieldNotesTextController.text,
                                    photo: _model.uploadedFileUrl,
                                    createdBy: currentUserReference,
                                    ownedBy: currentUserReference,
                                    editDate: getCurrentTimestamp,
                                    creationDate: getCurrentTimestamp,
                                    location: updateLocationDataStruct(
                                      LocationDataStruct(
                                        locationText: _model
                                            .selectedPlace?.formattedAddress,
                                        location: functions.locationParser(
                                            _model.selectedPlace?.geometry
                                                ?.location),
                                      ),
                                      clearUnsetFields: false,
                                      create: true,
                                    ),
                                  ),
                                  ...mapToFirestore(
                                    {
                                      'recordings': _model.recordings,
                                    },
                                  ),
                                });
                                _model.newLog = LogRecord.getDocumentFromData({
                                  ...createLogRecordData(
                                    eventDate: _model.selectedDate,
                                    notes: _model
                                        .textFieldNotesTextController.text,
                                    photo: _model.uploadedFileUrl,
                                    createdBy: currentUserReference,
                                    ownedBy: currentUserReference,
                                    editDate: getCurrentTimestamp,
                                    creationDate: getCurrentTimestamp,
                                    location: updateLocationDataStruct(
                                      LocationDataStruct(
                                        locationText: _model
                                            .selectedPlace?.formattedAddress,
                                        location: functions.locationParser(
                                            _model.selectedPlace?.geometry
                                                ?.location),
                                      ),
                                      clearUnsetFields: false,
                                      create: true,
                                    ),
                                  ),
                                  ...mapToFirestore(
                                    {
                                      'recordings': _model.recordings,
                                    },
                                  ),
                                }, logRecordReference);
                              }

                              context.safePop();

                              safeSetState(() {});
                            },
                      text: 'Submit',
                      icon: Icon(
                        Icons.check_rounded,
                        size: 15.0,
                      ),
                      options: FFButtonOptions(
                        height: 40.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'Inter Tight',
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                ),
                        elevation: 0.0,
                        borderRadius: BorderRadius.circular(8.0),
                        disabledColor: FlutterFlowTheme.of(context).tertiary,
                        disabledTextColor:
                            FlutterFlowTheme.of(context).alternate,
                      ),
                    ),
                  ],
                ),
              ]
                  .divide(SizedBox(height: 16.0))
                  .addToStart(SizedBox(height: 16.0))
                  .addToEnd(SizedBox(height: 16.0)),
            ),
          ),
        ),
      ),
    );
  }
}
