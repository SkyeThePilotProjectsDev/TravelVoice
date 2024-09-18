// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TripUserStruct extends FFFirebaseStruct {
  TripUserStruct({
    DocumentReference? user,
    AccessLevel? accessLevel,
    DocumentReference? addedBy,
    DocumentReference? editedBy,
    DateTime? dateAdded,
    DateTime? dateEdited,
    RequestStatus? status,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _user = user,
        _accessLevel = accessLevel,
        _addedBy = addedBy,
        _editedBy = editedBy,
        _dateAdded = dateAdded,
        _dateEdited = dateEdited,
        _status = status,
        super(firestoreUtilData);

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  set user(DocumentReference? val) => _user = val;

  bool hasUser() => _user != null;

  // "accessLevel" field.
  AccessLevel? _accessLevel;
  AccessLevel? get accessLevel => _accessLevel;
  set accessLevel(AccessLevel? val) => _accessLevel = val;

  bool hasAccessLevel() => _accessLevel != null;

  // "addedBy" field.
  DocumentReference? _addedBy;
  DocumentReference? get addedBy => _addedBy;
  set addedBy(DocumentReference? val) => _addedBy = val;

  bool hasAddedBy() => _addedBy != null;

  // "editedBy" field.
  DocumentReference? _editedBy;
  DocumentReference? get editedBy => _editedBy;
  set editedBy(DocumentReference? val) => _editedBy = val;

  bool hasEditedBy() => _editedBy != null;

  // "dateAdded" field.
  DateTime? _dateAdded;
  DateTime? get dateAdded => _dateAdded;
  set dateAdded(DateTime? val) => _dateAdded = val;

  bool hasDateAdded() => _dateAdded != null;

  // "dateEdited" field.
  DateTime? _dateEdited;
  DateTime? get dateEdited => _dateEdited;
  set dateEdited(DateTime? val) => _dateEdited = val;

  bool hasDateEdited() => _dateEdited != null;

  // "status" field.
  RequestStatus? _status;
  RequestStatus? get status => _status;
  set status(RequestStatus? val) => _status = val;

  bool hasStatus() => _status != null;

  static TripUserStruct fromMap(Map<String, dynamic> data) => TripUserStruct(
        user: data['user'] as DocumentReference?,
        accessLevel: deserializeEnum<AccessLevel>(data['accessLevel']),
        addedBy: data['addedBy'] as DocumentReference?,
        editedBy: data['editedBy'] as DocumentReference?,
        dateAdded: data['dateAdded'] as DateTime?,
        dateEdited: data['dateEdited'] as DateTime?,
        status: deserializeEnum<RequestStatus>(data['status']),
      );

  static TripUserStruct? maybeFromMap(dynamic data) =>
      data is Map ? TripUserStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'user': _user,
        'accessLevel': _accessLevel?.serialize(),
        'addedBy': _addedBy,
        'editedBy': _editedBy,
        'dateAdded': _dateAdded,
        'dateEdited': _dateEdited,
        'status': _status?.serialize(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'user': serializeParam(
          _user,
          ParamType.DocumentReference,
        ),
        'accessLevel': serializeParam(
          _accessLevel,
          ParamType.Enum,
        ),
        'addedBy': serializeParam(
          _addedBy,
          ParamType.DocumentReference,
        ),
        'editedBy': serializeParam(
          _editedBy,
          ParamType.DocumentReference,
        ),
        'dateAdded': serializeParam(
          _dateAdded,
          ParamType.DateTime,
        ),
        'dateEdited': serializeParam(
          _dateEdited,
          ParamType.DateTime,
        ),
        'status': serializeParam(
          _status,
          ParamType.Enum,
        ),
      }.withoutNulls;

  static TripUserStruct fromSerializableMap(Map<String, dynamic> data) =>
      TripUserStruct(
        user: deserializeParam(
          data['user'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['users'],
        ),
        accessLevel: deserializeParam<AccessLevel>(
          data['accessLevel'],
          ParamType.Enum,
          false,
        ),
        addedBy: deserializeParam(
          data['addedBy'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['users'],
        ),
        editedBy: deserializeParam(
          data['editedBy'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['users'],
        ),
        dateAdded: deserializeParam(
          data['dateAdded'],
          ParamType.DateTime,
          false,
        ),
        dateEdited: deserializeParam(
          data['dateEdited'],
          ParamType.DateTime,
          false,
        ),
        status: deserializeParam<RequestStatus>(
          data['status'],
          ParamType.Enum,
          false,
        ),
      );

  @override
  String toString() => 'TripUserStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TripUserStruct &&
        user == other.user &&
        accessLevel == other.accessLevel &&
        addedBy == other.addedBy &&
        editedBy == other.editedBy &&
        dateAdded == other.dateAdded &&
        dateEdited == other.dateEdited &&
        status == other.status;
  }

  @override
  int get hashCode => const ListEquality().hash(
      [user, accessLevel, addedBy, editedBy, dateAdded, dateEdited, status]);
}

TripUserStruct createTripUserStruct({
  DocumentReference? user,
  AccessLevel? accessLevel,
  DocumentReference? addedBy,
  DocumentReference? editedBy,
  DateTime? dateAdded,
  DateTime? dateEdited,
  RequestStatus? status,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    TripUserStruct(
      user: user,
      accessLevel: accessLevel,
      addedBy: addedBy,
      editedBy: editedBy,
      dateAdded: dateAdded,
      dateEdited: dateEdited,
      status: status,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

TripUserStruct? updateTripUserStruct(
  TripUserStruct? tripUser, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    tripUser
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addTripUserStructData(
  Map<String, dynamic> firestoreData,
  TripUserStruct? tripUser,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (tripUser == null) {
    return;
  }
  if (tripUser.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && tripUser.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final tripUserData = getTripUserFirestoreData(tripUser, forFieldValue);
  final nestedData = tripUserData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = tripUser.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getTripUserFirestoreData(
  TripUserStruct? tripUser, [
  bool forFieldValue = false,
]) {
  if (tripUser == null) {
    return {};
  }
  final firestoreData = mapToFirestore(tripUser.toMap());

  // Add any Firestore field values
  tripUser.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getTripUserListFirestoreData(
  List<TripUserStruct>? tripUsers,
) =>
    tripUsers?.map((e) => getTripUserFirestoreData(e, true)).toList() ?? [];
