import 'package:flutter/material.dart';
import 'package:foldable_list_x2/foldable_list/data/mixins/irebuild.dart';

import '../../global_setting.dart';

mixin RebuildMixin implements IRebuild {
  VoidCallback? setState;

  @override
  void notifyRebuild() {
    if (setState == null) {
      if (!GlobalSetting.disableWarning) {
        debugPrint(
            "WARNING: _setState is null, make sure it will be inited before use");
      }
      return;
    }

    setState!();
  }
}