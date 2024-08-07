import 'package:flutter/material.dart';

abstract interface class IDraggable {
  set enableDraggable(bool enableDraggable);
  bool get enableDraggable;
  set acceptableMigrateTileListViewNameList(List<String> acceptableMigrateTileListViewNameList);
  List<String> get acceptableMigrateTileListViewNameList;
  Widget wrapIfDraggable(Widget realWidget, Widget displayWidget, Widget feedbackWidget, Widget emptyTile, double tileHeight, double tileWidth);
}