import 'package:flutter/material.dart';
import 'package:foldable_list_x2/foldable_list/data/mixins/idivider.dart';
import 'package:foldable_list_x2/foldable_list/data/mixins/irebuild.dart';
import 'package:foldable_list_x2/foldable_list/data/mixins/itile_list_data.dart';

import '../api/basic_controller.dart';
import '../interfaces/lazily_operate.dart';
import '../implements/tile_list_view_controller_implement.dart';
import '../../enums/transfer_direction.dart';
import '../interfaces/foldable_list_operate.dart';
import '../others/tree_default_setting.dart';

abstract interface class TileListController
    implements TileListDataOperate,
        LazilyOperate,
        BasicController,
        IRebuild,
        IDivider,
        ITileListData
{
  static TileListController newInstance({
    required String name,
    TreeDefaultSetting? defaultSetting,
    bool? placeable,
    TransferDirection? defaultDirection,
    bool? enableDivider,
    Divider? divider
  }) {
    return TileListViewControllerImplement(
      name: name,
      defaultSetting: defaultSetting,
      placeable: placeable,
      defaultDirection: defaultDirection,
      enableDivider: enableDivider,
      divider: divider
    );
  }

}