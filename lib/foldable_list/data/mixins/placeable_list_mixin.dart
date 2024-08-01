import 'package:flutter/material.dart';
import '../api/tile_list_controller.dart';
import '../mixins/transfer_drag_target_mixin.dart';
import '../../enums/transfer_direction.dart';
import '../../widgets/foldable_list.dart';
import '../../widgets/tile_item.dart';

import '../api/basic_tile_controller.dart';

mixin PlaceableListMixin {
  // 0: default, 1: accept, -1: reject
  late int placeableStatus;
  late bool placeable;
  late TransferDirection defaultPlaceDirection;

  Widget wrapDragTarget(
      GetDisplayWidgetFunction getDisplayWidget,
      TileListController controller
  ) {
    return placeable
      ? DragTarget<Widget>(
        builder: (context, candidateData, rejectedData) {
          if (candidateData.isEmpty && rejectedData.isEmpty) {
            placeableStatus = 0;
          } else if (candidateData.isNotEmpty && rejectedData.isEmpty) {
            placeableStatus = 1;
          } else if (candidateData.isEmpty && rejectedData.isNotEmpty) {
            placeableStatus = -1;
          } else {
            throw Exception("Illegal usage of DragTarget in PlaceableListMixin");
          }
          return getDisplayWidget();
        },
        onWillAcceptWithDetails: (details) {
          var widget = details.data;
          if (!(widget is TileItem || widget is FoldableList)) return false;

          BasicTileController dataController;
          if (widget is TileItem) {
            dataController = widget.controller;
          } else if (widget is FoldableList) {
            dataController = widget.controller;
          } else {
            throw Exception("Unknown exception, it will be impossibly occurred, why it's happen.");
          }

          return dataController.acceptableMigrateTileListViewNameList.isEmpty
              || dataController.acceptableMigrateTileListViewNameList.contains(controller.tileListViewName);
        },
        onAcceptWithDetails: (details) {
          var widget = details.data;
          assert(widget is TileItem || widget is FoldableList);


          // remove from preParentController
          if (widget is TileItem) {
            widget.controller.removeThisWidget();
          } else if (widget is FoldableList) {
            widget.controller.removeThisWidget();
          } else {
            throw Exception("Unknown exception, it will be impossibly occurred, why it's happen.");
          }

          if (defaultPlaceDirection case TransferDirection.top) {
              controller.insertTop(widget);
          } else if (defaultPlaceDirection case TransferDirection.bottom) {
              controller.add(widget);
          } else {
              throw Exception("FoldableList only accept top(insert to top) or bottom(add to end).");
          }
        },
      )
      : getDisplayWidget();
  }
}