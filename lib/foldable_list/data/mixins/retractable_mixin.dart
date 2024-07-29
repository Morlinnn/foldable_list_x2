import 'package:flutter/material.dart';

import '../../data/api/foldable_list_controller.dart';
import '../../data/api/tile_list_controller.dart';
import '../../widgets/foldable_list.dart';
import '../../widgets/tile_item.dart';

mixin RetractableMixin {
  late bool enableRetract;
  late bool autoSetRetract;
  late int _depth;
  late double _retraction;

  set depth(int depth) {
    assert(depth >= 0);

    _depth = depth;
  }

  int get depth => _depth;

  set retraction(double retraction) {
    assert(retraction >= 0);

    _retraction = retraction;
  }

  double get retraction => _retraction;

  void updateDepth(int parentDepth) {
    depth = parentDepth + 1;
  }

  _notifyChildrenUpdateDepth(List<Widget> children, int parentDepth) {
    for (var c in children) {
      if (c is TileItem) {
        c.controller.updateDepth(parentDepth);
      } else if (c is FoldableList) {
        c.controller.updateDepth(parentDepth);
        _notifyChildrenUpdateDepth(c.controller.children, c.controller.depth);
      }
    }
  }

  /// Auto update depth from parent controller
  updateRetractDeeply(TileListController controller) {    // disable retract
    if (!enableRetract) return;

    // Root's depth always equals -1.
    var controllerDepth = controller is FoldableListController? controller.depth : -1;

    // unnecessary update
    if (controllerDepth + 1 == depth) return;

    if (autoSetRetract) {
      updateDepth(controllerDepth);
    }

    if (this is TileListController) {
      _notifyChildrenUpdateDepth(
          (this as TileListController).children,
          depth
      );
    }
  }

  Widget wrapIfRetract(Widget widget) {
    return enableRetract ?
      Container(
          margin: EdgeInsets.only(left: retraction * depth),
          child: widget
      )
      : widget;
  }
}