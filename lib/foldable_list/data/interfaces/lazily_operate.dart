import 'package:flutter/material.dart';

abstract interface class LazilyOperate {
  bool clearLazily();
  bool addLazily(Widget widget);
  bool insertTopLazily(Widget widget);
  bool insertUpperLazily(Widget upperWhich, Widget widget);
  bool insertUnderLazily(Widget underWhich, Widget widget);
  bool removeLazily(Widget widget);
  void sortLazily([int Function(Widget, Widget)? compare]);
  void sortDefaultLazily();
  // TODO move widget, moveAll
}