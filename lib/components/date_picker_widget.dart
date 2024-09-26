import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'date_picker_model.dart';
export 'date_picker_model.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({
    super.key,
    required this.defaultDate,
    required this.onChange,
  });

  final DateTime? defaultDate;
  final Future Function(DateTime setDate)? onChange;

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  late DatePickerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DatePickerModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.selectedDate = widget!.defaultDate;
      safeSetState(() {});
    });

    _model.textFieldYearTextController ??= TextEditingController(
        text: dateTimeFormat(
            "d",
            _model.selectedDate != null
                ? _model.selectedDate
                : widget!.defaultDate));
    _model.textFieldYearFocusNode ??= FocusNode();
    _model.textFieldYearFocusNode!.addListener(
      () async {
        _model.selectedDate = functions.dateBuilder(
            _model.textFieldDayTextController.text,
            _model.textFieldMonthTextController.text,
            _model.textFieldYearTextController.text,
            _model.selectedDate!);
        safeSetState(() {
          _model.textFieldDayTextController?.text =
              dateTimeFormat("d", _model.selectedDate);
          _model.textFieldDayTextController?.selection =
              TextSelection.collapsed(
                  offset: _model.textFieldDayTextController!.text.length);
        });
        safeSetState(() {
          _model.textFieldMonthTextController?.text =
              dateTimeFormat("M", _model.selectedDate);
          _model.textFieldMonthTextController?.selection =
              TextSelection.collapsed(
                  offset: _model.textFieldMonthTextController!.text.length);
        });
        safeSetState(() {
          _model.textFieldYearTextController?.text =
              dateTimeFormat("yyyy", _model.selectedDate);
          _model.textFieldYearTextController?.selection =
              TextSelection.collapsed(
                  offset: _model.textFieldYearTextController!.text.length);
        });
      },
    );
    _model.textFieldMonthTextController ??= TextEditingController(
        text: dateTimeFormat(
            "M",
            _model.selectedDate != null
                ? _model.selectedDate
                : widget!.defaultDate));
    _model.textFieldMonthFocusNode ??= FocusNode();
    _model.textFieldMonthFocusNode!.addListener(
      () async {
        _model.selectedDate = functions.dateBuilder(
            _model.textFieldDayTextController.text,
            _model.textFieldMonthTextController.text,
            _model.textFieldYearTextController.text,
            _model.selectedDate!);
        safeSetState(() {
          _model.textFieldDayTextController?.text =
              dateTimeFormat("d", _model.selectedDate);
          _model.textFieldDayTextController?.selection =
              TextSelection.collapsed(
                  offset: _model.textFieldDayTextController!.text.length);
        });
        safeSetState(() {
          _model.textFieldMonthTextController?.text =
              dateTimeFormat("M", _model.selectedDate);
          _model.textFieldMonthTextController?.selection =
              TextSelection.collapsed(
                  offset: _model.textFieldMonthTextController!.text.length);
        });
        safeSetState(() {
          _model.textFieldYearTextController?.text =
              dateTimeFormat("yyyy", _model.selectedDate);
          _model.textFieldYearTextController?.selection =
              TextSelection.collapsed(
                  offset: _model.textFieldYearTextController!.text.length);
        });
      },
    );
    _model.textFieldDayTextController ??= TextEditingController(
        text: dateTimeFormat(
            "yyyy",
            _model.selectedDate != null
                ? _model.selectedDate
                : widget!.defaultDate));
    _model.textFieldDayFocusNode ??= FocusNode();
    _model.textFieldDayFocusNode!.addListener(
      () async {
        _model.selectedDate = functions.dateBuilder(
            _model.textFieldDayTextController.text,
            _model.textFieldMonthTextController.text,
            _model.textFieldYearTextController.text,
            _model.selectedDate!);
        safeSetState(() {
          _model.textFieldDayTextController?.text =
              dateTimeFormat("d", _model.selectedDate);
          _model.textFieldDayTextController?.selection =
              TextSelection.collapsed(
                  offset: _model.textFieldDayTextController!.text.length);
        });
        safeSetState(() {
          _model.textFieldMonthTextController?.text =
              dateTimeFormat("M", _model.selectedDate);
          _model.textFieldMonthTextController?.selection =
              TextSelection.collapsed(
                  offset: _model.textFieldMonthTextController!.text.length);
        });
        safeSetState(() {
          _model.textFieldYearTextController?.text =
              dateTimeFormat("yyyy", _model.selectedDate);
          _model.textFieldYearTextController?.selection =
              TextSelection.collapsed(
                  offset: _model.textFieldYearTextController!.text.length);
        });
      },
    );
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
            width: 200.0,
            child: TextFormField(
              controller: _model.textFieldYearTextController,
              focusNode: _model.textFieldYearFocusNode,
              autofocus: false,
              obscureText: false,
              decoration: InputDecoration(
                isDense: true,
                labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                      fontFamily: 'Inter',
                      letterSpacing: 0.0,
                    ),
                hintText: 'TextField',
                hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                      fontFamily: 'Inter',
                      letterSpacing: 0.0,
                    ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).alternate,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).primary,
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
                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Inter',
                    letterSpacing: 0.0,
                  ),
              cursorColor: FlutterFlowTheme.of(context).primaryText,
              validator: _model.textFieldYearTextControllerValidator
                  .asValidator(context),
            ),
          ),
        ),
        Text(
          '/',
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Inter',
                letterSpacing: 0.0,
              ),
        ),
        Expanded(
          child: Container(
            width: 200.0,
            child: TextFormField(
              controller: _model.textFieldMonthTextController,
              focusNode: _model.textFieldMonthFocusNode,
              autofocus: false,
              obscureText: false,
              decoration: InputDecoration(
                isDense: true,
                labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                      fontFamily: 'Inter',
                      letterSpacing: 0.0,
                    ),
                hintText: 'TextField',
                hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                      fontFamily: 'Inter',
                      letterSpacing: 0.0,
                    ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).alternate,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).primary,
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
                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Inter',
                    letterSpacing: 0.0,
                  ),
              cursorColor: FlutterFlowTheme.of(context).primaryText,
              validator: _model.textFieldMonthTextControllerValidator
                  .asValidator(context),
            ),
          ),
        ),
        Text(
          '/',
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Inter',
                letterSpacing: 0.0,
              ),
        ),
        Expanded(
          child: Container(
            width: 200.0,
            child: TextFormField(
              controller: _model.textFieldDayTextController,
              focusNode: _model.textFieldDayFocusNode,
              autofocus: false,
              obscureText: false,
              decoration: InputDecoration(
                isDense: true,
                labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                      fontFamily: 'Inter',
                      letterSpacing: 0.0,
                    ),
                hintText: 'TextField',
                hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                      fontFamily: 'Inter',
                      letterSpacing: 0.0,
                    ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).alternate,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).primary,
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
                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Inter',
                    letterSpacing: 0.0,
                  ),
              cursorColor: FlutterFlowTheme.of(context).primaryText,
              validator: _model.textFieldDayTextControllerValidator
                  .asValidator(context),
            ),
          ),
        ),
        InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            final _datePickedDate = await showDatePicker(
              context: context,
              initialDate: ((widget!.defaultDate != null
                      ? widget!.defaultDate
                      : getCurrentTimestamp) ??
                  DateTime.now()),
              firstDate: DateTime(1900),
              lastDate: DateTime(2050),
              builder: (context, child) {
                return wrapInMaterialDatePickerTheme(
                  context,
                  child!,
                  headerBackgroundColor: FlutterFlowTheme.of(context).primary,
                  headerForegroundColor: FlutterFlowTheme.of(context).info,
                  headerTextStyle:
                      FlutterFlowTheme.of(context).headlineLarge.override(
                            fontFamily: 'Inter Tight',
                            fontSize: 32.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                          ),
                  pickerBackgroundColor:
                      FlutterFlowTheme.of(context).secondaryBackground,
                  pickerForegroundColor:
                      FlutterFlowTheme.of(context).primaryText,
                  selectedDateTimeBackgroundColor:
                      FlutterFlowTheme.of(context).primary,
                  selectedDateTimeForegroundColor:
                      FlutterFlowTheme.of(context).info,
                  actionButtonForegroundColor:
                      FlutterFlowTheme.of(context).primaryText,
                  iconSize: 24.0,
                );
              },
            );

            if (_datePickedDate != null) {
              safeSetState(() {
                _model.datePicked = DateTime(
                  _datePickedDate.year,
                  _datePickedDate.month,
                  _datePickedDate.day,
                );
              });
            }
            if (_model.datePicked != null) {
              safeSetState(() {
                _model.textFieldDayTextController?.text =
                    dateTimeFormat("d", _model.datePicked);
                _model.textFieldDayTextController?.selection =
                    TextSelection.collapsed(
                        offset: _model.textFieldDayTextController!.text.length);
              });
              safeSetState(() {
                _model.textFieldMonthTextController?.text =
                    dateTimeFormat("M", _model.datePicked);
                _model.textFieldMonthTextController?.selection =
                    TextSelection.collapsed(
                        offset:
                            _model.textFieldMonthTextController!.text.length);
              });
              safeSetState(() {
                _model.textFieldYearTextController?.text =
                    dateTimeFormat("yyyy", _model.datePicked);
                _model.textFieldYearTextController?.selection =
                    TextSelection.collapsed(
                        offset:
                            _model.textFieldYearTextController!.text.length);
              });
              await widget.onChange?.call(
                _model.datePicked!,
              );
            }
          },
          child: Icon(
            Icons.event,
            color: FlutterFlowTheme.of(context).primaryText,
            size: 24.0,
          ),
        ),
      ].divide(SizedBox(width: 8.0)),
    );
  }
}
