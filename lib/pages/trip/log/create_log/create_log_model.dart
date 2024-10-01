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
import '/flutter_flow/custom_functions.dart' as functions;
import 'create_log_widget.dart' show CreateLogWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CreateLogModel extends FlutterFlowModel<CreateLogWidget> {
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
  // Stores action output result for [Bottom Sheet - createRecording] action in CreateLog widget.
  String? recordingInit;
  // Stores action output result for [Bottom Sheet - createRecording] action in Button widget.
  String? recording;
  // State field(s) for TextField_City widget.
  FocusNode? textFieldCityFocusNode;
  TextEditingController? textFieldCityTextController;
  String? Function(BuildContext, String?)? textFieldCityTextControllerValidator;
  // Model for PlaceSuggestions component.
  late PlaceSuggestionsModel placeSuggestionsModel;
  // Model for DatePicker component.
  late DatePickerModel datePickerModel;
  // State field(s) for TextField_Notes widget.
  FocusNode? textFieldNotesFocusNode;
  TextEditingController? textFieldNotesTextController;
  String? Function(BuildContext, String?)?
      textFieldNotesTextControllerValidator;
  // Model for imageUploader component.
  late ImageUploaderModel imageUploaderModel;
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  TripLogRecord? newLog;

  @override
  void initState(BuildContext context) {
    placeSuggestionsModel = createModel(context, () => PlaceSuggestionsModel());
    datePickerModel = createModel(context, () => DatePickerModel());
    imageUploaderModel = createModel(context, () => ImageUploaderModel());
  }

  @override
  void dispose() {
    textFieldCityFocusNode?.dispose();
    textFieldCityTextController?.dispose();

    placeSuggestionsModel.dispose();
    datePickerModel.dispose();
    textFieldNotesFocusNode?.dispose();
    textFieldNotesTextController?.dispose();

    imageUploaderModel.dispose();
  }
}
