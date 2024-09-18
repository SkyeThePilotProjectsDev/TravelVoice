// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SouthwestStruct extends FFFirebaseStruct {
  SouthwestStruct({
    double? lat,
    double? lng,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _lat = lat,
        _lng = lng,
        super(firestoreUtilData);

  // "lat" field.
  double? _lat;
  double get lat => _lat ?? 0.0;
  set lat(double? val) => _lat = val;

  void incrementLat(double amount) => lat = lat + amount;

  bool hasLat() => _lat != null;

  // "lng" field.
  double? _lng;
  double get lng => _lng ?? 0.0;
  set lng(double? val) => _lng = val;

  void incrementLng(double amount) => lng = lng + amount;

  bool hasLng() => _lng != null;

  static SouthwestStruct fromMap(Map<String, dynamic> data) => SouthwestStruct(
        lat: castToType<double>(data['lat']),
        lng: castToType<double>(data['lng']),
      );

  static SouthwestStruct? maybeFromMap(dynamic data) => data is Map
      ? SouthwestStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'lat': _lat,
        'lng': _lng,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'lat': serializeParam(
          _lat,
          ParamType.double,
        ),
        'lng': serializeParam(
          _lng,
          ParamType.double,
        ),
      }.withoutNulls;

  static SouthwestStruct fromSerializableMap(Map<String, dynamic> data) =>
      SouthwestStruct(
        lat: deserializeParam(
          data['lat'],
          ParamType.double,
          false,
        ),
        lng: deserializeParam(
          data['lng'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'SouthwestStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SouthwestStruct && lat == other.lat && lng == other.lng;
  }

  @override
  int get hashCode => const ListEquality().hash([lat, lng]);
}

SouthwestStruct createSouthwestStruct({
  double? lat,
  double? lng,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SouthwestStruct(
      lat: lat,
      lng: lng,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SouthwestStruct? updateSouthwestStruct(
  SouthwestStruct? southwest, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    southwest
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSouthwestStructData(
  Map<String, dynamic> firestoreData,
  SouthwestStruct? southwest,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (southwest == null) {
    return;
  }
  if (southwest.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && southwest.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final southwestData = getSouthwestFirestoreData(southwest, forFieldValue);
  final nestedData = southwestData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = southwest.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSouthwestFirestoreData(
  SouthwestStruct? southwest, [
  bool forFieldValue = false,
]) {
  if (southwest == null) {
    return {};
  }
  final firestoreData = mapToFirestore(southwest.toMap());

  // Add any Firestore field values
  southwest.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSouthwestListFirestoreData(
  List<SouthwestStruct>? southwests,
) =>
    southwests?.map((e) => getSouthwestFirestoreData(e, true)).toList() ?? [];
