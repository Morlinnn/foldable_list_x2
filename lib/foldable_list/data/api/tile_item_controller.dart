import 'package:foldable_list_x2/foldable_list/data/mixins/irebuild.dart';
import 'package:foldable_list_x2/foldable_list/data/mixins/itransfer_drag_target.dart';

import '../api/basic_tile_controller.dart';
import '../api/tile_list_controller.dart';
import '../implements/tile_item_controller_implement.dart';
import '../../enums/transfer_direction.dart';

// For TileItemController
abstract interface class TileItemController
    implements BasicTileController,
          IRebuild,
          ITransferDragTarget
{
  static TileItemController newInstance({
    required TileListController parentController,
    bool? enableRetract,
    bool autoSetRetract = true,
    int depth = 0,
    double? retraction,
    bool? draggable,
    List<String>? acceptableMigrateTileListViewNameList,
    bool? enableTransfer,
    TransferDirection? defaultDirection
  }) {
    return TileItemControllerImplement(
      parentController: parentController,
      enableRetract: enableRetract,
      autoSetRetract: autoSetRetract,
      depth: depth,
      retraction: retraction,
      enableDraggable: draggable,
      acceptableMigrateTileListViewNameList: acceptableMigrateTileListViewNameList,
      enableTransfer: enableTransfer,
      defaultDirection: defaultDirection,
    );
  }

  }