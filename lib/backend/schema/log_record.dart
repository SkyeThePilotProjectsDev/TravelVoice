import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LogRecord extends FirestoreRecord {
  LogRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "recordings" field.
  List<String>? _recordings;
  List<String> get recordings => _recordings ?? const [];
  bool hasRecordings() => _recordings != null;

  // "location" field.
  LocationDataStruct? _location;
  LocationDataStruct get location => _location ?? LocationDataStruct();
  bool hasLocation() => _location != null;

  // "eventDate" field.
  DateTime? _eventDate;
  DateTime? get eventDate => _eventDate;
  bool hasEventDate() => _eventDate != null;

  // "notes" field.
  String? _notes;
  String get notes => _notes ?? '';
  bool hasNotes() => _notes != null;

  // "aiSummary" field.
  String? _aiSummary;
  String get aiSummary => _aiSummary ?? '';
  bool hasAiSummary() => _aiSummary != null;

  // "photo" field.
  String? _photo;
  String get photo => _photo ?? '';
  bool hasPhoto() => _photo != null;

  // "createdBy" field.
  DocumentReference? _createdBy;
  DocumentReference? get createdBy => _createdBy;
  bool hasCreatedBy() => _createdBy != null;

  // "ownedBy" field.
  DocumentReference? _ownedBy;
  DocumentReference? get ownedBy => _ownedBy;
  bool hasOwnedBy() => _ownedBy != null;

  // "editDate" field.
  DateTime? _editDate;
  DateTime? get editDate => _editDate;
  bool hasEditDate() => _editDate != null;

  // "creationDate" field.
  DateTime? _creationDate;
  DateTime? get creationDate => _creationDate;
  bool hasCreationDate() => _creationDate != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _recordings = getDataList(snapshotData['recordings']);
    _location = LocationDataStruct.maybeFromMap(snapshotData['location']);
    _eventDate = snapshotData['eventDate'] as DateTime?;
    _notes = snapshotData['notes'] as String?;
    _aiSummary = snapshotData['aiSummary'] as String?;
    _photo = snapshotData['photo'] as String?;
    _createdBy = snapshotData['createdBy'] as DocumentReference?;
    _ownedBy = snapshotData['ownedBy'] as DocumentReference?;
    _editDate = snapshotData['editDate'] as DateTime?;
    _creationDate = snapshotData['creationDate'] as DateTime?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('log')
          : FirebaseFirestore.instance.collectionGroup('log');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('log').doc(id);

  static Stream<LogRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => LogRecord.fromSnapshot(s));

  static Future<LogRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => LogRecord.fromSnapshot(s));

  static LogRecord fromSnapshot(DocumentSnapshot snapshot) => LogRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static LogRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      LogRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'LogRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is LogRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createLogRecordData({
  LocationDataStruct? location,
  DateTime? eventDate,
  String? notes,
  String? aiSummary,
  String? photo,
  DocumentReference? createdBy,
  DocumentReference? ownedBy,
  DateTime? editDate,
  DateTime? creationDate,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'location': LocationDataStruct().toMap(),
      'eventDate': eventDate,
      'notes': notes,
      'aiSummary': aiSummary,
      'photo': photo,
      'createdBy': createdBy,
      'ownedBy': ownedBy,
      'editDate': editDate,
      'creationDate': creationDate,
    }.withoutNulls,
  );

  // Handle nested data for "location" field.
  addLocationDataStructData(firestoreData, location, 'location');

  return firestoreData;
}

class LogRecordDocumentEquality implements Equality<LogRecord> {
  const LogRecordDocumentEquality();

  @override
  bool equals(LogRecord? e1, LogRecord? e2) {
    const listEquality = ListEquality();
    return listEquality.equals(e1?.recordings, e2?.recordings) &&
        e1?.location == e2?.location &&
        e1?.eventDate == e2?.eventDate &&
        e1?.notes == e2?.notes &&
        e1?.aiSummary == e2?.aiSummary &&
        e1?.photo == e2?.photo &&
        e1?.createdBy == e2?.createdBy &&
        e1?.ownedBy == e2?.ownedBy &&
        e1?.editDate == e2?.editDate &&
        e1?.creationDate == e2?.creationDate;
  }

  @override
  int hash(LogRecord? e) => const ListEquality().hash([
        e?.recordings,
        e?.location,
        e?.eventDate,
        e?.notes,
        e?.aiSummary,
        e?.photo,
        e?.createdBy,
        e?.ownedBy,
        e?.editDate,
        e?.creationDate
      ]);

  @override
  bool isValidKey(Object? o) => o is LogRecord;
}
