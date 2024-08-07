import 'package:flutter/material.dart';

abstract interface class ITileListData {
  set children(List<Widget> children);
  List<Widget> get children;
}