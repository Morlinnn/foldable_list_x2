import 'package:flutter/material.dart';
import '../../global_setting.dart';

// Basic widget of this package
class BasicTileItem extends StatelessWidget {
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

  BasicTileItem({
    super.key,
    this.leading,
    required this.title,
    this.titleLeft,
    this.titleWidth,
    this.titleRight,
    this.trailing,
    double? tileHeight,
    this.decoration,
    this.tileMargin,
    this.tilePadding,
    this.tileClipBehavior = Clip.none
  }) :
    assert(!(titleLeft != null && titleWidth != null && titleRight != null), "cannot set all of these options"),
    tileHeight = tileHeight?? GlobalSetting.tileHeight;

  @override
  Widget build(BuildContext context) {
    return getDisplayWidget();
  }

  Widget getDisplayWidget() {
    return Container(
      padding: tilePadding,
      margin: tileMargin,
      height: tileHeight,
      clipBehavior: tileClipBehavior,
      decoration: decoration,
      child: getRow(),
    );
  }

  Widget getRow() {
    return Row(
      children: getRowChildren(),
    );
  }

  List<Widget> getRowChildren() {
    var children = <Widget>[];

    var leadingRes = getLeading();
    if (leadingRes != null) children.add(leadingRes);

    children.add(
      getTitle()
    );

    var trailingRes = getTrailing();
    if (trailingRes != null) children.add(trailingRes);

    return children;
  }

  Widget? getLeading() {
    return leading;
  }

  Widget getTitle() {
    return Expanded(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double width = constraints.minWidth;
            double height = constraints.minHeight;
            EdgeInsets? padding;

            if (titleLeft != null || titleWidth != null || titleRight !=null) {
              double left = titleLeft?? (
                  titleRight!=null
                      ? (titleWidth!=null? (width - titleWidth! - titleRight!) : width - titleRight!)
                      : (titleWidth!=null? (width - titleWidth!) : width)
              );
              double right = titleRight?? (
                  titleLeft!=null
                      ? (titleWidth!=null? (width - titleWidth! - titleLeft!) : width - titleLeft!)
                      : (titleWidth!=null? (width - titleWidth!) : width)
              );
              if (left < 0) left = 0;
              if (right < 0) right = 0;
              padding = EdgeInsets.fromLTRB(left, 0, right, height);
            }

            return Container(
                padding: padding,
                child: title
            );
          },
        )
    );
  }

  Widget? getTrailing() {
    return trailing;
  }
}

