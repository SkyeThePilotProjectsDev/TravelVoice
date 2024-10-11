import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/auth/firebase_auth/auth_util.dart';

String encryptPassword(String password) {
  return base64.encode(utf8.encode(password));
}

LatLng? locationParser(LocationStruct? location) {
  if (location == null) return null;

  return LatLng(location.lat, location.lng);
}

DateTime dateBuilder(
  String? day,
  String? month,
  String? year,
  DateTime previousDate,
) {
  var pullNumbers = (String str) {
    var matches = RegExp(r'\d+').allMatches(str);
    if (matches.length == 0) return 0;
    return int.parse(matches.map((m) => m.group(0)).join(""));
  };

  int _year = pullNumbers("000" + (year ?? ""));
  if (_year == 0)
    _year = previousDate.year;
  else
    _year = math.min(9999, math.max(1000, _year));
  int _month = pullNumbers("000" + (month ?? ""));
  if (_month == 0)
    _month = previousDate.month;
  else
    _month = math.min(31, math.max(1, _month));
  // print("000" + (day ?? ""));
  // print(pullNumbers("000" + (day ?? "")));
  int _day = pullNumbers("000" + (day ?? ""));
  print("Pulled day: ${'000' + (day ?? '')} -> $_day");
  // print("Pulled day $_day");
  if (_day == 0)
    _day = previousDate.day;
  else
    math.max(0, _day);

  print("$year/$month/$day -> $_year/$_month/$_day ($previousDate)");

  return DateTime(_year, _month, _day);
}

List<String> getPrompts(
  int count,
  List<String>? prompts,
) {
  if (prompts == null || prompts.isEmpty) return [];
  List<String> _prompts = [...prompts];
  _prompts.shuffle();
  List<String> sub = _prompts.sublist(0, math.min(_prompts.length, count));
  return sub;
}

String? defaultRecording() {
  return "https://assets.mixkit.co/active_storage/sfx/1741/1741.wav";
}

String recordingToString(String? recording) {
  return recording ?? "";
}

LocationStruct? reverseLocationParser(LatLng? location) {
  if (location == null) return null;

  return LocationStruct(
    lat: location.latitude,
    lng: location.longitude,
  );
}

Color stringToColour(String? input) {
  if (input == null) return Colors.black;
  try {
    String hash = input.hashCode.toString();
    // int a = int.parse(input.substring(0, 2));
    String r = (hash.substring(2, 4));
    String g = (hash.substring(4, 6));
    String b = (hash.substring(6, 8));

    return Color(int.parse("0xff$r$g$b"));
  } catch (e) {}

  return Colors.black;
}

Color getFontColourForBackground(Color background) {
  print(
      "Font $background ${background.computeLuminance()} ${(background.computeLuminance() > 0.179) ? Colors.black : Colors.white}");
  return (background.computeLuminance() > 0.179) ? Colors.black : Colors.white;
}

bool contains(
  String? outer,
  String? inner,
  bool? caseSensetive,
) {
  if (inner == null) return true;
  if (outer == null) return false;

  return (caseSensetive ?? false)
      ? outer.contains(inner)
      : outer.toLowerCase().contains(inner.toLowerCase());
}

String? getAcronym(String? inp) {
  return inp == null
      ? ":)"
      : RegExp(r"[^\s\-_]+")
          .allMatches(inp)
          .map((m) => m.group(0)![0])
          .join()
          .toUpperCase();
}

String getDisplayName(UsersRecord? user) {
  if (user == null) return "";
  if (user.displayName != null && user.displayName.isNotEmpty)
    return user.displayName;
  return user.email;
}

PlaceSearchStruct? locationToPlace(LocationDataStruct? location) {
  if (location == null) return null;
  return PlaceSearchStruct(
    geometry:
        GeometryStruct(location: reverseLocationParser(location.location)),
    formattedAddress: location.locationText,
  );
}

bool stringEquality(
  String? a,
  String? b,
) {
  if (a == null && b == null) return true;
  if (a == null || b == null) return false;

  return a.trim().toLowerCase() == b.trim().toLowerCase();
}

DocumentReference getPlainInvetationsRef(String email) {
  String _email = email.trim().toLowerCase();
  return FirebaseFirestore.instance.collection('invitations').doc(_email);
}

String? audioPathFix(String? input) {
  return input;
}

List<String> reverseStringList(List<String> input) {
  return input.reversed.toList();
}

LocationDataStruct? placeToLocation(PlaceSearchStruct? place) {
  if (place == null) return null;
  return LocationDataStruct(
    location: locationParser(place.geometry.location),
    locationText: place.formattedAddress,
  );
}

String buildInvite(
  String from,
  String? image,
  String tripName,
) {
  String background = image == null || image.isEmpty
      ? "background-color: #8fbfbf;"
      : "background: url('${image}') no-repeat center; background-size: cover;";
  // return """<div width="100%" style="background-color: #8fbfbf;">
  //   <center>
  //     <h1 style="color: white; font-weight: bold; font-size: 500%; padding: 30px;">Travelvoice</h1>
  //   </center>
  // </div>

  // <center>
  //   <span style="font-size: 200%;"><strong>$from</strong> invites you to join their trip</span>
  // </center>

  // <div style="width: 100%; $background">
  //   <center>
  //     <h1 style="padding: 30px 0; font-size: 200%; color: white;">$tripName</h1>
  //   </center>
  // </div>
  // <h2>Open your Travelvoice app to accept the invitation</h2>
  // <h4>Download the Travelvoice app here {{Play Store URL}} or here {{App store URL}}</h4>""";
  return """
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html dir="ltr" xmlns="http://www.w3.org/1999/xhtml" xmlns:o="urn:schemas-microsoft-com:office:office" lang="en">
 <head>
  <meta charset="UTF-8">
  <meta content="width=device-width, initial-scale=1" name="viewport">
  <meta name="x-apple-disable-message-reformatting">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta content="telephone=no" name="format-detection">
  <title>New Message</title><!--[if (mso 16)]>
      <style type="text/css">
         a {text-decoration: none;}
      </style>
      <![endif]--><!--[if gte mso 9]>
      <style>sup { font-size: 100% !important; }</style>
      <![endif]--><!--[if gte mso 9]>
      <xml>
         <o:OfficeDocumentSettings>
            <o:AllowPNG></o:AllowPNG>
            <o:PixelsPerInch>96</o:PixelsPerInch>
         </o:OfficeDocumentSettings>
      </xml>
      <![endif]-->
  <style type="text/css">
.rollover:hover .rollover-first {
  max-height:0px!important;
  display:none!important;
}
.rollover:hover .rollover-second {
  max-height:none!important;
  display:block!important;
}
.rollover span {
  font-size:0px;
}
u + .body img ~ div div {
  display:none;
}
#outlook a {
  padding:0;
}
span.MsoHyperlink,
span.MsoHyperlinkFollowed {
  color:inherit;
  mso-style-priority:99;
}
a.es-button {
  mso-style-priority:100!important;
  text-decoration:none!important;
}
a[x-apple-data-detectors],
#MessageViewBody a {
  color:inherit!important;
  text-decoration:none!important;
  font-size:inherit!important;
  font-family:inherit!important;
  font-weight:inherit!important;
  line-height:inherit!important;
}
.es-desk-hidden {
  display:none;
  float:left;
  overflow:hidden;
  width:0;
  max-height:0;
  line-height:0;
  mso-hide:all;
}
@media only screen and (max-width:600px) {.es-p-default { } *[class="gmail-fix"] { display:none!important } p, a { line-height:150%!important } h1, h1 a { line-height:120%!important } h2, h2 a { line-height:120%!important } h3, h3 a { line-height:120%!important } h4, h4 a { line-height:120%!important } h5, h5 a { line-height:120%!important } h6, h6 a { line-height:120%!important } .es-header-body p { } .es-content-body p { } .es-footer-body p { } .es-infoblock p { } h1 { font-size:30px!important; text-align:left } h2 { font-size:24px!important; text-align:left } h3 { font-size:20px!important; text-align:left } h4 { font-size:24px!important; text-align:left } h5 { font-size:20px!important; text-align:left } h6 { font-size:16px!important; text-align:left } .es-header-body h1 a, .es-content-body h1 a, .es-footer-body h1 a { font-size:30px!important } .es-header-body h2 a, .es-content-body h2 a, .es-footer-body h2 a { font-size:24px!important } .es-header-body h3 a, .es-content-body h3 a, .es-footer-body h3 a { font-size:20px!important } .es-header-body h4 a, .es-content-body h4 a, .es-footer-body h4 a { font-size:24px!important } .es-header-body h5 a, .es-content-body h5 a, .es-footer-body h5 a { font-size:20px!important } .es-header-body h6 a, .es-content-body h6 a, .es-footer-body h6 a { font-size:16px!important } .es-menu td a { font-size:14px!important } .es-header-body p, .es-header-body a { font-size:14px!important } .es-content-body p, .es-content-body a { font-size:14px!important } .es-footer-body p, .es-footer-body a { font-size:14px!important } .es-infoblock p, .es-infoblock a { font-size:12px!important } .es-m-txt-c, .es-m-txt-c h1, .es-m-txt-c h2, .es-m-txt-c h3, .es-m-txt-c h4, .es-m-txt-c h5, .es-m-txt-c h6 { text-align:center!important } .es-m-txt-r, .es-m-txt-r h1, .es-m-txt-r h2, .es-m-txt-r h3, .es-m-txt-r h4, .es-m-txt-r h5, .es-m-txt-r h6 { text-align:right!important } .es-m-txt-j, .es-m-txt-j h1, .es-m-txt-j h2, .es-m-txt-j h3, .es-m-txt-j h4, .es-m-txt-j h5, .es-m-txt-j h6 { text-align:justify!important } .es-m-txt-l, .es-m-txt-l h1, .es-m-txt-l h2, .es-m-txt-l h3, .es-m-txt-l h4, .es-m-txt-l h5, .es-m-txt-l h6 { text-align:left!important } .es-m-txt-r img, .es-m-txt-c img, .es-m-txt-l img { display:inline!important } .es-m-txt-r .rollover:hover .rollover-second, .es-m-txt-c .rollover:hover .rollover-second, .es-m-txt-l .rollover:hover .rollover-second { display:inline!important } .es-m-txt-r .rollover span, .es-m-txt-c .rollover span, .es-m-txt-l .rollover span { line-height:0!important; font-size:0!important; display:block } .es-spacer { display:inline-table } a.es-button, button.es-button { font-size:18px!important; padding:10px 20px 10px 20px!important; line-height:120%!important } a.es-button, button.es-button, .es-button-border { display:inline-block!important } .es-m-fw, .es-m-fw.es-fw, .es-m-fw .es-button { display:block!important } .es-m-il, .es-m-il .es-button, .es-social, .es-social td, .es-menu { display:inline-block!important } .es-adaptive table, .es-left, .es-right { width:100%!important } .es-content table, .es-header table, .es-footer table, .es-content, .es-footer, .es-header { width:100%!important; max-width:600px!important } .adapt-img { width:100%!important; height:auto!important } .es-mobile-hidden, .es-hidden { display:none!important } .es-desk-hidden { width:auto!important; overflow:visible!important; float:none!important; max-height:inherit!important; line-height:inherit!important } tr.es-desk-hidden { display:table-row!important } table.es-desk-hidden { display:table!important } td.es-desk-menu-hidden { display:table-cell!important } .es-menu td { width:1%!important } table.es-table-not-adapt, .esd-block-html table { width:auto!important } .h-auto { height:auto!important } .es-text-3340 .es-text-mobile-size-20, .es-text-3340 .es-text-mobile-size-20 * { font-size:20px!important; line-height:150%!important } }
@media screen and (max-width:384px) {.mail-message-content { width:414px!important } }
</style>
 </head>
 <body class="body" style="width:100%;height:100%;padding:0;Margin:0">
  <div dir="ltr" class="es-wrapper-color" lang="en" style="background-color:#F6F6F6"><!--[if gte mso 9]>
         <v:background xmlns:v="urn:schemas-microsoft-com:vml" fill="t">
            <v:fill type="tile" color="#f6f6f6"></v:fill>
         </v:background>
         <![endif]-->
   <table width="100%" cellspacing="0" cellpadding="0" class="es-wrapper" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;padding:0;Margin:0;width:100%;height:100%;background-repeat:repeat;background-position:center top;background-color:#F6F6F6">
     <tr>
      <td valign="top" style="padding:0;Margin:0">
       <table cellspacing="0" cellpadding="0" align="center" class="es-header" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;width:100%;table-layout:fixed !important;background-color:transparent;background-repeat:repeat;background-position:center top">
         <tr>
          <td align="center" style="padding:0;Margin:0">
           <table cellspacing="0" cellpadding="0" bgcolor="#ffffff" align="center" class="es-header-body" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;background-color:#FFFFFF;width:600px">
             <tr>
              <td align="left" bgcolor="#8fbfbf" style="padding:0;Margin:0;background-color:#8fbfbf">
               <table width="100%" cellspacing="0" cellpadding="0" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px">
                 <tr>
                  <td valign="top" align="center" style="padding:0;Margin:0;width:600px">
                   <table width="100%" cellspacing="0" cellpadding="0" role="presentation" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px">
                     <tr>
                      <td align="center" style="padding:20px;Margin:0"><h2 style="Margin:0;font-family:arial, 'helvetica neue', helvetica, sans-serif;mso-line-height-rule:exactly;letter-spacing:0;font-size:24px;font-style:normal;font-weight:normal;line-height:28.8px;color:#ffffffff"><strong>Travelvoice</strong></h2></td>
                     </tr>
                   </table></td>
                 </tr>
               </table></td>
             </tr>
           </table></td>
         </tr>
       </table>
       <table cellspacing="0" cellpadding="0" align="center" class="es-content" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;width:100%;table-layout:fixed !important">
         <tr>
          <td align="center" style="padding:0;Margin:0">
           <table cellspacing="0" cellpadding="0" bgcolor="#ffffff" align="center" class="es-content-body" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;background-color:#FFFFFF;width:600px">
             <tr>
              <td align="left" style="padding:0;Margin:0;padding-top:20px;padding-right:20px;padding-left:20px">
               <table cellpadding="0" cellspacing="0" width="100%" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px">
                 <tr>
                  <td align="left" style="padding:0;Margin:0;width:560px">
                   <table cellpadding="0" cellspacing="0" width="100%" role="presentation" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px">
                     <tr>
                      <td align="center" style="padding:0;Margin:0"><p style="Margin:0;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;letter-spacing:0;color:#333333;font-size:14px"><strong>$from</strong> invites you to join their trip</p></td>
                     </tr>
                   </table></td>
                 </tr>
               </table></td>
             </tr>
             <tr>
              <td align="left" style="padding:0;Margin:0;padding-top:20px;padding-right:20px;padding-left:20px">
               <table width="100%" cellpadding="0" cellspacing="0" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px">
                 <tr>
                  <td align="left" style="padding:0;Margin:0;width:560px">
                   <table width="100%" role="presentation" cellpadding="0" cellspacing="0" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px">
                     <tr>
                      <td align="center" bgcolor="#8fbfbf" class="es-text-3340" style="padding:0;Margin:0;padding-top:30px;padding-bottom:30px;$background"><p class="es-text-mobile-size-20" style="Margin:0;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:30px !important;letter-spacing:0;color:#fff;font-size:20px"><strong>$tripName</strong></p></td>
                     </tr>
                   </table></td>
                 </tr>
               </table></td>
             </tr>
           </table></td>
         </tr>
       </table>
       <table cellspacing="0" cellpadding="0" align="center" class="es-footer" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;width:100%;table-layout:fixed !important;background-color:transparent;background-repeat:repeat;background-position:center top">
         <tr>
          <td align="center" style="padding:0;Margin:0">
           <table cellspacing="0" cellpadding="0" bgcolor="#ffffff" align="center" class="es-footer-body" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;background-color:#FFFFFF;width:600px">
             <tr>
              <td align="left" style="Margin:0;padding-top:20px;padding-right:20px;padding-left:20px;padding-bottom:10px">
               <table cellpadding="0" cellspacing="0" width="100%" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px">
                 <tr>
                  <td align="left" style="padding:0;Margin:0;width:560px">
                   <table width="100%" role="presentation" cellpadding="0" cellspacing="0" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px">
                     <tr>
                      <td align="left" style="padding:0;Margin:0"><h5 style="Margin:0;font-family:arial, 'helvetica neue', helvetica, sans-serif;mso-line-height-rule:exactly;letter-spacing:0;font-size:20px;font-style:normal;font-weight:normal;line-height:24px;color:#333333">Open your Travelvoice app to accept the invitation</h5></td>
                     </tr>
                   </table></td>
                 </tr>
               </table></td>
             </tr>
             <tr>
              <td align="left" style="padding:0;Margin:0;padding-right:20px;padding-left:20px">
               <table cellspacing="0" width="100%" cellpadding="0" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px">
                 <tr>
                  <td align="left" style="padding:0;Margin:0;width:560px">
                   <table role="presentation" cellpadding="0" cellspacing="0" width="100%" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px">
                     <tr>
                      <td align="left" style="padding:0;Margin:0;padding-top:10px;padding-bottom:20px"><p style="Margin:0;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;letter-spacing:0;color:#333333;font-size:14px">Download the Travelvoice app here {{Play Store URL}} or here {{App store URL}}</p></td>
                     </tr>
                   </table></td>
                 </tr>
               </table></td>
             </tr>
           </table></td>
         </tr>
       </table></td>
     </tr>
   </table>
  </div>
 </body>
</html>""";
}

String emptyAudio() {
  return "";
}

List<String> stringListConcat(
  List<String>? l1,
  List<String>? l2,
) {
  if (l1 == null) return l2 ?? [];
  if (l2 == null) return l1;

  return [...l1, ...l2];
}

List<String>? stringListReduce(
  List<String>? items,
  List<String>? removed,
) {
  if (items == null) return [];
  if (removed == null || removed.isEmpty) return items;

  return items
      .where((i) => !removed
          .map((r) => r.toLowerCase().trim())
          .contains(i.toLowerCase().trim()))
      .toList();
}
