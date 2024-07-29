import 'package:flutter/material.dart';

import '../widgets/tile_list_view.dart';
import '../data/api/tile_list_controller.dart';
import '../enums/resolve_intercept_source.dart';
import '../widgets/foldable_list.dart';
import '../widgets/tile_item.dart';

typedef EntryKeyBuildFunction = FoldableList Function(dynamic key, TileListController parentController);
typedef ValueBuildFunction = Widget Function(dynamic value, TileListController parentController);
typedef InterceptedBuildFunction = Widget Function(RevolveInterceptSource status, dynamic intercepted, TileListController parentController);
typedef ResolveMapWill = bool Function(Map data);
typedef ResolveIterableWill = bool Function(Iterable data);
typedef ResolveEntryValueWill = bool Function(MapEntry entry);
/// <pre>
/// Support structure like this:
/// data:
/// -----------Nested Map-------------
///  |--K: k1--V: v1(Map)
///  |              |--K: ka1--V: va1
///  |              |--K: ka2--V: va2
/// --------Nested Iterable-----------
///  |--K: k2--V: v2(Iterable)
/// ----------Normal Value------------
///  |--K: k2--V: v3(any not nest)
///
/// If expand a Map, build function will be (key, value, parentController),
/// if expand a Iterable, build function will be (null, value, parentController).
///
/// You don't have to call parentController.addLazily(yourWidget), it's will automatically use you BuildReturn to add.
/// </pre>
class TileListViewBuilder {

  /// data: Sub type of Map or Iterable. Otherwise, it will call valueBuildFunc use data
  static TileListView loadFromMapOrIterable(
      TileListController tileListViewController,
      // data and function
      dynamic data,
      ResolveEntryValueWill resolveEntryValueWill,
      ResolveMapWill resolveMapWill,
      ResolveIterableWill resolveIterableWill,
      EntryKeyBuildFunction entryKeyBuildFunc,
      ValueBuildFunction valueBuildFunc,
      InterceptedBuildFunction interceptedBuildFunc,
  ) {
    var widget = _classifyValueMethod(
        data,
        resolveEntryValueWill,
        resolveMapWill,
        resolveIterableWill,
        entryKeyBuildFunc,
        valueBuildFunc,
        interceptedBuildFunc,
      tileListViewController,
    );

    if (widget != null) tileListViewController.addLazily(widget);

    return TileListView(
        controller: tileListViewController
    );
  }

  static Widget? _classifyValueMethod(
      dynamic data,
      ResolveEntryValueWill resolveEntryValueWill,
      ResolveMapWill resolveMapWill,
      ResolveIterableWill resolveIterableWill,
      EntryKeyBuildFunction entryKeyBuildFunc,
      ValueBuildFunction valueBuildFunc,
      InterceptedBuildFunction interceptedBuildFunc,
      TileListController parentController
      ) {
    Widget? widget;
    if (data is Map) {
      widget = _buildMap(
          data,
          resolveEntryValueWill,
          resolveMapWill,
          resolveIterableWill,
          entryKeyBuildFunc,
          valueBuildFunc,
          interceptedBuildFunc,
          parentController
      );
    } else if (data is Iterable) {
      widget = _buildIterable(
          data,
          resolveEntryValueWill,
          resolveMapWill,
          resolveIterableWill,
          entryKeyBuildFunc,
          valueBuildFunc,
          interceptedBuildFunc,
          parentController
      );
    } else {
      widget = valueBuildFunc(data, parentController);
    }

    assert(widget is TileItem || widget is FoldableList || widget == null);
    return widget;
  }

  static Widget? _buildMap(
      Map data,
      ResolveEntryValueWill resolveEntryValueWill,
      ResolveMapWill expandMap,
      ResolveIterableWill expandIterable,
      EntryKeyBuildFunction entryKeyBuildFunc,
      ValueBuildFunction valueBuildFunc,
      InterceptedBuildFunction interceptedBuildFunc,
      TileListController parentController
      ) {
    var expandWill = expandMap(data);
    if (expandWill) {
      for (var entry in data.entries) {
        _buildEntryAndAddToParent(
            entry,
            resolveEntryValueWill,
            expandMap,
            expandIterable,
            entryKeyBuildFunc,
            valueBuildFunc,
            interceptedBuildFunc,
            parentController
        );
      }
      return null;
    } else {
      return interceptedBuildFunc(RevolveInterceptSource.fromMap, data, parentController);
    }
  }

  static void _buildEntryAndAddToParent(
      MapEntry entry,
      ResolveEntryValueWill resolveEntryValueWill,
      ResolveMapWill expandMap,
      ResolveIterableWill expandIterable,
      EntryKeyBuildFunction entryKeyBuildFunc,
      ValueBuildFunction valueBuildFunc,
      InterceptedBuildFunction interceptedBuildFunc,
      TileListController parentController
      ) {
    var head = entryKeyBuildFunc(entry.key, parentController);
    var headController = head.controller;

    Widget? valueWidget;
    if (resolveEntryValueWill(entry)) {
      valueWidget = _classifyValueMethod(
          entry.value,
          resolveEntryValueWill,
          expandMap,
          expandIterable,
          entryKeyBuildFunc,
          valueBuildFunc,
          interceptedBuildFunc,
          headController
      );
    } else {
      valueWidget = interceptedBuildFunc(RevolveInterceptSource.fromEntry, entry, headController);
    }

    if (valueWidget != null) headController.addLazily(valueWidget);

    parentController.addLazily(head);
  }

  static Widget? _buildIterable(
      Iterable data,
      ResolveEntryValueWill resolveEntryValueWill,
      ResolveMapWill expandMap,
      ResolveIterableWill expandIterable,
      EntryKeyBuildFunction entryKeyBuildFunc,
      ValueBuildFunction valueBuildFunc,
      InterceptedBuildFunction interceptedBuildFunc,
      TileListController parentController
      ) {
    var expandWill = expandIterable(data);
    if (expandWill) {
      for (var value in data) {
        Widget? valueWidget = _classifyValueMethod(
            value,
            resolveEntryValueWill,
            expandMap,
            expandIterable,
            entryKeyBuildFunc,
            valueBuildFunc,
            interceptedBuildFunc,
            parentController
        );

        if (valueWidget != null) parentController.addLazily(valueWidget);
      }
      return null;
    } else {
      return interceptedBuildFunc(RevolveInterceptSource.fromIterable, data, parentController);
    }
  }

  // TODO complete
  static TileListView loadManually(
      TileListController tileListViewController,
      // data and function
      dynamic data,
      dynamic manuallyBuildFunc,
  ) {
    manuallyBuildFunc(data, tileListViewController);

    return TileListView(
        controller: tileListViewController
    );
  }
}