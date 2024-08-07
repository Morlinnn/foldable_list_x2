import 'package:flutter/material.dart';
import 'package:foldable_list_x2/foldable_list/data/mixins/transfer_drag_target_mixin.dart';

import '../../enums/transfer_direction.dart';
import '../api/tile_item_controller.dart';

abstract interface class ITransferDragTarget {
  set transferStatus(int transferStatus);
  int get transferStatus;
  set enableTransfer(bool enableTransfer);
  bool get enableTransfer;
  set defaultTransferDirection(TransferDirection defaultTransferDirection);
  TransferDirection get defaultTransferDirection;
  Widget wrapIfTransferDragTarget(Widget realWidget, GetDisplayWidgetFunction displayWidget, TileItemController parentController);
}