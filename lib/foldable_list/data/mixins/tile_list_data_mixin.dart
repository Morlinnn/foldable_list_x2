import 'package:flutter/material.dart';
import 'package:foldable_list_x2/foldable_list/data/mixins/itile_list_data.dart';

import '../interfaces/lazily_operate.dart';
import '../../global_setting.dart';
import '../../widgets/basic/basic_tile_item.dart';
import '../../widgets/foldable_list.dart';
import '../../widgets/tile_item.dart';

mixin TileListDataMixin implements LazilyOperate, ITileListData {
  @override
  late List<Widget> children;

  @override
  bool clearLazily() {
    if (children.isEmpty) return false;

    children.clear();
    return true;
  }

  // only accept TileItem or FoldableList
  @override
  bool addLazily(Widget widget) {
    if (!_ensureCorrectType(widget)) return false;
    children.add(widget);

    return true;
  }

  @override
  bool insertTopLazily(Widget widget) {
    if (!_ensureCorrectType(widget)) return false;
    children.insert(0, widget);

    return true;
  }

  @override
  bool insertUpperLazily(Widget upperWhich, Widget widget) {
    var index = children.indexOf(upperWhich);

    if (index == -1) return false;

    children.insert(index, widget);
    return true;
  }

  @override
  bool insertUnderLazily(Widget underWhich, Widget widget) {
    var index = children.indexOf(underWhich);

    if (index == -1) return false;

    children.insert(index + 1, widget);
    return true;
  }

  // only accept TileItem or FoldableList
  @override
  bool removeLazily(Widget widget) {
    if (!_ensureCorrectType(widget)) return false;

    if (children.isEmpty) return false;

    children.remove(widget);
    return true;
  }

  bool _ensureCorrectType(Widget widget) {
    if (!GlobalSetting.disableWarning) {
      assert(
      widget is BasicTileItem || widget is FoldableList || widget is TileItem,
      "WARNING: FoldableList only accept TileItem or FoldableList, widget: ${widget.runtimeType}. Is there something wrong?\n${GlobalSetting.disableWarningTip}"
      );
    }

    return widget is BasicTileItem || widget is FoldableList || widget is TileItem;
  }

  @override
  void sortLazily([int Function(Widget, Widget)? compare]) {
    children.sort(compare);
  }

  @override
  void sortDefaultLazily() {
    children.sort((c1, c2) {
      if (c1 is FoldableList && c2 is BasicTileItem) return -1;
      if (c1 is BasicTileItem && c2 is FoldableList) return 1;
      return 0;
    });
  }
}