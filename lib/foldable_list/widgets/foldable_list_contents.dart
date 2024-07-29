import 'package:flutter/material.dart';

class FoldableListContents extends StatelessWidget {
  final List<Widget> children;

  const FoldableListContents({
    super.key,
    required this.children
  });

  @override
  Widget build(BuildContext context) {
    return generateColumn();
  }

  Widget generateColumn() {
    return getColumn();
  }

  Widget getColumn() {
    return Column(
      children: children,
    );
  }
}