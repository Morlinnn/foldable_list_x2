import 'package:flutter/material.dart';
import '../data/api/tile_list_controller.dart';

class TileListView extends StatefulWidget {
  final TileListController controller;

  TileListView({
    Key? key,
    required this.controller
  })
    : super(key: UniqueKey());

  @override
  State<TileListView> createState() => _TileListViewState();
}

class _TileListViewState extends State<TileListView> {
  @override
  void initState() {
    super.initState();
    widget.controller.setState = () {setState(() {});};
  }

  @override
  Widget build(BuildContext context) {
    return getWrappedFocusScopeWidget();
  }

  Widget getWrappedFocusScopeWidget() {
    return getListView();
  }

  Widget getListView() {
    var children = widget.controller.addChildrenDivider(widget.controller.children);

    return ListView.builder(
      itemBuilder: (context, index) {
        return children[index];
      },
      itemCount: children.length,
    );
  }
}