import 'package:flutter/material.dart';

import '../../data/mixins/transfer_drag_target_mixin.dart';
import '../../enums/transfer_direction.dart';
import '../api/tile_list_controller.dart';

abstract interface class IPlaceable {
  // PlaceableMixin
  set placeableStatus(int placeableStatus);
  int get placeableStatus;
  set placeable(bool placeable);
  bool get placeable;
  set defaultPlaceDirection(TransferDirection defaultPlaceDirection);
  TransferDirection get defaultPlaceDirection;
  Widget wrapDragTarget(GetDisplayWidgetFunction displayWidget, TileListController controller);
}