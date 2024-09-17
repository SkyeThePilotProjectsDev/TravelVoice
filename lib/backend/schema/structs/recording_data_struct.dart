// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class RecordingDataStruct extends FFFirebaseStruct {
  RecordingDataStruct({
    String? audio,
    String? name,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _audio = audio,
        _name = name,
        super(firestoreUtilData);

  // "audio" field.
  String? _audio;
  String get audio => _audio ?? '';
  set audio(String? val) => _audio = val;

  bool hasAudio() => _audio != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  static RecordingDataStruct fromMap(Map<String, dynamic> data) =>
      RecordingDataStruct(
        audio: data['audio'] as String?,
        name: data['name'] as String?,
      );

  static RecordingDataStruct? maybeFromMap(dynamic data) => data is Map
      ? RecordingDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'audio': _audio,
        'name': _name,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'audio': serializeParam(
          _audio,
          ParamType.String,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
      }.withoutNulls;

  static RecordingDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      RecordingDataStruct(
        audio: deserializeParam(
          data['audio'],
          ParamType.String,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'RecordingDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is RecordingDataStruct &&
        audio == other.audio &&
        name == other.name;
  }

  @override
  int get hashCode => const ListEquality().hash([audio, name]);
}

RecordingDataStruct createRecordingDataStruct({
  String? audio,
  String? name,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    RecordingDataStruct(
      audio: audio,
      name: name,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

RecordingDataStruct? updateRecordingDataStruct(
  RecordingDataStruct? recordingData, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    recordingData
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addRecordingDataStructData(
  Map<String, dynamic> firestoreData,
  RecordingDataStruct? recordingData,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (recordingData == null) {
    return;
  }
  if (recordingData.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && recordingData.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final recordingDataData =
      getRecordingDataFirestoreData(recordingData, forFieldValue);
  final nestedData =
      recordingDataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = recordingData.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getRecordingDataFirestoreData(
  RecordingDataStruct? recordingData, [
  bool forFieldValue = false,
]) {
  if (recordingData == null) {
    return {};
  }
  final firestoreData = mapToFirestore(recordingData.toMap());

  // Add any Firestore field values
  recordingData.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getRecordingDataListFirestoreData(
  List<RecordingDataStruct>? recordingDatas,
) =>
    recordingDatas
        ?.map((e) => getRecordingDataFirestoreData(e, true))
        .toList() ??
    [];
