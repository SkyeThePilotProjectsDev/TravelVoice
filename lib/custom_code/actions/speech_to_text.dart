// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// import 'package:google_speech/google_speech.dart' as stt;
// import 'package:http/http.dart' as http;

Future<String> speechToText(List<String>? recordings) async {
  // Add your function code here!
  if (recordings == null) return "";

//   var json = r'''{
//   "type": "service_account",
//   "project_id": "travel-voice-b342b",
//   "private_key_id": "f5305026157a87695d9f08c4f7b34aee73811cb9",
//   "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQCy8B9wEGt8zL72\npitgO5m98FRs67xx9ZE9OiG5j2fwc5zAKT4KSLeBuABYuDgWY1JozARf8GAEH023\nJ/o3rG7KPXCj252sJ5E+9wX3G1E57IaNy/3f4rF1bsrQhkm+rSUVywgnXKGzXdrY\n+1+4TwYt1zHmUkUAQ3sFUZjicHZ3N72Gfb5dcg8e8KRctDGFYH33efSxRWqYCaVZ\nJJU3QOvZM437ZcrmCHKCxqp7xslTV8R9PH+PgHqfoO+R7wfE4iDkeTZac9mkR5/F\ne+co3tTWSn9vUUNSQGvIVBAU/EknboceNbt9paVL83Psbzb/EVK9MwWMFE2t3r9B\nSVYglLd/AgMBAAECggEAU+wcwoFg+EJK2gFrXJH3dEbQQdl6I3SJ7s5h3NauZ+7B\nOLrfFxGtx1AWEYYtAAsLLo1pC9oAHk7UMy+zwgLEX2PbfW5WD9Tq4T4X9SJBwUn2\nfXCMHEIE+s/AnXYuBhjMyODVbSibyjUdnCChbx7ZBgzkoWI6bHo5q2/upV0boqOe\nyght1Dx7QZi5Ozx/efqLm3NRsm1q0SmqHI64XS/BmaBIt6jhDaddz5ZhAw5HpwUi\nb1nINf+Dj5CZDQbrZ/8d8xjvETDw2ZjHMkj68GowhHjau29mELHDU3vm+NOMdz91\nPTR+azb002ah5oDMQR9D1BeAoCXfjL8CILq/hDbU2QKBgQDwVf5N6a0qyUCNKjVO\novLbGc3WXM4dbNr3iBpeDi905PufC8R78kU79qGxDTrDVXl1RhTqUv01VOewtJ44\nCJyvTEW3w5d6tZI3n5Bcbsu6vq3FfRirKnsTPsHeX47kfKckKyOHO3m7J6XhRSQf\nKGHMxGy4KQ/z+FCW8o5LsNl//QKBgQC+mbRWDY5xZc3Zv42dJOQsjnEZk4v86qW6\nO5t6NzwAUQKAcHhzOCeP35adYzFGq4hLfy37qjRRavia+Zmq482pFCZzSUMUj5B6\nnubTczIzspLHuC94YWg2wQe3jbYs7teBwqAJgFE+XgJJeeeAEJ/OtBwfssTJwjoa\n4kIjkqaYKwKBgQDeb7ieg9gx8XI9NQOBdG8xOgC4lcxuj4FZ+C3vP1HM7uGzokCI\nNwK9LNcZ9xScFVAEqohRF94iriKB+ak2U0IxPHaKTgy1Fbfuo1AJPMJyZGiQj+d1\nBCxE86CbH/Ywou5PG14Wm4VfIqL0i/mSnN1nl6TIDbkmJHzyOCxbAaNMQQKBgQCK\n6tArYBoPwFl2eUyn2jmL2A3KzGVdY1CDGerJ+vP6bxDZuB+yKp17GUVXVPKXRXJD\nRGCpanZTWRn1KjK8AOjmcM9Ne3ouxCxTkvk96FoQn/inJDFFFgm0zp/nQpwix7m+\n07F8+087m50jHHyENJmlOFS/LbaMLsnWyk3WS46snQKBgQDI0duDnr32I5msiHZZ\nws8uvwo75TgMSMogxfnAR8uwaXvHRZkft8Xc8vHEmhHpXpnKVCKV9GyNgEBJ7M4a\nWelR3dz4U415R3DaIEEiTzb4ycWo0Vt78siRzFA+vZuE0/iGFU6vOOqKBQdFl6cj\nMKAMFyHJQ9eTL2fIyCz5Jmc97g==\n-----END PRIVATE KEY-----\n",
//   "client_email": "travel-voice-b342b@appspot.gserviceaccount.com",
//   "client_id": "102140641826747066163",
//   "auth_uri": "https://accounts.google.com/o/oauth2/auth",
//   "token_uri": "https://oauth2.googleapis.com/token",
//   "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
//   "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/travel-voice-b342b%40appspot.gserviceaccount.com",
//   "universe_domain": "googleapis.com"
// }''';

//   stt.ServiceAccount serviceAccount = stt.ServiceAccount.fromString(
//     json,
//   );

//   stt.SpeechToText speechToText =
//       stt.SpeechToText.viaServiceAccount(serviceAccount);

//   List<Future<http.Response>> futureResponses = recordings
//       .map(
//         (r) => http.get(
//           Uri.parse(r),
//         ),
//       )
//       .toList();

//   List<http.Response> responses = await Future.wait(futureResponses);
//   final config = stt.RecognitionConfig(
//       encoding: stt.AudioEncoding.LINEAR16,
//       model: stt.RecognitionModel.basic,
//       enableAutomaticPunctuation: true,
//       sampleRateHertz: 16000,
//       languageCode: 'en-US');

//   var futureRecognition = responses
//       .map((r) => speechToText.recognize(config, r.bodyBytes.toList()));
//   var recognition = await Future.wait(futureRecognition);

//   recognition.map((r) => r.writeToJson()).map(print);
// final response = await stt..recognize(config, audio);
//   if (recordings == null) return "";
  return "";
}
