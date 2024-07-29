import 'package:flutter/material.dart';

mixin DraggableMixin {
  late bool enableDraggable;
  late List<String> acceptableMigrateTileListViewNameList;

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