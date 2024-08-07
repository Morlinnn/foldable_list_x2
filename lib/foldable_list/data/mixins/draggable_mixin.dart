import 'package:flutter/material.dart';
import 'package:foldable_list_x2/foldable_list/data/mixins/idraggable.dart';

mixin DraggableMixin implements IDraggable {
  @override
  late bool enableDraggable;
  @override
  late List<String> acceptableMigrateTileListViewNameList;

  @override
  Widget wrapIfDraggable(
      Widget realWidget,
      Widget displayWidget,
      Widget feedbackWidget,
      Widget emptyTile,
      double tileHeight,
      double tileWidth
  ) {
    return enableDraggable
      ? Draggable<Widget>(
        data: realWidget,
        feedback: SizedBox(
          height: tileHeight * 0.8,
          width: tileWidth * 0.9,
          child: Material(
            child: feedbackWidget,
          ),
        ),
        childWhenDragging: emptyTile,
        maxSimultaneousDrags: 1,
        child: displayWidget,
      )
      : displayWidget;
  }
}