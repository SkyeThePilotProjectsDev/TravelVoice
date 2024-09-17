// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ViewportStruct extends FFFirebaseStruct {
  ViewportStruct({
    NortheastStruct? northeast,
    SouthwestStruct? southwest,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _northeast = northeast,
        _southwest = southwest,
        super(firestoreUtilData);

  // "northeast" field.
  NortheastStruct? _northeast;
  NortheastStruct get northeast => _northeast ?? NortheastStruct();
  set northeast(NortheastStruct? val) => _northeast = val;

  void updateNortheast(Function(NortheastStruct) updateFn) {
    updateFn(_northeast ??= NortheastStruct());
  }

  bool hasNortheast() => _northeast != null;

  // "southwest" field.
  SouthwestStruct? _southwest;
  SouthwestStruct get southwest => _southwest ?? SouthwestStruct();
  set southwest(SouthwestStruct? val) => _southwest = val;

  void updateSouthwest(Function(SouthwestStruct) updateFn) {
    updateFn(_southwest ??= SouthwestStruct());
  }

  bool hasSouthwest() => _southwest != null;

  static ViewportStruct fromMap(Map<String, dynamic> data) => ViewportStruct(
        northeast: NortheastStruct.maybeFromMap(data['northeast']),
        southwest: SouthwestStruct.maybeFromMap(data['southwest']),
      );

  static ViewportStruct? maybeFromMap(dynamic data) =>
      data is Map ? ViewportStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'northeast': _northeast?.toMap(),
        'southwest': _southwest?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'northeast': serializeParam(
          _northeast,
          ParamType.DataStruct,
        ),
        'southwest': serializeParam(
          _southwest,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static ViewportStruct fromSerializableMap(Map<String, dynamic> data) =>
      ViewportStruct(
        northeast: deserializeStructParam(
          data['northeast'],
          ParamType.DataStruct,
          false,
          structBuilder: NortheastStruct.fromSerializableMap,
        ),
        southwest: deserializeStructParam(
          data['southwest'],
          ParamType.DataStruct,
          false,
          structBuilder: SouthwestStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'ViewportStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ViewportStruct &&
        northeast == other.northeast &&
        southwest == other.southwest;
  }

  @override
  int get hashCode => const ListEquality().hash([northeast, southwest]);
}

ViewportStruct createViewportStruct({
  NortheastStruct? northeast,
  SouthwestStruct? southwest,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ViewportStruct(
      northeast: northeast ?? (clearUnsetFields ? NortheastStruct() : null),
      southwest: southwest ?? (clearUnsetFields ? SouthwestStruct() : null),
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ViewportStruct? updateViewportStruct(
  ViewportStruct? viewport, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    viewport
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addViewportStructData(
  Map<String, dynamic> firestoreData,
  ViewportStruct? viewport,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (viewport == null) {
    return;
  }
  if (viewport.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && viewport.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final viewportData = getViewportFirestoreData(viewport, forFieldValue);
  final nestedData = viewportData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = viewport.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getViewportFirestoreData(
  ViewportStruct? viewport, [
  bool forFieldValue = false,
]) {
  if (viewport == null) {
    return {};
  }
  final firestoreData = mapToFirestore(viewport.toMap());

  // Handle nested data for "northeast" field.
  addNortheastStructData(
    firestoreData,
    viewport.hasNortheast() ? viewport.northeast : null,
    'northeast',
    forFieldValue,
  );

  // Handle nested data for "southwest" field.
  addSouthwestStructData(
    firestoreData,
    viewport.hasSouthwest() ? viewport.southwest : null,
    'southwest',
    forFieldValue,
  );

  // Add any Firestore field values
  viewport.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getViewportListFirestoreData(
  List<ViewportStruct>? viewports,
) =>
    viewports?.map((e) => getViewportFirestoreData(e, true)).toList() ?? [];
