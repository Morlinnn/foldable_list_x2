import 'package:flutter/material.dart';

abstract interface class IDivider {
  set enableDivider(bool enableDivider);
  bool get enableDivider;
  set divider(Divider divider);
  Divider get divider;
  bool isLastWidget(Widget widget);
  bool isRootLastWidget(Widget widget);
  bool isFirstWidget(Widget widget);
  bool isRootFirstWidget(Widget widget);
  List<Widget> addChildrenDivider(List<Widget> rawChildren);
}