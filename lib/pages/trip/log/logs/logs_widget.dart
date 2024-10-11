import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/trip/log/trip_log_item/trip_log_item_widget.dart';
import '/util_components/empty_list/empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'logs_model.dart';
export 'logs_model.dart';

class LogsWidget extends StatefulWidget {
  const LogsWidget({
    super.key,
    required this.trip,
  });

  final TripRecord? trip;

  @override
  State<LogsWidget> createState() => _LogsWidgetState();
}

class _LogsWidgetState extends State<LogsWidget> {
  late LogsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LogsModel());
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
        body: Container(
          decoration: BoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 200.0,
                decoration: BoxDecoration(),
                child: Builder(
                  builder: (context) {
                    if (widget!.trip?.image != null &&
                        widget!.trip?.image != '') {
                      return Stack(
                        children: [
                          Hero(
                            tag: widget!.trip!.image,
                            transitionOnUserGestures: true,
                            child: Image.network(
                              widget!.trip!.image,
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: MediaQuery.sizeOf(context).height * 1.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24.0, 0.0, 24.0, 0.0),
                                    child: Text(
                                      valueOrDefault<String>(
                                        widget!.trip?.name,
                                        '[Trip name]',
                                      ),
                                      maxLines: 3,
                                      style: FlutterFlowTheme.of(context)
                                          .displaySmall
                                          .override(
                                            fontFamily: 'Inter Tight',
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ),
                                ),
                                if (widget!.trip?.tripDate != null)
                                  Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24.0, 0.0, 24.0, 0.0),
                                      child: Text(
                                        dateTimeFormat("MMMM yyyy",
                                            widget!.trip!.tripDate!),
                                        maxLines: 3,
                                        style: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .override(
                                              fontFamily: 'Inter Tight',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Container(
                        height: 200.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primary,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
                                child: Text(
                                  valueOrDefault<String>(
                                    widget!.trip?.name,
                                    '[Trip name]',
                                  ),
                                  maxLines: 3,
                                  style: FlutterFlowTheme.of(context)
                                      .displaySmall
                                      .override(
                                        fontFamily: 'Inter Tight',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                            ),
                            if (widget!.trip?.tripDate != null)
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24.0, 0.0, 24.0, 0.0),
                                  child: Text(
                                    dateTimeFormat(
                                        "MMMM yyyy", widget!.trip!.tripDate!),
                                    maxLines: 3,
                                    style: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .override(
                                          fontFamily: 'Inter Tight',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed('Trips');
                                  },
                                  child: Icon(
                                    Icons.chevron_left_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 40.0,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Logs',
                                    style: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .override(
                                          fontFamily: 'Inter Tight',
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(
                                        'EditTrip',
                                        queryParameters: {
                                          'trip': serializeParam(
                                            widget!.trip,
                                            ParamType.Document,
                                          ),
                                        }.withoutNulls,
                                        extra: <String, dynamic>{
                                          'trip': widget!.trip,
                                        },
                                      );
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 30.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 16.0, 0.0),
                                      child: StreamBuilder<List<LogRecord>>(
                                        stream: queryLogRecord(
                                          parent: widget!.trip?.reference,
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
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                          List<LogRecord> columnLogRecordList =
                                              snapshot.data!;
                                          if (columnLogRecordList.isEmpty) {
                                            return EmptyListWidget();
                                          }

                                          return Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: List.generate(
                                                    columnLogRecordList.length,
                                                    (columnIndex) {
                                              final columnLogRecord =
                                                  columnLogRecordList[
                                                      columnIndex];
                                              return TripLogItemWidget(
                                                key: Key(
                                                    'Key5us_${columnIndex}_of_${columnLogRecordList.length}'),
                                                log: columnLogRecord,
                                              );
                                            })
                                                .divide(SizedBox(height: 16.0))
                                                .around(SizedBox(height: 16.0)),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]
                              .divide(SizedBox(height: 8.0))
                              .addToStart(SizedBox(height: 16.0)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 16.0, 0.0, 16.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed(
                                  'EditLog',
                                  queryParameters: {
                                    'trip': serializeParam(
                                      widget!.trip?.reference,
                                      ParamType.DocumentReference,
                                    ),
                                  }.withoutNulls,
                                );
                              },
                              child: Container(
                                width: 75.0,
                                height: 75.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).secondary,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.mic,
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  size: 50.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
