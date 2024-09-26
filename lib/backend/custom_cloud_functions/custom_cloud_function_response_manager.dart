import '/backend/schema/structs/index.dart';

class FindNewUserInvitationsCloudFunctionCallResponse {
  FindNewUserInvitationsCloudFunctionCallResponse({
    this.errorCode,
    this.succeeded,
    this.jsonBody,
  });
  String? errorCode;
  bool? succeeded;
  dynamic jsonBody;
}
