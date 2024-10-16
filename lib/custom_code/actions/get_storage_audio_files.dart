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

import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

Future<List<FFUploadedFile>?> getStorageAudioFiles(List<String>? paths) async {
  // Add your function code here!
  if (paths == null) return [];
  final appDocDir = await getApplicationDocumentsDirectory();

  List<FFUploadedFile> uploadedFiles = await Future.wait(paths
      .map((filePath) => File(filePath))
      .map((file) async => FFUploadedFile(
            name: file.path.split("/").last,
            bytes: await file.readAsBytes(),
          )));

//   for(String filePath in paths) {
//     final file = File(filePath);

//   }

// // Create the file metadata
//   final metadata = SettableMetadata(contentType: "image/jpeg");

// // Create a reference to the Firebase Storage bucket
//   final storageRef = FirebaseStorage.instance.ref();

// // Upload file and metadata to the path 'images/mountains.jpg'
//   final uploadTask =
//       storageRef.child("images/path/to/mountains.jpg").putFile(file, metadata);

// // Listen for state changes, errors, and completion of the upload.
//   uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
//     switch (taskSnapshot.state) {
//       case TaskState.running:
//         final progress =
//             100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
//         print("Upload is $progress% complete.");
//         break;
//       case TaskState.paused:
//         print("Upload is paused.");
//         break;
//       case TaskState.canceled:
//         print("Upload was canceled");
//         break;
//       case TaskState.error:
//         // Handle unsuccessful uploads
//         break;
//       case TaskState.success:
//         // Handle successful uploads on complete
//         // ...
//         break;
//     }
//   });
  return uploadedFiles;
}
