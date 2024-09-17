// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/enums/enums.dart';

import '/flutter_flow/flutter_flow_util.dart';

class LocationDataStruct extends FFFirebaseStruct {
  LocationDataStruct({
    LatLng? location,
    String? locationText,
    LocationSpecificity? specificityLevel,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _location = location,
        _locationText = locationText,
        _specificityLevel = specificityLevel,
        super(firestoreUtilData);

  // "location" field.
  LatLng? _location;
  LatLng? get location => _location;
  set location(LatLng? val) => _location = val;

  bool hasLocation() => _location != null;

  // "locationText" field.
  String? _locationText;
  String get locationText => _locationText ?? '';
  set locationText(String? val) => _locationText = val;

  bool hasLocationText() => _locationText != null;

  // "specificityLevel" field.
  LocationSpecificity? _specificityLevel;
  LocationSpecificity? get specificityLevel => _specificityLevel;
  set specificityLevel(LocationSpecificity? val) => _specificityLevel = val;

  bool hasSpecificityLevel() => _specificityLevel != null;

  static LocationDataStruct fromMap(Map<String, dynamic> data) =>
      LocationDataStruct(
        location: data['location'] as LatLng?,
        locationText: data['locationText'] as String?,
        specificityLevel:
            deserializeEnum<LocationSpecificity>(data['specificityLevel']),
      );

  static LocationDataStruct? maybeFromMap(dynamic data) => data is Map
      ? LocationDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'location': _location,
        'locationText': _locationText,
        'specificityLevel': _specificityLevel?.serialize(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'location': serializeParam(
          _location,
          ParamType.LatLng,
        ),
        'locationText': serializeParam(
          _locationText,
          ParamType.String,
        ),
        'specificityLevel': serializeParam(
          _specificityLevel,
          ParamType.Enum,
        ),
      }.withoutNulls;

  static LocationDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      LocationDataStruct(
        location: deserializeParam(
          data['location'],
          ParamType.LatLng,
          false,
        ),
        locationText: deserializeParam(
          data['locationText'],
          ParamType.String,
          false,
        ),
        specificityLevel: deserializeParam<LocationSpecificity>(
          data['specificityLevel'],
          ParamType.Enum,
          false,
        ),
      );

  @override
  String toString() => 'LocationDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is LocationDataStruct &&
        location == other.location &&
        locationText == other.locationText &&
        specificityLevel == other.specificityLevel;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([location, locationText, specificityLevel]);
}

LocationDataStruct createLocationDataStruct({
  LatLng? location,
  String? locationText,
  LocationSpecificity? specificityLevel,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    LocationDataStruct(
      location: location,
      locationText: locationText,
      specificityLevel: specificityLevel,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

LocationDataStruct? updateLocationDataStruct(
  LocationDataStruct? locationData, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    locationData
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addLocationDataStructData(
  Map<String, dynamic> firestoreData,
  LocationDataStruct? locationData,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (locationData == null) {
    return;
  }
  if (locationData.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && locationData.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final locationDataData =
      getLocationDataFirestoreData(locationData, forFieldValue);
  final nestedData =
      locationDataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = locationData.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getLocationDataFirestoreData(
  LocationDataStruct? locationData, [
  bool forFieldValue = false,
]) {
  if (locationData == null) {
    return {};
  }
  final firestoreData = mapToFirestore(locationData.toMap());

  // Add any Firestore field values
  locationData.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getLocationDataListFirestoreData(
  List<LocationDataStruct>? locationDatas,
) =>
    locationDatas?.map((e) => getLocationDataFirestoreData(e, true)).toList() ??
    [];
