import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/schema/enums/enums.dart';
import '/components/date_picker_widget.dart';
import '/components/delete_confirmation_widget.dart';
import '/components/image_uploader_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'edit_trip_widget.dart' show EditTripWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditTripModel extends FlutterFlowModel<EditTripWidget> {
  ///  Local state fields for this page.

  List<String> newMembers = [];
  void addToNewMembers(String item) => newMembers.add(item);
  void removeFromNewMembers(String item) => newMembers.remove(item);
  void removeAtIndexFromNewMembers(int index) => newMembers.removeAt(index);
  void insertAtIndexInNewMembers(int index, String item) =>
      newMembers.insert(index, item);
  void updateNewMembersAtIndex(int index, Function(String) updateFn) =>
      newMembers[index] = updateFn(newMembers[index]);

  FFUploadedFile? newImage;

  DateTime? newDate;

  int loopCounter = 0;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in Icon widget.
  List<TripInvitationRecord>? allTripInvitations;
  // State field(s) for TextField_Name widget.
  FocusNode? textFieldNameFocusNode;
  TextEditingController? textFieldNameTextController;
  String? Function(BuildContext, String?)? textFieldNameTextControllerValidator;
  // Model for DatePicker component.
  late DatePickerModel datePickerModel;
  // State field(s) for TextField_Email widget.
  FocusNode? textFieldEmailFocusNode;
  TextEditingController? textFieldEmailTextController;
  String? Function(BuildContext, String?)?
      textFieldEmailTextControllerValidator;
  // Model for imageUploader component.
  late ImageUploaderModel imageUploaderModel;
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  @override
  void initState(BuildContext context) {
    datePickerModel = createModel(context, () => DatePickerModel());
    imageUploaderModel = createModel(context, () => ImageUploaderModel());
  }

  @override
  void dispose() {
    textFieldNameFocusNode?.dispose();
    textFieldNameTextController?.dispose();

    datePickerModel.dispose();
    textFieldEmailFocusNode?.dispose();
    textFieldEmailTextController?.dispose();

    imageUploaderModel.dispose();
  }
}
