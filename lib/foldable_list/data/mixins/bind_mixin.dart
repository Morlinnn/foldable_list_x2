import 'package:flutter/material.dart';
import 'package:foldable_list_x2/foldable_list/data/mixins/ibind.dart';
import '../api/tile_list_controller.dart';

mixin BindMixin implements IBind {
  @override
  late Widget thisWidget;
  @override
  late TileListController parentController;

  @override
  void removeThisWidget() {
    parentController.remove(thisWidget);
  }
}