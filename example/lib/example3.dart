import 'package:flutter/material.dart';
import 'package:foldable_list_x2/foldable_list/builder/tile_list_view_builder.dart';
import 'package:foldable_list_x2/foldable_list/data/api/foldable_list_controller.dart';
import 'package:foldable_list_x2/foldable_list/data/api/tile_item_controller.dart';
import 'package:foldable_list_x2/foldable_list/data/api/tile_list_controller.dart';
import 'package:foldable_list_x2/foldable_list/data/others/tree_default_setting.dart';
import 'package:foldable_list_x2/foldable_list/widgets/foldable_list.dart';
import 'package:foldable_list_x2/foldable_list/widgets/tile_item.dart';
import 'package:foldable_list_x2/foldable_list/widgets/tile_list_view.dart';

class Example3 extends StatefulWidget {
  @override
  State<Example3> createState() => _Example3State();
}

class _Example3State extends State<Example3> {
  late TileListView rootTileWidget;
  late TileListController example3Controller;

  @override
  void initState() {
    super.initState();
    example3Controller = TileListController.newInstance(
        name: 'example2',
        defaultSetting: TreeDefaultSetting(
            enableDraggable: true,
            enableTransfer: true
        )
    );
    rootTileWidget = (example3() as TileListView);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: rootTileWidget,
    );
  }


  Widget example3() {
    List<CustomStructure> children1 = [];

    children1.add(
      CustomStructure(
          title: "c1 under head",
          intData: [99, 80]
      )
    );

    children1.add(
        CustomStructure(
            title: "c2 under head",
            intData: [7]
        )
    );

    children1.add(
        CustomStructure(
            title: "c3 under head",
            intData: [13, 100]
        )
    );

    List<CustomStructure> children2 = [];

    children2.add(
      CustomStructure(
          title: "c333",
          intData: []
      )
    );

    children1.add(
      CustomStructureList(
          title: "list under head",
          intData: [1, 132],
          children: children2
      )
    );

    var data = CustomStructureList(
        title: "list head",
        intData: [12, 55, 0],
        children: children1
    );

    /// data structure
    /// list head-|- c1 under head
    ///           |- c2 under head
    ///           |- c3 under head(intercept code: 100)
    ///           |- list under head -|- c333(intercept code: -1)

    return TileListViewBuilder.loadManually(
        example3Controller,
        data,
        (data) {
          if (data is CustomStructure) {
            if (data.intData.isEmpty) {
              return CodeInterceptReturn(code: -1, intercept: true);
            } else if (data.intData.contains('100')) {
              return CodeInterceptReturn(code: 100, intercept: true);
            }
          }
          return CodeInterceptReturn(code: 0, intercept: false);
        },
        (data, parentController) {
          if (data is CustomStructureList) {
            var controller = FoldableListController.newInstance(
                parentController: parentController);
            var w = FoldableList.normal(
              controller: controller,
              title: Text("${data.title}: ${data.intData}"),
              leading: IconButton(
                onPressed: () {
                  controller.notifyRebuild();
                  print("${controller.hashCode} ${controller.children}");
                },
                icon: Icon(Icons.refresh),
              ),
              trailing: IconButton(
                  onPressed: () {
                    print(
                        "w: ${controller.thisWidget.hashCode}, wc: ${controller.hashCode}, pc: ${controller.parentController.hashCode}\n");
                  },
                  icon: Icon(Icons.read_more)),
            );
            print('w: ${w.hashCode}, wc: ${controller.hashCode}, pc: ${parentController.hashCode}\n');

            return ManuallyBuildReturn(
              widget: w,
              nextData: data.children,
              widgetController: controller
            );
          } else {
            var controller = TileItemController.newInstance(parentController: parentController);
            var w = TileItem.normal(
              controller: controller,
              title: Text("${(data as CustomStructure).title}: ${data.intData}"),
              trailing: IconButton(
                  onPressed: () {
                    print("w: ${controller.thisWidget.hashCode}, wc: ${controller.hashCode}, pc: ${controller.parentController.hashCode}\n");
                  },
                  icon: Icon(Icons.read_more)
              ),
            );
            print('w: ${w.hashCode}, wc: ${controller.hashCode}, pc: ${parentController.hashCode}\n');

            return ManuallyBuildReturn(
              widget: w,
            );
          }
        },
        (code, data, parentController) {
          if (code != -1 && code != 100) throw Exception("Not intercept this data: $data, code:$code");

          var controller = TileItemController.newInstance(parentController: parentController);
          Widget? widget;
          if (code == -1) {
            assert(data is CustomStructure && data.title == "c333");

            widget = TileItem.normal(
              controller: controller,
              title: Text("${(data as CustomStructure).title} is Empty", style: const TextStyle(color: Colors.red),),
              trailing: IconButton(
                  onPressed: () {
                    print("w: ${controller.thisWidget.hashCode}, wc: ${controller.hashCode}, pc: ${controller.parentController.hashCode}\n");
                  },
                  icon: Icon(Icons.read_more)
              ),
            );
          } else if (code == 100) {
            assert(data is CustomStructure && data.title == "c3 under head");

            widget = TileItem.normal(
              controller: controller,
              title: Text("${(data as CustomStructure).title}: ${data.intData}, eeeeeeeeee", style: const TextStyle(color: Colors.blue),),
              trailing: IconButton(
                  onPressed: () {
                    print("w: ${controller.thisWidget.hashCode}, wc: ${controller.hashCode}, pc: ${controller.parentController.hashCode}\n");
                  },
                  icon: Icon(Icons.read_more)
              ),
            );
          }

          return ManuallyBuildReturn(
            widget: widget!
          );
        }
    );
  }
}

class CustomStructure {
  String title;
  List<int> intData;

  CustomStructure({
    required this.title,
    required this.intData
  });
}

class CustomStructureList extends CustomStructure {
  List<CustomStructure> children;

  CustomStructureList({
    required super.title,
    required super.intData,
    required this.children
  });

}