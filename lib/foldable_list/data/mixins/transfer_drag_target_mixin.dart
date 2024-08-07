import 'package:flutter/material.dart';
import 'package:foldable_list_x2/foldable_list/data/mixins/itransfer_drag_target.dart';

import '../api/basic_tile_controller.dart';
import '../api/tile_item_controller.dart';
import '../../enums/transfer_direction.dart';
import '../../widgets/foldable_list.dart';
import '../../widgets/tile_item.dart';

typedef GetDisplayWidgetFunction = Widget Function();
mixin TransferDragTargetMixin implements ITransferDragTarget {
  @override
  late int transferStatus;
  @override
  late bool enableTransfer;
  @override
  late TransferDirection defaultTransferDirection;

  @override
  Widget wrapIfTransferDragTarget(
      Widget realWidget,
      GetDisplayWidgetFunction getDisplayWidget,
      TileItemController controller
  ) {
    assert(realWidget is TileItem, "Only can be used for TileItem");
    return enableTransfer
        ? DragTarget<Widget>(
            builder: (context, candidateData, rejectedData) {
              if (candidateData.isEmpty && rejectedData.isEmpty) {
                transferStatus = 0;
              } else if (candidateData.isNotEmpty && rejectedData.isEmpty) {
                transferStatus = 1;
              } else if (candidateData.isEmpty && rejectedData.isNotEmpty) {
                transferStatus = -1;
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

              switch (defaultTransferDirection) {
                case TransferDirection.top: {
                  controller.parentController.insertTop(widget);
                }
                case TransferDirection.bottom: {
                  controller.parentController.add(widget);
                }
                case TransferDirection.upper: {
                  controller.parentController.insertUpper(realWidget, widget);
                }
                case TransferDirection.under: {
                  controller.parentController.insertUnder(realWidget, widget);
                }
              }
            },
        )
        : getDisplayWidget();
  }
}