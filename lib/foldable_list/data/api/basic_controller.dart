import '../mixins/itree_data.dart';

/// BasicController -┬> BasicTileController -┬> TileItemController -> TileItemControllerImplement
///                  |                       └> FoldableListController -> FoldableListControllerImplement
///                  |                      ┌----^
///                  └> TileListController -┴> TileListViewControllerImplement
abstract interface class BasicController implements ITreeData {
}