import 'package:flutter/material.dart';

import '../widgets/foldable_list_contents.dart';
import '../data/api/foldable_list_controller.dart';
import 'basic/basic_tile_item.dart';
import 'expand_icon_button.dart';
import 'mixins/controllable.dart';

class FoldableList extends StatefulWidget with ControllableList {

  // basic tile item
  final double tileHeight;
  final Decoration? decoration;
  final EdgeInsetsGeometry? tileMargin;
  final EdgeInsetsGeometry? tilePadding;
  final Clip tileClipBehavior;
  final Widget? leading;
  final double? titleLeft;
  final double? titleWidth;
  final double? titleRight;
  final Widget title;
  final Widget? trailing;

  FoldableList({
    Key? key,
    required FoldableListController controller,
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
    assert(!(titleLeft != null && titleWidth != null && titleRight != null), "cannot set all of these options"),
    decoration = controller.placeableStatus==0
      ? decoration
      : controller.placeableStatus == 1
        ? controller.defaultSetting.acceptDecoration
        : controller.defaultSetting.rejectDecoration,
    tileHeight = tileHeight?? controller.defaultSetting.tileHeight,
    super(key: key?? UniqueKey()) {
    // controllable
    this.controller = controller;
    this.controller.updateControllerDependencies(this.controller.parentController);
    this.controller.thisWidget = this;
  }

  FoldableList.normal({
    Key? key,
    required FoldableListController controller,
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
    assert(!(titleLeft != null && titleWidth != null && titleRight != null), "cannot set all of these options"),
    decoration = controller.placeableStatus==0
        ? decoration
        : controller.placeableStatus == 1
        ? controller.defaultSetting.acceptDecoration
        : controller.defaultSetting.rejectDecoration,
    tileHeight = tileHeight?? controller.defaultSetting.tileHeight,
    trailing = Row(
      children: [
        if (trailing != null) trailing,
        IconButton(
          onPressed: () {
            controller.removeThisWidget();
          },
          icon: const Icon(Icons.remove),
        ),
        // expand widget
        ExpandIconButton(controller: controller)
      ],
    ),
    super(key: key?? UniqueKey()) {
    // controllable
    this.controller = controller;
    this.controller.updateControllerDependencies(this.controller.parentController);
    this.controller.thisWidget = this;
  }

  @override
  State<FoldableList> createState() => _FoldableListState();
}

class _FoldableListState extends State<FoldableList> {
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
    return wrapIfDraggable();
  }

  Widget wrapIfDraggable() {
    return LayoutBuilder(builder: (context, constraints) {
      return widget.controller.wrapIfDraggable(
          widget,
          _getDisplayWidget(),
          getTile(),
          widget.controller.defaultSetting.emptyTile,
          widget.tileHeight,
          constraints.maxWidth
      );
    });
  }

  Widget _getDisplayWidget() {
    var children = [getDisplayTile()];
    if (widget.controller.isExpanded) children.add(getContents());

    return Column(
      children: children,
    );
  }

  Widget getContents() {
    return FoldableListContents(
      children: widget.controller.addChildrenDivider(widget.controller.children),
    );
  }

  Widget getDisplayTile() {
    return wrapDragTarget();
  }

  Widget wrapDragTarget() {
    return widget.controller.wrapDragTarget(
        _getWrappedRectTile,
        widget.controller
    );
  }

  Widget _getWrappedRectTile() {
    return wrapRetract(
        getTile()
    );
  }

  Widget wrapRetract(Widget tile) {
    return widget.controller.wrapIfRetract(tile);
  }

  Widget getTile() {
    // change decoration
    var status = widget.controller.placeableStatus;
    decoration = status==0
        ? widget.decoration
          : status == 1
          ? widget.controller.defaultSetting.acceptDecoration
          : widget.controller.defaultSetting.rejectDecoration;

    return BasicTileItem(
      leading: widget.leading,
      title: widget.title,
      titleRight: widget.titleRight,
      titleWidth: widget.titleWidth,
      titleLeft: widget.titleLeft,
      trailing: widget.trailing,
      tileHeight: widget.tileHeight,
      decoration: decoration,
      tileMargin: widget.tileMargin,
      tilePadding: widget.tilePadding,
      tileClipBehavior: widget.tileClipBehavior,
    );
  }
}