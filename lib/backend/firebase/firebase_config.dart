import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyA0s1E7xDcSajbhJD7l-JpEBgRlr-wUH04",
            authDomain: "travel-voice-b342b.firebaseapp.com",
            projectId: "travel-voice-b342b",
            storageBucket: "travel-voice-b342b.appspot.com",
            messagingSenderId: "383372276654",
            appId: "1:383372276654:web:295c7ec3bfe57e3fa0ce3f",
            measurementId: "G-B7SXG2TBZH"));
  } else {
    await Firebase.initializeApp();
  }
}
