import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/place_suggestions_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'edit_log_widget.dart' show EditLogWidget;
import 'package:flutter/material.dart';

class EditLogModel extends FlutterFlowModel<EditLogWidget> {
  ///  Local state fields for this page.

  FFUploadedFile? image;

  DateTime? selectedDate;

  List<String> recordings = [];
  void addToRecordings(String item) => recordings.add(item);
  void removeFromRecordings(String item) => recordings.remove(item);
  void removeAtIndexFromRecordings(int index) => recordings.removeAt(index);
  void insertAtIndexInRecordings(int index, String item) =>
      recordings.insert(index, item);
  void updateRecordingsAtIndex(int index, Function(String) updateFn) =>
      recordings[index] = updateFn(recordings[index]);

  bool toggle = false;

  PlaceSearchStruct? selectedPlace;
  void updateSelectedPlaceStruct(Function(PlaceSearchStruct) updateFn) {
    updateFn(selectedPlace ??= PlaceSearchStruct());
  }

  bool placeSelected = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Bottom Sheet - createRecording] action in Button widget.
  String? recording;
  // State field(s) for TextField_City widget.
  FocusNode? textFieldCityFocusNode;
  TextEditingController? textFieldCityTextController;
  String? Function(BuildContext, String?)? textFieldCityTextControllerValidator;
  // Model for PlaceSuggestions component.
  late PlaceSuggestionsModel placeSuggestionsModel;
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
  // State field(s) for TextField_Notes widget.
  FocusNode? textFieldNotesFocusNode;
  TextEditingController? textFieldNotesTextController;
  String? Function(BuildContext, String?)?
      textFieldNotesTextControllerValidator;
  bool isDataUploading1 = false;
  FFUploadedFile uploadedLocalFile1 =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  bool isDataUploading2 = false;
  FFUploadedFile uploadedLocalFile2 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl2 = '';

  @override
  void initState(BuildContext context) {
    placeSuggestionsModel = createModel(context, () => PlaceSuggestionsModel());
  }

  @override
  void dispose() {
    textFieldCityFocusNode?.dispose();
    textFieldCityTextController?.dispose();

    placeSuggestionsModel.dispose();
    textFieldYearFocusNode?.dispose();
    textFieldYearTextController?.dispose();

    textFieldMonthFocusNode?.dispose();
    textFieldMonthTextController?.dispose();

    textFieldDayFocusNode?.dispose();
    textFieldDayTextController?.dispose();

    textFieldNotesFocusNode?.dispose();
    textFieldNotesTextController?.dispose();
  }
}
