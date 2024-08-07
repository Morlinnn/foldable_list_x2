import 'package:flutter/material.dart';
import 'package:foldable_list_x2/foldable_list/data/mixins/iexpandable.dart';
import 'package:foldable_list_x2/foldable_list/data/mixins/iplaceable.dart';
import '../api/basic_tile_controller.dart';
import '../api/tile_list_controller.dart';
import '../implements/foldable_list_controller_implement.dart';

import '../../enums/transfer_direction.dart';

// For FoldableListController
abstract interface class FoldableListController
    implements BasicTileController,
        TileListController,
        IExpandable,
        IPlaceable
{
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
}