import 'package:flutter/material.dart';
import 'package:foldable_list_x2/foldable_list/data/mixins/idivider.dart';

mixin DividerMixin implements IDivider {
  @override
  late bool enableDivider;
  @override
  late Divider divider;

  @override
  bool isLastWidget(Widget widget);

  @override
  bool isRootLastWidget(Widget widget);

  @override
  bool isFirstWidget(Widget widget);

  @override
  bool isRootFirstWidget(Widget widget);

  @override
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