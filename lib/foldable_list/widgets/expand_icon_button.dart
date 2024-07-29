import 'package:flutter/material.dart';

import '../data/api/foldable_list_controller.dart';

class ExpandIconButton extends StatefulWidget {
  final FoldableListController controller;

  const ExpandIconButton({
    super.key,
    required this.controller
  });

  @override
  State<StatefulWidget> createState() {
    return _ExpandIconButtonState();
  }
}

class _ExpandIconButtonState extends State<ExpandIconButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          setState(() {
            widget.controller.changeExpanded();
          });
        },
        icon: widget.controller.isExpanded? const Icon(Icons.expand_more) : const Icon(Icons.expand_less)
    );
  }
}