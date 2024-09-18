// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TripRequestStruct extends FFFirebaseStruct {
  TripRequestStruct({
    DocumentReference? user,
    RequestStatus? status,
    DateTime? dateEdited,
    DateTime? dateCreated,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _user = user,
        _status = status,
        _dateEdited = dateEdited,
        _dateCreated = dateCreated,
        super(firestoreUtilData);

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  set user(DocumentReference? val) => _user = val;

  bool hasUser() => _user != null;

  // "status" field.
  RequestStatus? _status;
  RequestStatus? get status => _status;
  set status(RequestStatus? val) => _status = val;

  bool hasStatus() => _status != null;

  // "dateEdited" field.
  DateTime? _dateEdited;
  DateTime? get dateEdited => _dateEdited;
  set dateEdited(DateTime? val) => _dateEdited = val;

  bool hasDateEdited() => _dateEdited != null;

  // "dateCreated" field.
  DateTime? _dateCreated;
  DateTime? get dateCreated => _dateCreated;
  set dateCreated(DateTime? val) => _dateCreated = val;

  bool hasDateCreated() => _dateCreated != null;

  static TripRequestStruct fromMap(Map<String, dynamic> data) =>
      TripRequestStruct(
        user: data['user'] as DocumentReference?,
        status: deserializeEnum<RequestStatus>(data['status']),
        dateEdited: data['dateEdited'] as DateTime?,
        dateCreated: data['dateCreated'] as DateTime?,
      );

  static TripRequestStruct? maybeFromMap(dynamic data) => data is Map
      ? TripRequestStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'user': _user,
        'status': _status?.serialize(),
        'dateEdited': _dateEdited,
        'dateCreated': _dateCreated,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'user': serializeParam(
          _user,
          ParamType.DocumentReference,
        ),
        'status': serializeParam(
          _status,
          ParamType.Enum,
        ),
        'dateEdited': serializeParam(
          _dateEdited,
          ParamType.DateTime,
        ),
        'dateCreated': serializeParam(
          _dateCreated,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static TripRequestStruct fromSerializableMap(Map<String, dynamic> data) =>
      TripRequestStruct(
        user: deserializeParam(
          data['user'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['users'],
        ),
        status: deserializeParam<RequestStatus>(
          data['status'],
          ParamType.Enum,
          false,
        ),
        dateEdited: deserializeParam(
          data['dateEdited'],
          ParamType.DateTime,
          false,
        ),
        dateCreated: deserializeParam(
          data['dateCreated'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'TripRequestStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TripRequestStruct &&
        user == other.user &&
        status == other.status &&
        dateEdited == other.dateEdited &&
        dateCreated == other.dateCreated;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([user, status, dateEdited, dateCreated]);
}

TripRequestStruct createTripRequestStruct({
  DocumentReference? user,
  RequestStatus? status,
  DateTime? dateEdited,
  DateTime? dateCreated,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    TripRequestStruct(
      user: user,
      status: status,
      dateEdited: dateEdited,
      dateCreated: dateCreated,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

TripRequestStruct? updateTripRequestStruct(
  TripRequestStruct? tripRequest, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    tripRequest
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addTripRequestStructData(
  Map<String, dynamic> firestoreData,
  TripRequestStruct? tripRequest,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (tripRequest == null) {
    return;
  }
  if (tripRequest.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && tripRequest.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final tripRequestData =
      getTripRequestFirestoreData(tripRequest, forFieldValue);
  final nestedData =
      tripRequestData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = tripRequest.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getTripRequestFirestoreData(
  TripRequestStruct? tripRequest, [
  bool forFieldValue = false,
]) {
  if (tripRequest == null) {
    return {};
  }
  final firestoreData = mapToFirestore(tripRequest.toMap());

  // Add any Firestore field values
  tripRequest.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getTripRequestListFirestoreData(
  List<TripRequestStruct>? tripRequests,
) =>
    tripRequests?.map((e) => getTripRequestFirestoreData(e, true)).toList() ??
    [];
