import 'package:flutter/material.dart';
import 'package:foldable_list_x2/foldable_list/builder/tile_list_view_builder.dart';
import 'package:foldable_list_x2/foldable_list/data/api/foldable_list_controller.dart';
import 'package:foldable_list_x2/foldable_list/data/api/tile_item_controller.dart';
import 'package:foldable_list_x2/foldable_list/data/api/tile_list_controller.dart';
import 'package:foldable_list_x2/foldable_list/data/others/tree_default_setting.dart';
import 'package:foldable_list_x2/foldable_list/enums/resolve_intercept_source.dart';
import 'package:foldable_list_x2/foldable_list/widgets/foldable_list.dart';
import 'package:foldable_list_x2/foldable_list/widgets/tile_item.dart';
import 'package:foldable_list_x2/foldable_list/widgets/tile_list_view.dart';

class Example2 extends StatefulWidget {
  @override
  State<Example2> createState() => _Example2State();
}

class _Example2State extends State<Example2> {
  late TileListView rootTileWidget;
  late TileListController example2Controller;

  @override
  void initState() {
    super.initState();
    example2Controller = TileListController.newInstance(
        name: 'example2',
        defaultSetting: TreeDefaultSetting(
            enableDraggable: true,
            enableTransfer: true
        )
    );
    rootTileWidget = (example2() as TileListView);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
        ),
        body: rootTileWidget
    );
  }

  Widget example2() {
    List data = ["test", "wtf", "widget"];
    Map map = {
      "K1": "jo",
      "K2": ["l1", "l2", "l3"],
      "K3": {
        "Ka1": "sk",
        "Ka2": "cn",
        "Ka3": ["la1", "la2", "la3"],
        // special key, don't want to expand value
        "Ka4": ["la1", "la2", "la3"],
        "Ka5": {
          "Kb1": "fs",
          "Kb2": "cs"
        }
      }
    };
    data.add(map);

    return TileListViewBuilder.loadFromMapOrIterable(
        example2Controller,
        data,
        // don't want to expand
        (entry) => entry.key.toString() != "Ka4",
        (map) => true,
        (list) => true,
        (key, parentController) {
          var controller = FoldableListController.newInstance(parentController: parentController);
          var w = FoldableList.normal(
            controller: controller,
            title: Text(key.toString(),),
            leading: IconButton(
              onPressed: () {
                controller.notifyRebuild();
                print("${controller.hashCode} ${controller.children}");
              },
              icon: Icon(Icons.refresh),
            ),
            trailing: IconButton(
                onPressed: () {
                  print("w: ${controller.thisWidget.hashCode}, wc: ${controller.hashCode}, pc: ${controller.parentController.hashCode}, ${key.toString()}\n");
                },
                icon: Icon(Icons.read_more)
            ),
          );
          print('w: ${w.hashCode}, wc: ${controller.hashCode}, pc: ${parentController.hashCode}, ${key.toString()}\n');
          return w;
        },
        (value, parentController) {
          var controller = TileItemController.newInstance(parentController: parentController);
          var w = TileItem.normal(
            controller: controller,
            title: Text(value.toString()),
            trailing: IconButton(
                onPressed: () {
                  print("w: ${controller.thisWidget.hashCode}, wc: ${controller.hashCode}, pc: ${controller.parentController.hashCode}, ${value.toString()}\n");
                },
                icon: Icon(Icons.read_more)
            ),
          );
          print('w: ${w.hashCode}, wc: ${controller.hashCode}, pc: ${parentController.hashCode}, ${value.toString()}\n');
          return w;
        },
        (from, item, parentController) {
          assert(from == RevolveInterceptSource.fromEntry);
          // Ka4 entry
          var controller = TileItemController.newInstance(parentController: parentController);
          String text = (item as MapEntry).value.toString();

          var w = TileItem.normal(
              controller: controller,
              title: Text(text, style: TextStyle(color: Colors.orange),)
          );
          print('w: ${w.hashCode}, wc: ${controller.hashCode}, pc: ${parentController.hashCode}, $text\n');
          return w;
        }
    );
  }
}