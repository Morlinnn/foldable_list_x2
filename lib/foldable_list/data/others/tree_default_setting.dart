import 'package:flutter/material.dart';
import '../../global_setting.dart';
import '../../enums/transfer_direction.dart';

class TreeDefaultSetting {
  // Foldable PlaceableMixin
  final bool placeable;
  // Foldable/TileListView DividerMixin
  final Divider divider;
  final bool enableDivider;
  // TileItem/Foldable DraggableMixin
  final bool enableDraggable;
  // Foldable ExpandableMixin
  final bool isExpanded;
  final TransferDirection defaultPlaceDirection;
  // Foldable/TileItem RetractableMixin
  final bool enableRetract;
  final double retraction;
  // TileItem TransferDragTargetMixin
  final bool enableTransfer;
  final TransferDirection defaultTransferDirection;
  // other
  late final double tileHeight;
  late final Widget emptyTile;
  final BoxDecoration acceptDecoration;
  final BoxDecoration rejectDecoration;

  TreeDefaultSetting({
    this.placeable = true,
    this.divider = const Divider(height: 0),
    this.enableDivider = true,
    this.enableDraggable = false,
    this.isExpanded = true,
    this.defaultPlaceDirection = TransferDirection.bottom,
    this.enableRetract = true,
    this.retraction = 20,
    this.enableTransfer = true,
    this.defaultTransferDirection = TransferDirection.under,
    double? tileHeight,
    Widget? emptyTile,
    this.acceptDecoration = const BoxDecoration(border: Border.fromBorderSide(BorderSide(color: Colors.blue, width: 0.7))),
    this.rejectDecoration = const BoxDecoration(border: Border.fromBorderSide(BorderSide(color: Colors.red, width: 0.7))),
  }) :
      tileHeight = tileHeight?? GlobalSetting.tileHeight,
      emptyTile = emptyTile?? Container(height: tileHeight?? GlobalSetting.tileHeight, color: const Color.fromRGBO(220, 220, 220, 0.5),);
}