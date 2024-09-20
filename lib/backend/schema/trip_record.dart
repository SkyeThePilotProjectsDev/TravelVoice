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

  // "logs" field.
  List<DocumentReference>? _logs;
  List<DocumentReference> get logs => _logs ?? const [];
  bool hasLogs() => _logs != null;

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

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _logs = getDataList(snapshotData['logs']);
    _travelGroup = getStructList(
      snapshotData['travelGroup'],
      TripUserStruct.fromMap,
    );
    _members = getDataList(snapshotData['members']);
    _creationDate = snapshotData['creationDate'] as DateTime?;
    _editDate = snapshotData['editDate'] as DateTime?;
    _image = snapshotData['image'] as String?;
    _ownedBy = snapshotData['ownedBy'] as DocumentReference?;
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
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'creationDate': creationDate,
      'editDate': editDate,
      'image': image,
      'ownedBy': ownedBy,
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
        listEquality.equals(e1?.logs, e2?.logs) &&
        listEquality.equals(e1?.travelGroup, e2?.travelGroup) &&
        listEquality.equals(e1?.members, e2?.members) &&
        e1?.creationDate == e2?.creationDate &&
        e1?.editDate == e2?.editDate &&
        e1?.image == e2?.image &&
        e1?.ownedBy == e2?.ownedBy;
  }

  @override
  int hash(TripRecord? e) => const ListEquality().hash([
        e?.name,
        e?.logs,
        e?.travelGroup,
        e?.members,
        e?.creationDate,
        e?.editDate,
        e?.image,
        e?.ownedBy
      ]);

  @override
  bool isValidKey(Object? o) => o is TripRecord;
}
