mixin ExpandableMixin {
  late bool isExpanded;

  void changeExpanded() {
    isExpanded = !isExpanded;
  }
}