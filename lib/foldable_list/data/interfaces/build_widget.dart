import 'package:flutter/material.dart';

abstract interface class BuildWidget {
  Widget buildWidget(Widget Function() getWidgetFunc);
}