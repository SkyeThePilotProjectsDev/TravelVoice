import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RequestsRecord extends FirestoreRecord {
  RequestsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "sentRequests" field.
  List<TripRequestStruct>? _sentRequests;
  List<TripRequestStruct> get sentRequests => _sentRequests ?? const [];
  bool hasSentRequests() => _sentRequests != null;

  // "receivedRequests" field.
  List<TripRequestStruct>? _receivedRequests;
  List<TripRequestStruct> get receivedRequests => _receivedRequests ?? const [];
  bool hasReceivedRequests() => _receivedRequests != null;

  // "joinedTrips" field.
  List<DocumentReference>? _joinedTrips;
  List<DocumentReference> get joinedTrips => _joinedTrips ?? const [];
  bool hasJoinedTrips() => _joinedTrips != null;

  void _initializeFields() {
    _sentRequests = getStructList(
      snapshotData['sentRequests'],
      TripRequestStruct.fromMap,
    );
    _receivedRequests = getStructList(
      snapshotData['receivedRequests'],
      TripRequestStruct.fromMap,
    );
    _joinedTrips = getDataList(snapshotData['joinedTrips']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('requests');

  static Stream<RequestsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => RequestsRecord.fromSnapshot(s));

  static Future<RequestsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => RequestsRecord.fromSnapshot(s));

  static RequestsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      RequestsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RequestsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RequestsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RequestsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RequestsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createRequestsRecordData() {
  final firestoreData = mapToFirestore(
    <String, dynamic>{}.withoutNulls,
  );

  return firestoreData;
}

class RequestsRecordDocumentEquality implements Equality<RequestsRecord> {
  const RequestsRecordDocumentEquality();

  @override
  bool equals(RequestsRecord? e1, RequestsRecord? e2) {
    const listEquality = ListEquality();
    return listEquality.equals(e1?.sentRequests, e2?.sentRequests) &&
        listEquality.equals(e1?.receivedRequests, e2?.receivedRequests) &&
        listEquality.equals(e1?.joinedTrips, e2?.joinedTrips);
  }

  @override
  int hash(RequestsRecord? e) => const ListEquality()
      .hash([e?.sentRequests, e?.receivedRequests, e?.joinedTrips]);

  @override
  bool isValidKey(Object? o) => o is RequestsRecord;
}
