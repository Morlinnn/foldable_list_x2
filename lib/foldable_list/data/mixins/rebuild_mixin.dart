import 'package:flutter/material.dart';

import '../../global_setting.dart';

mixin RebuildMixin {
  VoidCallback? setState;

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