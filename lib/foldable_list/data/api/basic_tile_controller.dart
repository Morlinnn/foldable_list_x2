import 'package:flutter/material.dart';
import '../../data/api/tile_list_controller.dart';

import '../interfaces/controller_dependencies_operator.dart';
import '../mixins/tree_data_mixin.dart';
import '../others/tree_default_setting.dart';

// For TileItemController, FoldableListController
abstract interface class BasicTileController with TreeDataMixin implements ControllerDependenciesOperator {
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
  @override
  updateTileListViewNameDeeply(TileListController controller);
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
  // TreeDataMixin
  @override
  set tileListViewName(String tileListViewName);
  @override
  String get tileListViewName;
  @override
  set defaultSetting(TreeDefaultSetting defaultSetting);
  @override
  TreeDefaultSetting get defaultSetting;
}