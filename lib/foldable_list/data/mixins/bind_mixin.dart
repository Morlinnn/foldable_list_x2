import 'package:flutter/material.dart';
import '../api/tile_list_controller.dart';

mixin BindMixin {
  late Widget thisWidget;
  late TileListController parentController;

  void removeThisWidget() {
    parentController.remove(thisWidget);
  }
}