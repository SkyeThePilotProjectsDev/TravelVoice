import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TripRecord extends FirestoreRecord {
  TripRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "travelGroup" field.
  List<TripUserStruct>? _travelGroup;
  List<TripUserStruct> get travelGroup => _travelGroup ?? const [];
  bool hasTravelGroup() => _travelGroup != null;

  // "members" field.
  List<DocumentReference>? _members;
  List<DocumentReference> get members => _members ?? const [];
  bool hasMembers() => _members != null;

  // "creationDate" field.
  DateTime? _creationDate;
  DateTime? get creationDate => _creationDate;
  bool hasCreationDate() => _creationDate != null;

  // "editDate" field.
  DateTime? _editDate;
  DateTime? get editDate => _editDate;
  bool hasEditDate() => _editDate != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "ownedBy" field.
  DocumentReference? _ownedBy;
  DocumentReference? get ownedBy => _ownedBy;
  bool hasOwnedBy() => _ownedBy != null;

  // "tripDate" field.
  DateTime? _tripDate;
  DateTime? get tripDate => _tripDate;
  bool hasTripDate() => _tripDate != null;

  // "shareRequests" field.
  List<String>? _shareRequests;
  List<String> get shareRequests => _shareRequests ?? const [];
  bool hasShareRequests() => _shareRequests != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _travelGroup = getStructList(
      snapshotData['travelGroup'],
      TripUserStruct.fromMap,
    );
    _members = getDataList(snapshotData['members']);
    _creationDate = snapshotData['creationDate'] as DateTime?;
    _editDate = snapshotData['editDate'] as DateTime?;
    _image = snapshotData['image'] as String?;
    _ownedBy = snapshotData['ownedBy'] as DocumentReference?;
    _tripDate = snapshotData['tripDate'] as DateTime?;
    _shareRequests = getDataList(snapshotData['shareRequests']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('trip');

  static Stream<TripRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TripRecord.fromSnapshot(s));

  static Future<TripRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TripRecord.fromSnapshot(s));

  static TripRecord fromSnapshot(DocumentSnapshot snapshot) => TripRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TripRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TripRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TripRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TripRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTripRecordData({
  String? name,
  DateTime? creationDate,
  DateTime? editDate,
  String? image,
  DocumentReference? ownedBy,
  DateTime? tripDate,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'creationDate': creationDate,
      'editDate': editDate,
      'image': image,
      'ownedBy': ownedBy,
      'tripDate': tripDate,
    }.withoutNulls,
  );

  return firestoreData;
}

class TripRecordDocumentEquality implements Equality<TripRecord> {
  const TripRecordDocumentEquality();

  @override
  bool equals(TripRecord? e1, TripRecord? e2) {
    const listEquality = ListEquality();
    return e1?.name == e2?.name &&
        listEquality.equals(e1?.travelGroup, e2?.travelGroup) &&
        listEquality.equals(e1?.members, e2?.members) &&
        e1?.creationDate == e2?.creationDate &&
        e1?.editDate == e2?.editDate &&
        e1?.image == e2?.image &&
        e1?.ownedBy == e2?.ownedBy &&
        e1?.tripDate == e2?.tripDate &&
        listEquality.equals(e1?.shareRequests, e2?.shareRequests);
  }

  @override
  int hash(TripRecord? e) => const ListEquality().hash([
        e?.name,
        e?.travelGroup,
        e?.members,
        e?.creationDate,
        e?.editDate,
        e?.image,
        e?.ownedBy,
        e?.tripDate,
        e?.shareRequests
      ]);

  @override
  bool isValidKey(Object? o) => o is TripRecord;
}
