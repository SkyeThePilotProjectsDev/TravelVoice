import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TripInvitationRecord extends FirestoreRecord {
  TripInvitationRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "trip" field.
  DocumentReference? _trip;
  DocumentReference? get trip => _trip;
  bool hasTrip() => _trip != null;

  // "invitedBy" field.
  DocumentReference? _invitedBy;
  DocumentReference? get invitedBy => _invitedBy;
  bool hasInvitedBy() => _invitedBy != null;

  // "dateInvited" field.
  DateTime? _dateInvited;
  DateTime? get dateInvited => _dateInvited;
  bool hasDateInvited() => _dateInvited != null;

  // "status" field.
  RequestStatus? _status;
  RequestStatus? get status => _status;
  bool hasStatus() => _status != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _trip = snapshotData['trip'] as DocumentReference?;
    _invitedBy = snapshotData['invitedBy'] as DocumentReference?;
    _dateInvited = snapshotData['dateInvited'] as DateTime?;
    _status = deserializeEnum<RequestStatus>(snapshotData['status']);
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('tripInvitation')
          : FirebaseFirestore.instance.collectionGroup('tripInvitation');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('tripInvitation').doc(id);

  static Stream<TripInvitationRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TripInvitationRecord.fromSnapshot(s));

  static Future<TripInvitationRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TripInvitationRecord.fromSnapshot(s));

  static TripInvitationRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TripInvitationRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TripInvitationRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TripInvitationRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TripInvitationRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TripInvitationRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTripInvitationRecordData({
  DocumentReference? trip,
  DocumentReference? invitedBy,
  DateTime? dateInvited,
  RequestStatus? status,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'trip': trip,
      'invitedBy': invitedBy,
      'dateInvited': dateInvited,
      'status': status,
    }.withoutNulls,
  );

  return firestoreData;
}

class TripInvitationRecordDocumentEquality
    implements Equality<TripInvitationRecord> {
  const TripInvitationRecordDocumentEquality();

  @override
  bool equals(TripInvitationRecord? e1, TripInvitationRecord? e2) {
    return e1?.trip == e2?.trip &&
        e1?.invitedBy == e2?.invitedBy &&
        e1?.dateInvited == e2?.dateInvited &&
        e1?.status == e2?.status;
  }

  @override
  int hash(TripInvitationRecord? e) => const ListEquality()
      .hash([e?.trip, e?.invitedBy, e?.dateInvited, e?.status]);

  @override
  bool isValidKey(Object? o) => o is TripInvitationRecord;
}
