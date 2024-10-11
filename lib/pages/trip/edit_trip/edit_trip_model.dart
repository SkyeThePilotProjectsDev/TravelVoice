import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/components/loading_indicator_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/pages/user/profile_icon/profile_icon_widget.dart';
import '/util_components/date_picker/date_picker_widget.dart';
import '/util_components/delete_confirmation/delete_confirmation_widget.dart';
import '/util_components/image_uploader/image_uploader_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'edit_trip_widget.dart' show EditTripWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditTripModel extends FlutterFlowModel<EditTripWidget> {
  ///  Local state fields for this page.

  FFUploadedFile? photo;

  String? photoURL;

  List<String> shareWith = [];
  void addToShareWith(String item) => shareWith.add(item);
  void removeFromShareWith(String item) => shareWith.remove(item);
  void removeAtIndexFromShareWith(int index) => shareWith.removeAt(index);
  void insertAtIndexInShareWith(int index, String item) =>
      shareWith.insert(index, item);
  void updateShareWithAtIndex(int index, Function(String) updateFn) =>
      shareWith[index] = updateFn(shareWith[index]);

  int loopCounter = 0;

  List<DocumentReference> removedUsers = [];
  void addToRemovedUsers(DocumentReference item) => removedUsers.add(item);
  void removeFromRemovedUsers(DocumentReference item) =>
      removedUsers.remove(item);
  void removeAtIndexFromRemovedUsers(int index) => removedUsers.removeAt(index);
  void insertAtIndexInRemovedUsers(int index, DocumentReference item) =>
      removedUsers.insert(index, item);
  void updateRemovedUsersAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      removedUsers[index] = updateFn(removedUsers[index]);

  TripRecord? thisTrip;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Firestore Query - Query a collection] action in Icon widget.
  List<TripInvitationRecord>? pendingRequests;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // Model for DatePicker component.
  late DatePickerModel datePickerModel;
  // State field(s) for TextField_Share widget.
  FocusNode? textFieldShareFocusNode;
  TextEditingController? textFieldShareTextController;
  String? Function(BuildContext, String?)?
      textFieldShareTextControllerValidator;
  String? _textFieldShareTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'This is not a valid email';
    }
    return null;
  }

  // Stores action output result for [Validate Form] action in TextField_Share widget.
  bool? isValidEmail;
  // Model for imageUploader component.
  late ImageUploaderModel imageUploaderModel;
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  TripRecord? newTripRef;
  // Stores action output result for [Custom Action - getOrCreateUserInvitationsRef] action in Button widget.
  DocumentReference? userInvsRef;

  @override
  void initState(BuildContext context) {
    datePickerModel = createModel(context, () => DatePickerModel());
    textFieldShareTextControllerValidator =
        _textFieldShareTextControllerValidator;
    imageUploaderModel = createModel(context, () => ImageUploaderModel());
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController1?.dispose();

    datePickerModel.dispose();
    textFieldShareFocusNode?.dispose();
    textFieldShareTextController?.dispose();

    imageUploaderModel.dispose();
  }
}
