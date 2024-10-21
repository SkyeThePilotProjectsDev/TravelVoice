// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class InvitationGroupStruct extends FFFirebaseStruct {
  InvitationGroupStruct({
    String? name,
    List<DocumentReference>? invitations,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _invitations = invitations,
        super(firestoreUtilData);

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "invitations" field.
  List<DocumentReference>? _invitations;
  List<DocumentReference> get invitations => _invitations ?? const [];
  set invitations(List<DocumentReference>? val) => _invitations = val;

  void updateInvitations(Function(List<DocumentReference>) updateFn) {
    updateFn(_invitations ??= []);
  }

  bool hasInvitations() => _invitations != null;

  static InvitationGroupStruct fromMap(Map<String, dynamic> data) =>
      InvitationGroupStruct(
        name: data['name'] as String?,
        invitations: getDataList(data['invitations']),
      );

  static InvitationGroupStruct? maybeFromMap(dynamic data) => data is Map
      ? InvitationGroupStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'invitations': _invitations,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'invitations': serializeParam(
          _invitations,
          ParamType.DocumentReference,
          isList: true,
        ),
      }.withoutNulls;

  static InvitationGroupStruct fromSerializableMap(Map<String, dynamic> data) =>
      InvitationGroupStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        invitations: deserializeParam<DocumentReference>(
          data['invitations'],
          ParamType.DocumentReference,
          true,
          collectionNamePath: ['invitations', 'tripInvitation'],
        ),
      );

  @override
  String toString() => 'InvitationGroupStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is InvitationGroupStruct &&
        name == other.name &&
        listEquality.equals(invitations, other.invitations);
  }

  @override
  int get hashCode => const ListEquality().hash([name, invitations]);
}

InvitationGroupStruct createInvitationGroupStruct({
  String? name,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    InvitationGroupStruct(
      name: name,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

InvitationGroupStruct? updateInvitationGroupStruct(
  InvitationGroupStruct? invitationGroup, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    invitationGroup
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addInvitationGroupStructData(
  Map<String, dynamic> firestoreData,
  InvitationGroupStruct? invitationGroup,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (invitationGroup == null) {
    return;
  }
  if (invitationGroup.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && invitationGroup.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final invitationGroupData =
      getInvitationGroupFirestoreData(invitationGroup, forFieldValue);
  final nestedData =
      invitationGroupData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = invitationGroup.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getInvitationGroupFirestoreData(
  InvitationGroupStruct? invitationGroup, [
  bool forFieldValue = false,
]) {
  if (invitationGroup == null) {
    return {};
  }
  final firestoreData = mapToFirestore(invitationGroup.toMap());

  // Add any Firestore field values
  invitationGroup.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getInvitationGroupListFirestoreData(
  List<InvitationGroupStruct>? invitationGroups,
) =>
    invitationGroups
        ?.map((e) => getInvitationGroupFirestoreData(e, true))
        .toList() ??
    [];
