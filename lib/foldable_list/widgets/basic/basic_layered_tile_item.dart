import 'package:flutter/material.dart';

import 'basic_tile_item.dart';

class BasicLayeredTileItem extends BasicTileItem {
  final List<Widget>? frontWidgets;
  final List<Widget>? backgroundWidgets;

  BasicLayeredTileItem({
    super.key,
    super.leading,
    required super.title,
    this.frontWidgets,
    this.backgroundWidgets,
    super.titleLeft,
    super.titleWidth,
    super.titleRight,
    super.trailing,
    super.tileHeight,
    super.decoration,
    super.tileMargin,
    super.tilePadding,
    super.tileClipBehavior,
  });

  @override
  Widget build(BuildContext context) {
    return getDisplayWidget();
  }

  @override
  Widget getDisplayWidget() {
    var children = <Widget>[];
    if (backgroundWidgets != null) children.addAll(backgroundWidgets!);
    children.add(super.getDisplayWidget());
    if (frontWidgets != null) children.addAll(frontWidgets!);
    return SizedBox(
      height: tileHeight,
      child: Stack(
        children: children,
      ),
    );
  }
}