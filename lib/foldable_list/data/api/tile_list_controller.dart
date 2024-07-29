import 'package:flutter/material.dart';

import '../../data/interfaces/lazily_operate.dart';
import '../implements/tile_list_view_controller_implement.dart';
import '../../enums/transfer_direction.dart';
import '../interfaces/foldable_list_operate.dart';
import '../mixins/tree_data_mixin.dart';
import '../others/tree_default_setting.dart';

abstract interface class TileListController with TreeDataMixin implements TileListDataOperate, LazilyOperate {
  static TileListController newInstance({
    required String name,
    TreeDefaultSetting? defaultSetting,
    bool? placeable,
    TransferDirection? defaultDirection,
    bool? enableDivider,
    Divider? divider
  }) {
    return TileListViewControllerImplement(
      name: name,
      defaultSetting: defaultSetting,
      placeable: placeable,
      defaultDirection: defaultDirection,
      enableDivider: enableDivider,
      divider: divider
    );
  }

  // RebuildMixin
  set setState(VoidCallback setState);
  void notifyRebuild();
  // DividerMixin
  set enableDivider(bool enableDivider);
  bool get enableDivider;
  set divider(Divider divider);
  Divider get divider;
  bool isLastWidget(Widget widget);
  bool isRootLastWidget(Widget widget);
  bool isFirstWidget(Widget widget);
  bool isRootFirstWidget(Widget widget);
  List<Widget> addChildrenDivider(List<Widget> rawChildren);
  // TileListDataMixin
  set children(List<Widget> children);
  List<Widget> get children;
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