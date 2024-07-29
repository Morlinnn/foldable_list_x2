import 'package:flutter/material.dart';

import '../../data/api/basic_tile_controller.dart';
import '../../data/api/tile_list_controller.dart';
import '../../data/mixins/tree_data_mixin.dart';
import '../others/tree_default_setting.dart';
import '../../enums/transfer_direction.dart';
import '../../widgets/foldable_list.dart';
import '../../widgets/tile_item.dart';
import '../mixins/divider_mixin.dart';
import '../mixins/rebuild_mixin.dart';
import '../mixins/tile_list_data_mixin.dart';

class TileListViewControllerImplement
    with DividerMixin,
        TileListDataMixin,
        RebuildMixin,
        TreeDataMixin implements TileListController {
  TileListViewControllerImplement({
    required String name,
    TreeDefaultSetting? defaultSetting,
    bool? placeable,
    TransferDirection? defaultDirection,
    bool? enableDivider,
    Divider? divider
  }) {
    children = [];
    tileListViewName = name;
    this.defaultSetting = defaultSetting?? TreeDefaultSetting();
    super.enableDivider = enableDivider?? this.defaultSetting.enableDivider;
    this.divider = divider?? this.defaultSetting.divider;
  }

  @override
  bool isLastWidget(Widget widget) {
    return isRootLastWidget(widget);
  }

  @override
  bool isRootLastWidget(Widget widget) {
    return children.last == widget;
  }

  @override
  bool isFirstWidget(Widget widget) {
    return children.first == widget;
  }

  @override
  bool isRootFirstWidget(Widget widget) {
    return isFirstWidget(widget);
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
}