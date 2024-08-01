import '../api/tile_list_controller.dart';

abstract interface class ControllerDependenciesOperator {
  /// When widget add to parent(controller)
  updateControllerDependencies(TileListController parentController);
}