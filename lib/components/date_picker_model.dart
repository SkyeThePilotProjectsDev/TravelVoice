import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'date_picker_widget.dart' show DatePickerWidget;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DatePickerModel extends FlutterFlowModel<DatePickerWidget> {
  ///  Local state fields for this component.

  DateTime? selectedDate;

  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField_Year widget.
  FocusNode? textFieldYearFocusNode;
  TextEditingController? textFieldYearTextController;
  String? Function(BuildContext, String?)? textFieldYearTextControllerValidator;
  // State field(s) for TextField_Month widget.
  FocusNode? textFieldMonthFocusNode;
  TextEditingController? textFieldMonthTextController;
  String? Function(BuildContext, String?)?
      textFieldMonthTextControllerValidator;
  // State field(s) for TextField_Day widget.
  FocusNode? textFieldDayFocusNode;
  TextEditingController? textFieldDayTextController;
  String? Function(BuildContext, String?)? textFieldDayTextControllerValidator;
  DateTime? datePicked;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldYearFocusNode?.dispose();
    textFieldYearTextController?.dispose();

    textFieldMonthFocusNode?.dispose();
    textFieldMonthTextController?.dispose();

    textFieldDayFocusNode?.dispose();
    textFieldDayTextController?.dispose();
  }
}
