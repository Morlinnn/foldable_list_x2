import 'package:flutter/material.dart';

abstract interface class TileListDataOperate {
  bool clear();
  bool add(Widget widget);
  bool insertTop(Widget widget);
  bool insertUpper(Widget upperWhich, Widget widget);
  bool insertUnder(Widget underWhich, Widget widget);
  bool remove(Widget widget);
  sort([int Function(Widget, Widget)? compare]);
  sortDefault();
  // TODO move...
}