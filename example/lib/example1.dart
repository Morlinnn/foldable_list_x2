import 'dart:math';

import 'package:flutter/material.dart';
import 'package:foldable_list_x2/foldable_list/data/api/foldable_list_controller.dart';
import 'package:foldable_list_x2/foldable_list/data/api/tile_item_controller.dart';
import 'package:foldable_list_x2/foldable_list/data/api/tile_list_controller.dart';
import 'package:foldable_list_x2/foldable_list/widgets/foldable_list.dart';
import 'package:foldable_list_x2/foldable_list/widgets/tile_item.dart';
import 'package:foldable_list_x2/foldable_list/widgets/tile_list_view.dart';

class Example1 extends StatefulWidget {
  @override
  State<Example1> createState() => _Example1State();
}

class _Example1State extends State<Example1> {
  late TileListController example1Controller;
  late TileListView rootTileWidget;

  @override
  void initState() {
    super.initState();
    example1Controller = TileListController.newInstance(name: "example1");
    rootTileWidget = TileListView(controller: example1Controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
              onPressed: () {
                createFoldableListC1();
              },
              icon: const Icon(Icons.add)
            )
          ],
        ),
        body: rootTileWidget
    );
  }

  void createFoldableListC1() {
    var c1 = FoldableListController.newInstance(parentController: example1Controller);
    var f1 = FoldableList.normal(
      title: Text(Random().nextInt(25565).toString()),
      controller: c1,
      leading: IconButton(
        onPressed: () {
          c1.notifyRebuild();
        },
        icon: Icon(Icons.refresh),
      ),
      trailing: IconButton(
          onPressed: () {
            createFoldableListC2(c1);
          },
          icon: Icon(Icons.add)
      ),
    );
    this.example1Controller.add(f1);
  }

  void createFoldableListC2(FoldableListController c1) {
    var c2 = FoldableListController.newInstance(parentController: c1);
    var f2 = FoldableList.normal(
      title: Text(Random().nextInt(25565).toString()),
      controller: c2,
      trailing: IconButton(
          onPressed: () {
            createFoldableListC3(c2);
          },
          icon: Icon(Icons.add)
      ),
    );
    c1.add(f2);
  }

  void createFoldableListC3(FoldableListController c2) {
    var c3 = FoldableListController.newInstance(parentController: c2);
    var f3 = FoldableList.normal(
      title: Text(Random().nextInt(25565).toString()),
      controller: c3,
      trailing: IconButton(
          onPressed: () {
            createTileItem(c3);
          },
          icon: Icon(Icons.add)
      ),
    );
    c2.add(f3);
  }

  void createTileItem(FoldableListController c3) {
    var c4 = TileItemController.newInstance(parentController: c3);
    var item = TileItem.normal(
      controller: c4,
      title: Text(Random().nextInt(25565).toString()),
    );
    c3.add(item);
  }
}