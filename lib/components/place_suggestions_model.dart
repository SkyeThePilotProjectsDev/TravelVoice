import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/place_suggestion_item_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/instant_timer.dart';
import '/util_components/empty_list/empty_list_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import 'place_suggestions_widget.dart' show PlaceSuggestionsWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PlaceSuggestionsModel extends FlutterFlowModel<PlaceSuggestionsWidget> {
  ///  Local state fields for this component.

  List<PlaceSearchStruct> suggestions = [];
  void addToSuggestions(PlaceSearchStruct item) => suggestions.add(item);
  void removeFromSuggestions(PlaceSearchStruct item) =>
      suggestions.remove(item);
  void removeAtIndexFromSuggestions(int index) => suggestions.removeAt(index);
  void insertAtIndexInSuggestions(int index, PlaceSearchStruct item) =>
      suggestions.insert(index, item);
  void updateSuggestionsAtIndex(
          int index, Function(PlaceSearchStruct) updateFn) =>
      suggestions[index] = updateFn(suggestions[index]);

  String? queryText;

  ///  State fields for stateful widgets in this component.

  InstantTimer? instantTimer;
  // Stores action output result for [Backend Call - API (Places Search Multi)] action in PlaceSuggestions widget.
  ApiCallResponse? apiResultfv3;
  // Model for EmptyList component.
  late EmptyListModel emptyListModel;

  @override
  void initState(BuildContext context) {
    emptyListModel = createModel(context, () => EmptyListModel());
  }

  @override
  void dispose() {
    instantTimer?.cancel();
    emptyListModel.dispose();
  }
}
