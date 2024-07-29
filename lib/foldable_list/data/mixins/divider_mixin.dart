import 'package:flutter/material.dart';

mixin DividerMixin {
  late bool enableDivider;
  late Divider divider;

  bool isLastWidget(Widget widget);

  bool isRootLastWidget(Widget widget);

  bool isFirstWidget(Widget widget);

  bool isRootFirstWidget(Widget widget);

  List<Widget> addChildrenDivider(List<Widget> rawChildren) {
    if (!enableDivider) return rawChildren;

    addCD(List<Widget> list, List<Widget> rawList, int index) {
      if (!isRootFirstWidget(rawList[index])) list.add(divider);
      list.add(rawList[index]);
    }

    var list = <Widget>[];
    for (int i = 0; i < rawChildren.length; i ++) {
      addCD(list, rawChildren, i);
    }

    return list;
  }
}