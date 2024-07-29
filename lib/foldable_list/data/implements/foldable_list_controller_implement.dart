import 'package:flutter/material.dart';

import '../../data/api/foldable_list_controller.dart';
import '../../data/api/tile_list_controller.dart';
import '../../data/mixins/retractable_mixin.dart';
import '../../data/mixins/tree_data_mixin.dart';
import '../../enums/transfer_direction.dart';
import '../../data/mixins/bind_mixin.dart';
import '../../data/mixins/divider_mixin.dart';
import '../../data/mixins/draggable_mixin.dart';
import '../../data/mixins/expandable_mixin.dart';
import '../../data/mixins/placeable_list_mixin.dart';
import '../../data/mixins/rebuild_mixin.dart';
import '../../data/mixins/tile_list_data_mixin.dart';
import '../../widgets/foldable_list.dart';
import '../../widgets/tile_item.dart';
import '../api/basic_tile_controller.dart';

class FoldableListControllerImplement
    with ExpandableMixin,
        TileListDataMixin,
        PlaceableListMixin,
        DraggableMixin,
        RebuildMixin,
        BindMixin, DividerMixin,
        RetractableMixin,
        TreeDataMixin
    implements FoldableListController {
  FoldableListControllerImplement({
    required TileListController parentController,
    bool? enableRetract,
    bool autoSetRetract = true,
    int depth = 0,
    double? retraction,
    bool? enableDivider,
    Divider? divider,
    bool? isExpanded,
    bool? placeable,
    TransferDirection? defaultDirection,
    bool? enableDraggable,
    List<String>? acceptableMigrateTileListViewNameList
  }) {
    children = [];
    this.parentController = parentController;
    super.enableRetract = enableRetract?? parentController.defaultSetting.enableRetract;
    this.autoSetRetract = autoSetRetract;
    this.depth = depth;
    this.retraction = retraction?? parentController.defaultSetting.retraction;
    super.enableDivider = enableDivider?? parentController.defaultSetting.enableDivider;
    this.divider = divider?? parentController.defaultSetting.divider;
    super.isExpanded = isExpanded?? parentController.defaultSetting.isExpanded;
    placeableStatus = 0;
    defaultSetting = parentController.defaultSetting;
    super.placeable = placeable?? parentController.defaultSetting.placeable;
    defaultPlaceDirection = defaultDirection?? parentController.defaultSetting.defaultPlaceDirection;
    tileListViewName = parentController.tileListViewName;
    super.enableDraggable = enableDraggable?? parentController.defaultSetting.enableDraggable;
    this.acceptableMigrateTileListViewNameList = acceptableMigrateTileListViewNameList?? [];
  }

  @override
  bool isLastWidget(Widget widget) {
    return children.last == widget;
  }

  @override
  bool isRootLastWidget(Widget widget) {
    return parentController.isRootLastWidget(thisWidget) && isLastWidget(widget);
  }

  @override
  bool isFirstWidget(Widget widget) {
    return children.first == widget;
  }

  @override
  bool isRootFirstWidget(Widget widget) {
    return parentController.isRootFirstWidget(thisWidget) && isFirstWidget(widget);
  }

  @override
  set isExpanded(bool isExpanded) {
    super.isExpanded = isExpanded;

    notifyRebuild();
  }

  @override
  set placeable(bool placeable) {
    super.placeable = placeable;

    notifyRebuild();
  }

  @override
  set enableDraggable(bool draggable) {
    super.enableDraggable = draggable;

    notifyRebuild();
  }

  @override
  set enableDivider(bool enableDivider) {
    super.enableDivider = enableDivider;

    notifyRebuild();
  }

  @override
  bool clear() {
    var res = super.clearLazily();
    if (res) notifyRebuild();
    return res;
  }

  @override
  bool add(Widget widget) {
    var res = super.addLazily(widget);
    if (res) _whenAddWidget(widget);
    return res;
  }

  @override
  bool insertTop(Widget widget) {
    var res = super.insertTopLazily(widget);
    if (res) _whenAddWidget(widget);
    return res;
  }

  _whenAddWidget(Widget widget) {
    BasicTileController controller;
    TileListController widgetParentController;

    if (widget is TileItem) {
      controller = widget.controller;
      widgetParentController = widget.controller.parentController;
    } else if (widget is FoldableList) {
      controller = widget.controller;
      widgetParentController = widget.controller.parentController;
    } else {
      throw Exception("Unknown widget is not a sub type(${widget.runtimeType}) of TileItem or FoldableList");
    }

    // If widget is came from another controller.
    if (widgetParentController != this) {
      // Update its parent controller and others;
      controller.updateControllerDependencies(this);
    }

    notifyRebuild();
  }

  @override
  bool insertUnder(Widget underWhich, Widget widget) {
    var res = super.insertUnderLazily(underWhich, widget);
    if (res) _whenAddWidget(widget);
    return res;
  }

  @override
  bool insertUpper(Widget upperWhich, Widget widget) {
    var res = super.insertUpperLazily(upperWhich, widget);
    if (res) _whenAddWidget(widget);
    return res;
  }

  @override
  bool remove(Widget widget) {
    var res = super.removeLazily(widget);
    if (res) notifyRebuild();
    return res;
  }

  @override
  sort([int Function(Widget p1, Widget p2)? compare]) {
    super.sortLazily(compare);

    notifyRebuild();
  }

  @override
  sortDefault() {
    super.sortDefaultLazily();

    notifyRebuild();
  }

  @override
  updateControllerDependencies(TileListController parentController) {
    this.parentController = parentController;

    tileListViewName = parentController.tileListViewName;

    for (var c in children) {
      if (c is TileItem) {
        c.controller.updateControllerDependencies(this);
      } else if (c is FoldableList) {
        c.controller.updateControllerDependencies(this);
      }
    }

    updateRetractDeeply(parentController);
    updateTileListViewNameDeeply(parentController);
  }

}