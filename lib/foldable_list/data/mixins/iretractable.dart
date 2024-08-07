import 'package:flutter/material.dart';

import '../api/tile_list_controller.dart';

abstract interface class IRetractable {
  set enableRetract(bool enableRetract);
  bool get enableRetract;
  set autoSetRetract(bool autoSetRetract);
  bool get autoSetRetract;
  set depth(int depth);
  int get depth;
  set retraction(double retraction);
  double get retraction;
  void updateDepth(int parentDepth);
  updateRetractDeeply(TileListController controller);
  Widget wrapIfRetract(Widget widget);
}