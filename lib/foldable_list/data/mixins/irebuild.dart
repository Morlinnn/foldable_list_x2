import 'dart:ui';

abstract interface class IRebuild {
  set setState(VoidCallback setState);
  void notifyRebuild();
}