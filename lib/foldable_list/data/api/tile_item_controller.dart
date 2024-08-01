import 'package:flutter/material.dart';

import '../api/basic_tile_controller.dart';
import '../api/tile_list_controller.dart';
import '../mixins/transfer_drag_target_mixin.dart';
import '../implements/tile_item_controller_implement.dart';
import '../../enums/transfer_direction.dart';

// For TileItemController
abstract interface class TileItemController implements BasicTileController {
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

  // RebuildMixin
  set setState(VoidCallback setState);
  void notifyRebuild();
  // TransferDragTargetMixin
  set transferStatus(int transferStatus);
  int get transferStatus;
  set enableTransfer(bool enableTransfer);
  bool get enableTransfer;
  set defaultTransferDirection(TransferDirection defaultTransferDirection);
  TransferDirection get defaultTransferDirection;
  Widget wrapIfTransferDragTarget(Widget realWidget, GetDisplayWidgetFunction displayWidget, TileItemController parentController);
}