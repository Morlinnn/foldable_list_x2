import 'package:foldable_list_x2/foldable_list/data/mixins/iexpandable.dart';

mixin ExpandableMixin implements IExpandable {
  @override
  late bool isExpanded;

  @override
  void changeExpanded() {
    isExpanded = !isExpanded;
  }
}