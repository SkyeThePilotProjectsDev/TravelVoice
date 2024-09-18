// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PlaceSearchStruct extends FFFirebaseStruct {
  PlaceSearchStruct({
    String? formattedAddress,
    GeometryStruct? geometry,
    String? icon,
    String? iconBackgroundColor,
    String? iconMaskBaseUri,
    String? name,
    List<PhotosStruct>? photos,
    String? placeId,
    List<String>? types,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _formattedAddress = formattedAddress,
        _geometry = geometry,
        _icon = icon,
        _iconBackgroundColor = iconBackgroundColor,
        _iconMaskBaseUri = iconMaskBaseUri,
        _name = name,
        _photos = photos,
        _placeId = placeId,
        _types = types,
        super(firestoreUtilData);

  // "formatted_address" field.
  String? _formattedAddress;
  String get formattedAddress => _formattedAddress ?? '';
  set formattedAddress(String? val) => _formattedAddress = val;

  bool hasFormattedAddress() => _formattedAddress != null;

  // "geometry" field.
  GeometryStruct? _geometry;
  GeometryStruct get geometry => _geometry ?? GeometryStruct();
  set geometry(GeometryStruct? val) => _geometry = val;

  void updateGeometry(Function(GeometryStruct) updateFn) {
    updateFn(_geometry ??= GeometryStruct());
  }

  bool hasGeometry() => _geometry != null;

  // "icon" field.
  String? _icon;
  String get icon => _icon ?? '';
  set icon(String? val) => _icon = val;

  bool hasIcon() => _icon != null;

  // "icon_background_color" field.
  String? _iconBackgroundColor;
  String get iconBackgroundColor => _iconBackgroundColor ?? '';
  set iconBackgroundColor(String? val) => _iconBackgroundColor = val;

  bool hasIconBackgroundColor() => _iconBackgroundColor != null;

  // "icon_mask_base_uri" field.
  String? _iconMaskBaseUri;
  String get iconMaskBaseUri => _iconMaskBaseUri ?? '';
  set iconMaskBaseUri(String? val) => _iconMaskBaseUri = val;

  bool hasIconMaskBaseUri() => _iconMaskBaseUri != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "photos" field.
  List<PhotosStruct>? _photos;
  List<PhotosStruct> get photos => _photos ?? const [];
  set photos(List<PhotosStruct>? val) => _photos = val;

  void updatePhotos(Function(List<PhotosStruct>) updateFn) {
    updateFn(_photos ??= []);
  }

  bool hasPhotos() => _photos != null;

  // "place_id" field.
  String? _placeId;
  String get placeId => _placeId ?? '';
  set placeId(String? val) => _placeId = val;

  bool hasPlaceId() => _placeId != null;

  // "types" field.
  List<String>? _types;
  List<String> get types => _types ?? const [];
  set types(List<String>? val) => _types = val;

  void updateTypes(Function(List<String>) updateFn) {
    updateFn(_types ??= []);
  }

  bool hasTypes() => _types != null;

  static PlaceSearchStruct fromMap(Map<String, dynamic> data) =>
      PlaceSearchStruct(
        formattedAddress: data['formatted_address'] as String?,
        geometry: GeometryStruct.maybeFromMap(data['geometry']),
        icon: data['icon'] as String?,
        iconBackgroundColor: data['icon_background_color'] as String?,
        iconMaskBaseUri: data['icon_mask_base_uri'] as String?,
        name: data['name'] as String?,
        photos: getStructList(
          data['photos'],
          PhotosStruct.fromMap,
        ),
        placeId: data['place_id'] as String?,
        types: getDataList(data['types']),
      );

  static PlaceSearchStruct? maybeFromMap(dynamic data) => data is Map
      ? PlaceSearchStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'formatted_address': _formattedAddress,
        'geometry': _geometry?.toMap(),
        'icon': _icon,
        'icon_background_color': _iconBackgroundColor,
        'icon_mask_base_uri': _iconMaskBaseUri,
        'name': _name,
        'photos': _photos?.map((e) => e.toMap()).toList(),
        'place_id': _placeId,
        'types': _types,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'formatted_address': serializeParam(
          _formattedAddress,
          ParamType.String,
        ),
        'geometry': serializeParam(
          _geometry,
          ParamType.DataStruct,
        ),
        'icon': serializeParam(
          _icon,
          ParamType.String,
        ),
        'icon_background_color': serializeParam(
          _iconBackgroundColor,
          ParamType.String,
        ),
        'icon_mask_base_uri': serializeParam(
          _iconMaskBaseUri,
          ParamType.String,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'photos': serializeParam(
          _photos,
          ParamType.DataStruct,
          isList: true,
        ),
        'place_id': serializeParam(
          _placeId,
          ParamType.String,
        ),
        'types': serializeParam(
          _types,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static PlaceSearchStruct fromSerializableMap(Map<String, dynamic> data) =>
      PlaceSearchStruct(
        formattedAddress: deserializeParam(
          data['formatted_address'],
          ParamType.String,
          false,
        ),
        geometry: deserializeStructParam(
          data['geometry'],
          ParamType.DataStruct,
          false,
          structBuilder: GeometryStruct.fromSerializableMap,
        ),
        icon: deserializeParam(
          data['icon'],
          ParamType.String,
          false,
        ),
        iconBackgroundColor: deserializeParam(
          data['icon_background_color'],
          ParamType.String,
          false,
        ),
        iconMaskBaseUri: deserializeParam(
          data['icon_mask_base_uri'],
          ParamType.String,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        photos: deserializeStructParam<PhotosStruct>(
          data['photos'],
          ParamType.DataStruct,
          true,
          structBuilder: PhotosStruct.fromSerializableMap,
        ),
        placeId: deserializeParam(
          data['place_id'],
          ParamType.String,
          false,
        ),
        types: deserializeParam<String>(
          data['types'],
          ParamType.String,
          true,
        ),
      );

  @override
  String toString() => 'PlaceSearchStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is PlaceSearchStruct &&
        formattedAddress == other.formattedAddress &&
        geometry == other.geometry &&
        icon == other.icon &&
        iconBackgroundColor == other.iconBackgroundColor &&
        iconMaskBaseUri == other.iconMaskBaseUri &&
        name == other.name &&
        listEquality.equals(photos, other.photos) &&
        placeId == other.placeId &&
        listEquality.equals(types, other.types);
  }

  @override
  int get hashCode => const ListEquality().hash([
        formattedAddress,
        geometry,
        icon,
        iconBackgroundColor,
        iconMaskBaseUri,
        name,
        photos,
        placeId,
        types
      ]);
}

PlaceSearchStruct createPlaceSearchStruct({
  String? formattedAddress,
  GeometryStruct? geometry,
  String? icon,
  String? iconBackgroundColor,
  String? iconMaskBaseUri,
  String? name,
  String? placeId,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PlaceSearchStruct(
      formattedAddress: formattedAddress,
      geometry: geometry ?? (clearUnsetFields ? GeometryStruct() : null),
      icon: icon,
      iconBackgroundColor: iconBackgroundColor,
      iconMaskBaseUri: iconMaskBaseUri,
      name: name,
      placeId: placeId,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PlaceSearchStruct? updatePlaceSearchStruct(
  PlaceSearchStruct? placeSearch, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    placeSearch
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPlaceSearchStructData(
  Map<String, dynamic> firestoreData,
  PlaceSearchStruct? placeSearch,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (placeSearch == null) {
    return;
  }
  if (placeSearch.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && placeSearch.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final placeSearchData =
      getPlaceSearchFirestoreData(placeSearch, forFieldValue);
  final nestedData =
      placeSearchData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = placeSearch.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPlaceSearchFirestoreData(
  PlaceSearchStruct? placeSearch, [
  bool forFieldValue = false,
]) {
  if (placeSearch == null) {
    return {};
  }
  final firestoreData = mapToFirestore(placeSearch.toMap());

  // Handle nested data for "geometry" field.
  addGeometryStructData(
    firestoreData,
    placeSearch.hasGeometry() ? placeSearch.geometry : null,
    'geometry',
    forFieldValue,
  );

  // Add any Firestore field values
  placeSearch.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPlaceSearchListFirestoreData(
  List<PlaceSearchStruct>? placeSearchs,
) =>
    placeSearchs?.map((e) => getPlaceSearchFirestoreData(e, true)).toList() ??
    [];
