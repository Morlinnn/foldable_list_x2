import 'package:flutter/material.dart';

import '../interfaces/build_widget.dart';
import '../api/basic_controller.dart';
import '../api/tile_list_controller.dart';
import '../interfaces/controller_dependencies_operator.dart';

/// For TileItemController, FoldableListController
abstract interface class BasicTileController implements ControllerDependenciesOperator, BasicController, BuildWidget {
  // BindMixin
  set thisWidget(Widget widget);
  Widget get thisWidget;
  set parentController(TileListController parentController);
  TileListController get parentController;
  void removeThisWidget();
  // DraggableMixin
  set enableDraggable(bool enableDraggable);
  bool get enableDraggable;
  set acceptableMigrateTileListViewNameList(List<String> acceptableMigrateTileListViewNameList);
  List<String> get acceptableMigrateTileListViewNameList;
  Widget wrapIfDraggable(Widget realWidget, Widget displayWidget, Widget feedbackWidget, Widget emptyTile, double tileHeight, double tileWidth);
  // RetractableMixin
  set enableRetract(bool enableRetract);
  bool get enableRetract;
  set autoSetRetract(bool autoSetRetract);
  bool get autoSetRetract;
  set depth(int depth);
  int get depth;
  set retraction(double retraction);
  double get retraction;
  void updateDepth(int parentDepth);
  updateRetractDeeply(TileListController controller);
  Widget wrapIfRetract(Widget widget);
}