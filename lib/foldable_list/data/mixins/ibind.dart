import 'package:flutter/material.dart';

import '../api/tile_list_controller.dart';

abstract interface class IBind {
  set thisWidget(Widget widget);
  Widget get thisWidget;
  set parentController(TileListController parentController);
  TileListController get parentController;
  void removeThisWidget();
}