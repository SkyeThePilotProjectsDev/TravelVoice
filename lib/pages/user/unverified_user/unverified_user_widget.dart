import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'unverified_user_model.dart';
export 'unverified_user_model.dart';

class UnverifiedUserWidget extends StatefulWidget {
  const UnverifiedUserWidget({super.key});

  @override
  State<UnverifiedUserWidget> createState() => _UnverifiedUserWidgetState();
}

class _UnverifiedUserWidgetState extends State<UnverifiedUserWidget> {
  late UnverifiedUserModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UnverifiedUserModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await authManager.refreshUser();
      if (currentUserEmailVerified) {
        context.pushNamed('Trips');
      } else {
        await authManager.sendEmailVerification();
        _model.timerController.onStartTimer();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
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
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            GoRouter.of(context).prepareAuthEvent();
                            await authManager.signOut();
                            GoRouter.of(context).clearRedirectLocation();

                            context.goNamedAuth('Landing', context.mounted);
                          },
                          child: Icon(
                            Icons.chevron_left_rounded,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 40.0,
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            await authManager.refreshUser();
                            if (currentUserEmailVerified) {}
                          },
                          child: Icon(
                            Icons.refresh,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 40.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        child: Builder(
                          builder: (context) {
                            if (!currentUserEmailVerified) {
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Please verify your email',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .displayLarge
                                        .override(
                                          fontFamily: 'Inter Tight',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      FFButtonWidget(
                                        onPressed: _model.emailCooldown
                                            ? null
                                            : () async {
                                                _model.emailCooldown = true;
                                                safeSetState(() {});
                                                _model.timerController
                                                    .onStartTimer();
                                                await authManager
                                                    .sendEmailVerification();
                                              },
                                        text: 'Resend  verification email',
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
                                          disabledColor:
                                              FlutterFlowTheme.of(context)
                                                  .tertiary,
                                          disabledTextColor:
                                              FlutterFlowTheme.of(context)
                                                  .alternate,
                                        ),
                                      ),
                                      if (_model.emailCooldown)
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'You can request another email in',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                FlutterFlowTimer(
                                                  initialTime:
                                                      _model.timerInitialTimeMs,
                                                  getDisplayTime: (value) =>
                                                      StopWatchTimer
                                                          .getDisplayTime(
                                                    value,
                                                    hours: false,
                                                    minute: false,
                                                  ),
                                                  controller:
                                                      _model.timerController,
                                                  updateStateInterval: Duration(
                                                      milliseconds: 1000),
                                                  onChanged: (value,
                                                      displayTime,
                                                      shouldUpdate) {
                                                    _model.timerMilliseconds =
                                                        value;
                                                    _model.timerValue =
                                                        displayTime;
                                                    if (shouldUpdate)
                                                      safeSetState(() {});
                                                  },
                                                  onEnded: () async {
                                                    _model.emailCooldown =
                                                        false;
                                                    safeSetState(() {});
                                                  },
                                                  textAlign: TextAlign.start,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondary,
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                                Text(
                                                  's',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ].divide(SizedBox(width: 4.0)),
                                        ),
                                    ].divide(SizedBox(height: 8.0)),
                                  ),
                                ].divide(SizedBox(height: 32.0)),
                              );
                            } else {
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'You have been verified!',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .displayLarge
                                        .override(
                                          fontFamily: 'Inter Tight',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      FFButtonWidget(
                                        onPressed: () async {
                                          context.pushNamed('Trips');
                                        },
                                        text: 'Log in',
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
                                ].divide(SizedBox(height: 32.0)),
                              );
                            }
                          },
                        ),
                      ),
                    ],
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
