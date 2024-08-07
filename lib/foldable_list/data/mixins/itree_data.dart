import '../api/tile_list_controller.dart';
import '../others/tree_default_setting.dart';

abstract interface class ITreeData {
  updateTileListViewNameDeeply(TileListController controller);
  set tileListViewName(String tileListViewName);
  String get tileListViewName;
  set defaultSetting(TreeDefaultSetting defaultSetting);
  TreeDefaultSetting get defaultSetting;
}