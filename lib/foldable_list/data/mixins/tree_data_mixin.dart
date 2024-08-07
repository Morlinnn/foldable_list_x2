import 'package:flutter/material.dart';
import 'package:foldable_list_x2/foldable_list/data/mixins/itree_data.dart';

import '../others/tree_default_setting.dart';
import '../../widgets/foldable_list.dart';
import '../../widgets/tile_item.dart';
import '../api/tile_list_controller.dart';

mixin TreeDataMixin implements ITreeData {
  @override
  late String tileListViewName;
  @override
  late final TreeDefaultSetting defaultSetting;

  _notifyChildrenUpdateTileListViewName(List<Widget> children, String listTileWidgetName) {
    for (var c in children) {
      if (c is TileItem) {
        c.controller.tileListViewName = listTileWidgetName;
      } else if (c is FoldableList) {
        _notifyChildrenUpdateTileListViewName(c.controller.children, listTileWidgetName);
      }
    }
  }

  @override
  updateTileListViewNameDeeply(TileListController controller) {
    tileListViewName = controller.tileListViewName;

    if (this is TileListController) {
      _notifyChildrenUpdateTileListViewName(
          (this as TileListController).children,
          tileListViewName
      );
    }
  }
}