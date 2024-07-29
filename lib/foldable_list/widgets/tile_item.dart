import 'package:flutter/material.dart';
import '../data/mixins/transfer_drag_target_mixin.dart';
import '../widgets/basic/basic_tile_item.dart';

import '../data/api/tile_item_controller.dart';
import 'mixins/controllable.dart';

class TileItem extends StatefulWidget with ControllableTile {
  // outer
  // BoxConstraints
  final double tileHeight;

  // title constraints
  final double? titleLeft;
  final double? titleWidth;
  final double? titleRight;

  // DecoratedBox
  final Decoration? decoration;

  // tile margin
  final EdgeInsetsGeometry? tileMargin;
  final EdgeInsetsGeometry? tilePadding;
  final Clip tileClipBehavior;

  // contents
  final Widget? leading;
  final Widget title;
  final Widget? trailing;

  TileItem({
    Key? key,
    required TileItemController controller,
    this.leading,
    required this.title,
    this.titleLeft,
    this.titleWidth,
    this.titleRight,
    this.trailing,
    double? tileHeight,
    Decoration? decoration,
    this.tileMargin,
    this.tilePadding,
    this.tileClipBehavior = Clip.none
  }) :
      decoration = controller.transferStatus==0
          ? decoration
          : controller.transferStatus == 1
          ? controller.defaultSetting.acceptDecoration
          : controller.defaultSetting.rejectDecoration,
      tileHeight = tileHeight?? controller.defaultSetting.tileHeight,
      super(key: key?? UniqueKey())
  {
    // controllable
    this.controller = controller;
    this.controller.updateControllerDependencies(this.controller.parentController);
    this.controller.thisWidget = this;
  }

  TileItem.normal({
    Key? key,
    required TileItemController controller,
    this.leading,
    required this.title,
    this.titleLeft,
    this.titleWidth,
    this.titleRight,
    Widget? trailing,
    double? tileHeight,
    Decoration? decoration,
    this.tileMargin,
    this.tilePadding,
    this.tileClipBehavior = Clip.none
  }) :
      trailing = Row(
            children: [
              if (trailing != null) trailing,
              IconButton(
                onPressed: () {
                  controller.removeThisWidget();
                },
                icon: const Icon(Icons.remove),
              ),
            ],
          ),
      decoration = controller.transferStatus==0
          ? decoration
          : controller.transferStatus == 1
            ? controller.defaultSetting.acceptDecoration
            : controller.defaultSetting.rejectDecoration,
      tileHeight = tileHeight?? controller.defaultSetting.tileHeight,
      super(key: key?? UniqueKey())
  {
    // controllable
    this.controller = controller;
    this.controller.updateControllerDependencies(this.controller.parentController);
    this.controller.thisWidget = this;
  }

  @override
  State<TileItem> createState() => _TileItemState();
}

class _TileItemState extends State<TileItem> {
  late Decoration? decoration;

  @override
  void initState() {
    super.initState();
    widget.controller.setState = () {setState(() {});};

    decoration = widget.decoration;
  }

  @override
  Widget build(BuildContext context) {
    return getDisplayWidget();
  }

  Widget getDisplayWidget() {
    return wrapRetraction(
        wrapIfDraggable(
          wrapIfTransferDragTarget(
            getBasicTileItem
         )
      )
    );
  }

  Widget getBasicTileItem() {
    // change decoration
    var status = widget.controller.transferStatus;
    decoration = status==0
        ? widget.decoration
        : status == 1
          ? widget.controller.defaultSetting.acceptDecoration
          : widget.controller.defaultSetting.rejectDecoration;

    return BasicTileItem(
      title: widget.title,
      leading: widget.leading,
      titleLeft: widget.titleLeft,
      titleWidth: widget.titleWidth,
      titleRight: widget.titleRight,
      trailing: widget.trailing,
      tileHeight: widget.tileHeight,
      decoration: decoration,
      tileMargin: widget.tileMargin,
      tilePadding: widget.tilePadding,
      tileClipBehavior: widget.tileClipBehavior
    );
  }

  Widget wrapIfTransferDragTarget(GetDisplayWidgetFunction func) {
    return widget.controller.wrapIfTransferDragTarget(
        widget,
        func,
        widget.controller
    );
  }

  Widget wrapIfDraggable(Widget widget) {
    return LayoutBuilder(builder: (context, constraints) {
      return this.widget.controller.wrapIfDraggable(
          this.widget,
          widget,
          widget,
          this.widget.controller.defaultSetting.emptyTile,
          this.widget.tileHeight,
          constraints.maxWidth
      );
    });
  }

  Widget wrapRetraction(Widget widget) {
    return this.widget.controller.wrapIfRetract(widget);
  }
}