import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/components/date_picker_widget.dart';
import '/components/image_uploader_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/pages/user/profile_icon/profile_icon_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'edit_trip_model.dart';
export 'edit_trip_model.dart';

class EditTripWidget extends StatefulWidget {
  const EditTripWidget({
    super.key,
    this.trip,
  });

  final TripRecord? trip;

  @override
  State<EditTripWidget> createState() => _EditTripWidgetState();
}

class _EditTripWidgetState extends State<EditTripWidget> {
  late EditTripModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditTripModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.selectedDate = getCurrentTimestamp;
      if (widget!.trip != null) {
        _model.thisTrip = widget!.trip;
        _model.selectedDate =
            (widget!.trip != null) && (widget!.trip?.tripDate != null)
                ? widget!.trip?.tripDate
                : getCurrentTimestamp;
        _model.photoURL = widget!.trip?.image;
      }
    });

    _model.textController1 ??= TextEditingController(
        text: widget!.trip != null ? widget!.trip?.name : '');
    _model.textFieldFocusNode ??= FocusNode();

    _model.textFieldShareTextController ??= TextEditingController();
    _model.textFieldShareFocusNode ??= FocusNode();
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
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.safePop();
                      },
                      child: Icon(
                        Icons.chevron_left_rounded,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 40.0,
                      ),
                    ),
                    if (widget!.trip != null)
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          final firestoreBatch =
                              FirebaseFirestore.instance.batch();
                          try {
                            _model.pendingRequests =
                                await queryTripInvitationRecordOnce(
                              queryBuilder: (tripInvitationRecord) =>
                                  tripInvitationRecord
                                      .where(
                                        'trip',
                                        isEqualTo: widget!.trip?.reference,
                                      )
                                      .where(
                                        'status',
                                        isEqualTo:
                                            RequestStatus.Requested.serialize(),
                                      ),
                            );
                            _model.loopCounter = 0;
                            while (_model.loopCounter <
                                _model.pendingRequests!.length) {
                              firestoreBatch.update(
                                  _model.pendingRequests![_model.loopCounter]
                                      .reference,
                                  createTripInvitationRecordData(
                                    status: RequestStatus.Cancelled,
                                  ));
                              _model.loopCounter = _model.loopCounter + 1;
                            }
                            firestoreBatch.delete(widget!.trip!.reference);
                            context.safePop();
                          } finally {
                            await firestoreBatch.commit();
                          }

                          safeSetState(() {});
                        },
                        child: FaIcon(
                          FontAwesomeIcons.trashAlt,
                          color: FlutterFlowTheme.of(context).error,
                          size: 26.0,
                        ),
                      ),
                  ],
                ),
                Text(
                  widget!.trip != null ? 'Edit Trip' : 'New Trip',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).displayMedium.override(
                        fontFamily: 'Inter Tight',
                        letterSpacing: 0.0,
                      ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Form(
                          key: _model.formKey,
                          autovalidateMode: AutovalidateMode.disabled,
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 16.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'What is the name of this trip?',
                                      textAlign: TextAlign.start,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                    Container(
                                      width: 200.0,
                                      child: TextFormField(
                                        controller: _model.textController1,
                                        focusNode: _model.textFieldFocusNode,
                                        onChanged: (_) => EasyDebounce.debounce(
                                          '_model.textController1',
                                          Duration(milliseconds: 0),
                                          () => safeSetState(() {}),
                                        ),
                                        autofocus: true,
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
                                          hintText: 'Trip name',
                                          hintStyle: FlutterFlowTheme.of(
                                                  context)
                                              .labelMedium
                                              .override(
                                                fontFamily: 'Inter',
                                                color:
                                                    FlutterFlowTheme.of(context)
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
                                        cursorColor:
                                            FlutterFlowTheme.of(context)
                                                .primaryText,
                                        validator: _model
                                            .textController1Validator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 8.0)),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'When was this trip?',
                                      textAlign: TextAlign.start,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                    wrapWithModel(
                                      model: _model.datePickerModel,
                                      updateCallback: () => safeSetState(() {}),
                                      child: DatePickerWidget(
                                        defaultDate: (widget!.trip != null) &&
                                                (widget!.trip?.tripDate != null)
                                            ? widget!.trip!.tripDate!
                                            : getCurrentTimestamp,
                                        onChange: (setDate) async {
                                          _model.selectedDate = setDate;
                                          safeSetState(() {});
                                        },
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 8.0)),
                                ),
                                Divider(
                                  thickness: 1.0,
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Inter',
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ].divide(SizedBox(height: 8.0)),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          width: 200.0,
                                          child: TextFormField(
                                            controller: _model
                                                .textFieldShareTextController,
                                            focusNode:
                                                _model.textFieldShareFocusNode,
                                            onChanged: (_) =>
                                                EasyDebounce.debounce(
                                              '_model.textFieldShareTextController',
                                              Duration(milliseconds: 0),
                                              () async {
                                                _model.isValidEmail = true;
                                                if (_model.formKey
                                                            .currentState ==
                                                        null ||
                                                    !_model
                                                        .formKey.currentState!
                                                        .validate()) {
                                                  _model.isValidEmail = false;
                                                }

                                                safeSetState(() {});
                                              },
                                            ),
                                            onFieldSubmitted: (_) async {
                                              if ((_model.textFieldShareTextController
                                                              .text ==
                                                          null ||
                                                      _model.textFieldShareTextController
                                                              .text ==
                                                          '') ||
                                                  !_model.isValidEmail!) {
                                              } else if (functions.stringEquality(
                                                  _model
                                                      .textFieldShareTextController
                                                      .text,
                                                  currentUserEmail)) {
                                                await showDialog(
                                                  context: context,
                                                  builder:
                                                      (alertDialogContext) {
                                                    return AlertDialog(
                                                      title: Text(
                                                          'Invalid action'),
                                                      content: Text(
                                                          'You can\'t invite yourself!'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  alertDialogContext),
                                                          child: Text('Ok'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              } else if (_model.shareWith
                                                  .where((e) =>
                                                      functions.stringEquality(
                                                          _model
                                                              .textFieldShareTextController
                                                              .text,
                                                          e))
                                                  .toList()
                                                  .isNotEmpty) {
                                                await showDialog(
                                                  context: context,
                                                  builder:
                                                      (alertDialogContext) {
                                                    return AlertDialog(
                                                      title: Text(
                                                          'Invalid action'),
                                                      content: Text(
                                                          'This email has already been selected'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  alertDialogContext),
                                                          child: Text('Ok'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              } else {
                                                _model.insertAtIndexInShareWith(
                                                    0,
                                                    _model
                                                        .textFieldShareTextController
                                                        .text);
                                                safeSetState(() {});
                                                safeSetState(() {
                                                  _model
                                                      .textFieldShareTextController
                                                      ?.clear();
                                                });
                                              }
                                            },
                                            autofocus: false,
                                            textInputAction:
                                                TextInputAction.done,
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
                                              hintText: 'example@email.com',
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
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .alternate,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
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
                                            cursorColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                            validator: _model
                                                .textFieldShareTextControllerValidator
                                                .asValidator(context),
                                          ),
                                        ),
                                        if (_model.textFieldShareTextController
                                                    .text !=
                                                null &&
                                            _model.textFieldShareTextController
                                                    .text !=
                                                '')
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                'Press the',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .alternate,
                                                          letterSpacing: 0.0,
                                                        ),
                                              ),
                                              Icon(
                                                Icons
                                                    .subdirectory_arrow_left_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                size: 24.0,
                                              ),
                                              Text(
                                                'button on your keyboard',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .alternate,
                                                          letterSpacing: 0.0,
                                                        ),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                    SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          if (_model.shareWith.isNotEmpty)
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Text(
                                                  'Invite',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyLarge
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                                Builder(
                                                  builder: (context) {
                                                    final sharedWith = _model
                                                        .shareWith
                                                        .toList();

                                                    return Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: List.generate(
                                                          sharedWith.length,
                                                          (sharedWithIndex) {
                                                        final sharedWithItem =
                                                            sharedWith[
                                                                sharedWithIndex];
                                                        return Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Container(
                                                              width: 30.0,
                                                              height: 30.0,
                                                              decoration:
                                                                  BoxDecoration(),
                                                              child:
                                                                  ProfileIconWidget(
                                                                key: Key(
                                                                    'Keycde_${sharedWithIndex}_of_${sharedWith.length}'),
                                                                input:
                                                                    sharedWithItem,
                                                                padding: 2,
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                '${sharedWithItem} > Awaiting Request',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Inter',
                                                                      letterSpacing:
                                                                          0.0,
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
                                                                _model.removeAtIndexFromShareWith(
                                                                    sharedWithIndex);
                                                                safeSetState(
                                                                    () {});
                                                              },
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  border: Border
                                                                      .all(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .error,
                                                                  ),
                                                                ),
                                                                child: Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            4.0,
                                                                            4.0,
                                                                            4.0,
                                                                            3.0),
                                                                    child:
                                                                        FaIcon(
                                                                      FontAwesomeIcons
                                                                          .minus,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .error,
                                                                      size:
                                                                          16.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ].divide(SizedBox(
                                                              width: 8.0)),
                                                        );
                                                      }).divide(SizedBox(
                                                          height: 4.0)),
                                                    );
                                                  },
                                                ),
                                              ].divide(SizedBox(height: 8.0)),
                                            ),
                                          FutureBuilder<
                                              List<TripInvitationRecord>>(
                                            future:
                                                queryTripInvitationRecordOnce(
                                              queryBuilder: (tripInvitationRecord) =>
                                                  tripInvitationRecord
                                                      .where(
                                                        'trip',
                                                        isEqualTo: widget!
                                                            .trip?.reference,
                                                      )
                                                      .whereIn(
                                                          'status',
                                                          RequestStatus.values
                                                              .where((e) =>
                                                                  (e ==
                                                                      RequestStatus
                                                                          .Requested) ||
                                                                  (e ==
                                                                      RequestStatus
                                                                          .Accepted))
                                                              .toList()
                                                              .map((e) =>
                                                                  e.serialize())
                                                              .toList()),
                                            ),
                                            builder: (context, snapshot) {
                                              // Customize what your widget looks like when it's loading.
                                              if (!snapshot.hasData) {
                                                return Center(
                                                  child: SizedBox(
                                                    width: 50.0,
                                                    height: 50.0,
                                                    child:
                                                        CircularProgressIndicator(
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                              Color>(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                              List<TripInvitationRecord>
                                                  containerOldMembersTripInvitationRecordList =
                                                  snapshot.data!;

                                              return Container(
                                                decoration: BoxDecoration(),
                                                child: Visibility(
                                                  visible:
                                                      (widget!.trip != null) &&
                                                          (widget!.trip!.members
                                                              .isNotEmpty),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: [
                                                      Text(
                                                        'Members',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                      ),
                                                      Builder(
                                                        builder: (context) {
                                                          final oldMembers = containerOldMembersTripInvitationRecordList
                                                              .where((e) =>
                                                                  (e.parentReference !=
                                                                      functions
                                                                          .getPlainInvetationsRef(
                                                                              currentUserEmail)) &&
                                                                  !_model
                                                                      .removedUsers
                                                                      .contains(
                                                                          e.reference))
                                                              .toList();

                                                          return Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: List.generate(
                                                                oldMembers
                                                                    .length,
                                                                (oldMembersIndex) {
                                                              final oldMembersItem =
                                                                  oldMembers[
                                                                      oldMembersIndex];
                                                              return Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Container(
                                                                    width: 30.0,
                                                                    height:
                                                                        30.0,
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    child:
                                                                        ProfileIconWidget(
                                                                      key: Key(
                                                                          'Key1pe_${oldMembersIndex}_of_${oldMembers.length}'),
                                                                      input: oldMembersItem
                                                                          .parentReference
                                                                          .id,
                                                                      padding:
                                                                          2,
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      '${oldMembersItem.parentReference.id} > ${valueOrDefault<String>(
                                                                        oldMembersItem
                                                                            .status
                                                                            ?.name,
                                                                        'Error',
                                                                      )}',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Inter',
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  InkWell(
                                                                    splashColor:
                                                                        Colors
                                                                            .transparent,
                                                                    focusColor:
                                                                        Colors
                                                                            .transparent,
                                                                    hoverColor:
                                                                        Colors
                                                                            .transparent,
                                                                    highlightColor:
                                                                        Colors
                                                                            .transparent,
                                                                    onTap:
                                                                        () async {
                                                                      _model.removeAtIndexFromShareWith(
                                                                          oldMembersIndex);
                                                                      safeSetState(
                                                                          () {});
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).error,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              4.0,
                                                                              4.0,
                                                                              4.0,
                                                                              3.0),
                                                                          child:
                                                                              FaIcon(
                                                                            FontAwesomeIcons.minus,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).error,
                                                                            size:
                                                                                16.0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ].divide(SizedBox(
                                                                    width:
                                                                        8.0)),
                                                              );
                                                            }).divide(SizedBox(
                                                                height: 4.0)),
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ].divide(SizedBox(height: 4.0)),
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 16.0)),
                                ),
                                Divider(
                                  thickness: 1.0,
                                  color: FlutterFlowTheme.of(context).alternate,
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
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: ImageUploaderWidget(
                                          onUpload: (file) async {
                                            if (file != null &&
                                                (file.bytes?.isNotEmpty ??
                                                    false)) {
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
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(32.0, 16.0, 32.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: (_model.textController1.text == null ||
                            _model.textController1.text == '')
                        ? null
                        : () async {
                            var _shouldSetState = false;
                            final firestoreBatch =
                                FirebaseFirestore.instance.batch();
                            try {
                              if (_model.textFieldShareTextController.text !=
                                      null &&
                                  _model.textFieldShareTextController.text !=
                                      '') {
                                var confirmDialogResponse =
                                    await showDialog<bool>(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return AlertDialog(
                                              title: Text(
                                                  'You still have text in your share text box'),
                                              content: Text(
                                                  'Are you sure you want to create this trip without submitting that email?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          alertDialogContext,
                                                          false),
                                                  child: Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          alertDialogContext,
                                                          true),
                                                  child: Text('Confirm'),
                                                ),
                                              ],
                                            );
                                          },
                                        ) ??
                                        false;
                                if (!confirmDialogResponse) {
                                  if (_shouldSetState) safeSetState(() {});
                                  return;
                                }
                              }
                              if (_model.photo != null &&
                                  (_model.photo?.bytes?.isNotEmpty ?? false)) {
                                await actions.printToConsoleAction(
                                  'has photo',
                                );
                                {
                                  safeSetState(
                                      () => _model.isDataUploading = true);
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

                                _model.photoURL = _model.uploadedFileUrl;
                              }
                              if (widget!.trip != null) {
                                firestoreBatch.update(
                                    widget!.trip!.reference,
                                    createTripRecordData(
                                      name: _model.textController1.text,
                                      editDate: getCurrentTimestamp,
                                      image: _model.photoURL,
                                    ));
                              } else {
                                var tripRecordReference =
                                    TripRecord.collection.doc();
                                firestoreBatch.set(tripRecordReference, {
                                  ...createTripRecordData(
                                    name: _model.textController1.text,
                                    creationDate: getCurrentTimestamp,
                                    editDate: getCurrentTimestamp,
                                    image: _model.photoURL,
                                    ownedBy: currentUserReference,
                                    tripDate: _model.selectedDate,
                                  ),
                                  ...mapToFirestore(
                                    {
                                      'members': [currentUserReference],
                                      'shareRequests': _model.shareWith,
                                    },
                                  ),
                                });
                                _model.newTripRef =
                                    TripRecord.getDocumentFromData({
                                  ...createTripRecordData(
                                    name: _model.textController1.text,
                                    creationDate: getCurrentTimestamp,
                                    editDate: getCurrentTimestamp,
                                    image: _model.photoURL,
                                    ownedBy: currentUserReference,
                                    tripDate: _model.selectedDate,
                                  ),
                                  ...mapToFirestore(
                                    {
                                      'members': [currentUserReference],
                                      'shareRequests': _model.shareWith,
                                    },
                                  ),
                                }, tripRecordReference);
                                _shouldSetState = true;
                                _model.thisTrip = _model.newTripRef;
                                safeSetState(() {});
                              }

                              _model.loopCounter = 0;
                              safeSetState(() {});
                              while (_model.loopCounter <
                                  _model.shareWith.length) {
                                _model.userInvsRef =
                                    await actions.getOrCreateUserInvitationsRef(
                                  null,
                                  _model.shareWith[_model.loopCounter],
                                );
                                _shouldSetState = true;

                                firestoreBatch.set(
                                    TripInvitationRecord.createDoc(
                                        _model.userInvsRef!),
                                    createTripInvitationRecordData(
                                      trip: _model.thisTrip?.reference,
                                      invitedBy: currentUserReference,
                                      dateInvited: getCurrentTimestamp,
                                      status: RequestStatus.Requested,
                                    ));

                                firestoreBatch
                                    .set(MailRecord.collection.doc(), {
                                  ...createMailRecordData(
                                    message: updateMessageStruct(
                                      MessageStruct(
                                        subject:
                                            '${currentUserEmail} invites you to ${_model.textController1.text}',
                                        html: functions.buildInvite(
                                            currentUserEmail,
                                            _model.photoURL,
                                            _model.textController1.text),
                                      ),
                                      clearUnsetFields: false,
                                      create: true,
                                    ),
                                  ),
                                  ...mapToFirestore(
                                    {
                                      'to': [
                                        _model.shareWith[_model.loopCounter]
                                      ],
                                    },
                                  ),
                                });
                                _model.loopCounter = _model.loopCounter + 1;
                              }
                              if (Navigator.of(context).canPop()) {
                                context.pop();
                              }
                              context.pushNamed(
                                'Logs',
                                queryParameters: {
                                  'trip': serializeParam(
                                    _model.thisTrip,
                                    ParamType.Document,
                                  ),
                                }.withoutNulls,
                                extra: <String, dynamic>{
                                  'trip': _model.thisTrip,
                                },
                              );
                            } finally {
                              await firestoreBatch.commit();
                            }

                            if (_shouldSetState) safeSetState(() {});
                          },
                    text: widget!.trip != null ? 'Save trip' : 'Create trip',
                    options: FFButtonOptions(
                      height: 40.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
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
                      disabledTextColor: FlutterFlowTheme.of(context).alternate,
                    ),
                  ),
                ),
              ]
                  .addToStart(SizedBox(height: 16.0))
                  .addToEnd(SizedBox(height: 16.0)),
            ),
          ),
        ),
      ),
    );
  }
}
