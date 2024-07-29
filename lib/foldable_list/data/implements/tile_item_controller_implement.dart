import '../../data/api/tile_item_controller.dart';
import '../../data/api/tile_list_controller.dart';
import '../../data/mixins/tree_data_mixin.dart';
import '../../enums/transfer_direction.dart';
import '../mixins/bind_mixin.dart';
import '../mixins/draggable_mixin.dart';
import '../mixins/rebuild_mixin.dart';
import '../mixins/retractable_mixin.dart';
import '../mixins/transfer_drag_target_mixin.dart';

class TileItemControllerImplement
    with RetractableMixin,
        BindMixin,
        DraggableMixin,
        RebuildMixin,
        TransferDragTargetMixin,
        TreeDataMixin
    implements TileItemController {
  TileItemControllerImplement({
    required TileListController parentController,
    bool? enableRetract,
    bool autoSetRetract = true,
    int depth = 0,
    double? retraction,
    bool? enableDraggable,
    List<String>? acceptableMigrateTileListViewNameList,
    bool? enableTransfer,
    TransferDirection? defaultDirection
  }) {
    this.parentController = parentController;
    transferStatus = 0;
    defaultSetting = parentController.defaultSetting;
    super.enableRetract = enableRetract?? parentController.defaultSetting.enableRetract;
    this.autoSetRetract = autoSetRetract;
    this.depth = depth;
    this.retraction = retraction?? parentController.defaultSetting.retraction;
    super.enableDraggable = enableDraggable?? parentController.defaultSetting.enableDraggable;
    this.acceptableMigrateTileListViewNameList = acceptableMigrateTileListViewNameList?? [];
    super.enableTransfer = enableTransfer?? parentController.defaultSetting.enableTransfer;
    defaultTransferDirection = defaultDirection?? parentController.defaultSetting.defaultTransferDirection;
    tileListViewName = parentController.tileListViewName;
  }

  @override
  set enableRetract(bool enableRetract) {
    super.enableRetract = enableRetract;

    notifyRebuild();
  }

  @override
  set enableTransfer(bool enableTransfer) {
    super.enableTransfer = enableTransfer;

    notifyRebuild();
  }

  @override
  set enableDraggable(bool draggable) {
    super.enableDraggable = draggable;

    notifyRebuild();
  }

  @override
  updateControllerDependencies(TileListController parentController) {
    this.parentController = parentController;

    tileListViewName = parentController.tileListViewName;
    updateRetractDeeply(parentController);
    updateTileListViewNameDeeply(parentController);
  }
}