// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PhotosStruct extends FFFirebaseStruct {
  PhotosStruct({
    int? height,
    List<String>? htmlAttributions,
    String? photoReference,
    int? width,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _height = height,
        _htmlAttributions = htmlAttributions,
        _photoReference = photoReference,
        _width = width,
        super(firestoreUtilData);

  // "height" field.
  int? _height;
  int get height => _height ?? 0;
  set height(int? val) => _height = val;

  void incrementHeight(int amount) => height = height + amount;

  bool hasHeight() => _height != null;

  // "html_attributions" field.
  List<String>? _htmlAttributions;
  List<String> get htmlAttributions => _htmlAttributions ?? const [];
  set htmlAttributions(List<String>? val) => _htmlAttributions = val;

  void updateHtmlAttributions(Function(List<String>) updateFn) {
    updateFn(_htmlAttributions ??= []);
  }

  bool hasHtmlAttributions() => _htmlAttributions != null;

  // "photo_reference" field.
  String? _photoReference;
  String get photoReference => _photoReference ?? '';
  set photoReference(String? val) => _photoReference = val;

  bool hasPhotoReference() => _photoReference != null;

  // "width" field.
  int? _width;
  int get width => _width ?? 0;
  set width(int? val) => _width = val;

  void incrementWidth(int amount) => width = width + amount;

  bool hasWidth() => _width != null;

  static PhotosStruct fromMap(Map<String, dynamic> data) => PhotosStruct(
        height: castToType<int>(data['height']),
        htmlAttributions: getDataList(data['html_attributions']),
        photoReference: data['photo_reference'] as String?,
        width: castToType<int>(data['width']),
      );

  static PhotosStruct? maybeFromMap(dynamic data) =>
      data is Map ? PhotosStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'height': _height,
        'html_attributions': _htmlAttributions,
        'photo_reference': _photoReference,
        'width': _width,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'height': serializeParam(
          _height,
          ParamType.int,
        ),
        'html_attributions': serializeParam(
          _htmlAttributions,
          ParamType.String,
          isList: true,
        ),
        'photo_reference': serializeParam(
          _photoReference,
          ParamType.String,
        ),
        'width': serializeParam(
          _width,
          ParamType.int,
        ),
      }.withoutNulls;

  static PhotosStruct fromSerializableMap(Map<String, dynamic> data) =>
      PhotosStruct(
        height: deserializeParam(
          data['height'],
          ParamType.int,
          false,
        ),
        htmlAttributions: deserializeParam<String>(
          data['html_attributions'],
          ParamType.String,
          true,
        ),
        photoReference: deserializeParam(
          data['photo_reference'],
          ParamType.String,
          false,
        ),
        width: deserializeParam(
          data['width'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'PhotosStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is PhotosStruct &&
        height == other.height &&
        listEquality.equals(htmlAttributions, other.htmlAttributions) &&
        photoReference == other.photoReference &&
        width == other.width;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([height, htmlAttributions, photoReference, width]);
}

PhotosStruct createPhotosStruct({
  int? height,
  String? photoReference,
  int? width,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PhotosStruct(
      height: height,
      photoReference: photoReference,
      width: width,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PhotosStruct? updatePhotosStruct(
  PhotosStruct? photos, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    photos
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPhotosStructData(
  Map<String, dynamic> firestoreData,
  PhotosStruct? photos,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (photos == null) {
    return;
  }
  if (photos.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && photos.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final photosData = getPhotosFirestoreData(photos, forFieldValue);
  final nestedData = photosData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = photos.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPhotosFirestoreData(
  PhotosStruct? photos, [
  bool forFieldValue = false,
]) {
  if (photos == null) {
    return {};
  }
  final firestoreData = mapToFirestore(photos.toMap());

  // Add any Firestore field values
  photos.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPhotosListFirestoreData(
  List<PhotosStruct>? photoss,
) =>
    photoss?.map((e) => getPhotosFirestoreData(e, true)).toList() ?? [];
