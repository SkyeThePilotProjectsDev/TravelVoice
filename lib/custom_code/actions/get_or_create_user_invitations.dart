// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<InvitationsRecord> getOrCreateUserInvitations(
  String email,
) async {
  // Add your function code here!
  String _email = email.trim().toLowerCase();
  DocumentReference usersRequests = InvitationsRecord.collection.doc(_email);
  bool docExists = await usersRequests.get().then((u) => u.exists);

  if (!docExists) {
    final data = createInvitationsRecordData();
    await usersRequests.set(data);
  }

  await for (final request in InvitationsRecord.getDocument(usersRequests)) {
    return request;
    // onUpdate?.call(request);
  }

  return await InvitationsRecord.getDocumentOnce(usersRequests);
}
