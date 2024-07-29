import 'package:flutter/material.dart';
import '../../data/api/basic_tile_controller.dart';
import '../../data/api/tile_list_controller.dart';
import '../../data/implements/foldable_list_controller_implement.dart';
import '../../data/interfaces/lazily_operate.dart';

import '../../enums/transfer_direction.dart';
import '../mixins/transfer_drag_target_mixin.dart';

// For FoldableListController
abstract interface class FoldableListController implements BasicTileController, TileListController, LazilyOperate {
  // TODO check accept by acceptableMigrateTileListViewNameList
  static FoldableListController newInstance({
    required TileListController parentController,
    bool? enableDivider,
    Divider? divider,
    bool? isExpanded,
    bool? placeable,
    TransferDirection? defaultDirection,
    bool? draggable,
    List<String>? acceptableMigrateTileListViewNameList
  }) {
      return FoldableListControllerImplement(
        parentController: parentController,
        enableDivider: enableDivider,
        divider: divider,
        isExpanded: isExpanded,
        placeable: placeable,
        defaultDirection: defaultDirection,
        enableDraggable: draggable,
          acceptableMigrateTileListViewNameList: acceptableMigrateTileListViewNameList
      );
  }

  // ExpandableMixin
  set isExpanded(bool isExpanded);
  bool get isExpanded;
  void changeExpanded();
  // PlaceableMixin
  set placeableStatus(int placeableStatus);
  int get placeableStatus;
  set placeable(bool placeable);
  bool get placeable;
  set defaultPlaceDirection(TransferDirection defaultPlaceDirection);
  TransferDirection get defaultPlaceDirection;
  Widget wrapDragTarget(GetDisplayWidgetFunction displayWidget, TileListController controller);
}