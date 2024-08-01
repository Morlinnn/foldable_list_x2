import '../api/tile_list_controller.dart';

import '../mixins/tree_data_mixin.dart';
import '../others/tree_default_setting.dart';

/// BasicController -┬> BasicTileController -┬> TileItemController -> TileItemControllerImplement
///                  |                       └> FoldableListController -> FoldableListControllerImplement
///                  |                      ┌----^
///                  └> TileListController -┴> TileListViewControllerImplement
abstract interface class BasicController with TreeDataMixin {
  // TreeDataMixin
  @override
  updateTileListViewNameDeeply(TileListController controller);
  @override
  set tileListViewName(String tileListViewName);
  @override
  String get tileListViewName;
  @override
  set defaultSetting(TreeDefaultSetting defaultSetting);
  @override
  TreeDefaultSetting get defaultSetting;
}