import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/empty_list_widget.dart';
import '/components/place_suggestion_item_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/instant_timer.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'place_suggestions_model.dart';
export 'place_suggestions_model.dart';

class PlaceSuggestionsWidget extends StatefulWidget {
  const PlaceSuggestionsWidget({
    super.key,
    required this.query,
    required this.onSelect,
  });

  final String? query;
  final Future Function(PlaceSearchStruct suggestion)? onSelect;

  @override
  State<PlaceSuggestionsWidget> createState() => _PlaceSuggestionsWidgetState();
}

class _PlaceSuggestionsWidgetState extends State<PlaceSuggestionsWidget> {
  late PlaceSuggestionsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PlaceSuggestionsModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await actions.printToConsoleAction(
        'Search: ${widget.query}',
      );
      _model.instantTimer = InstantTimer.periodic(
        duration: const Duration(milliseconds: 1000),
        callback: (timer) async {
          if (widget.query != _model.queryText) {
            _model.apiResultfv3 = await PlacesSearchMultiCall.call(
              query: widget.query,
            );

            if ((_model.apiResultfv3?.succeeded ?? true)) {
              _model.suggestions = PlacesSearchMultiCall.placesSearchResponse(
                (_model.apiResultfv3?.jsonBody ?? ''),
              )!
                  .toList()
                  .cast<PlaceSearchStruct>();
              safeSetState(() {});
            } else {
              _model.suggestions = [];
              safeSetState(() {});
            }

            _model.queryText = widget.query;
            safeSetState(() {});
          }
        },
        startImmediately: true,
      );
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        width: 300.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Builder(
          builder: (context) {
            if (_model.queryText == widget.query) {
              return Builder(
                builder: (context) {
                  final place = _model.suggestions.toList();
                  if (place.isEmpty) {
                    return const EmptyListWidget(
                      customText: 'No places found',
                    );
                  }

                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: List.generate(place.length, (placeIndex) {
                      final placeItem = place[placeIndex];
                      return InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          await widget.onSelect?.call(
                            placeItem,
                          );
                        },
                        child: PlaceSuggestionItemWidget(
                          key: Key('Keywld_${placeIndex}_of_${place.length}'),
                          place: placeItem,
                        ),
                      );
                    }),
                  );
                },
              );
            } else {
              return wrapWithModel(
                model: _model.emptyListModel,
                updateCallback: () => safeSetState(() {}),
                child: const EmptyListWidget(
                  customText: 'Loading...',
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
