import 'package:foldable_list_x2/foldable_list/data/mixins/ibind.dart';
import 'package:foldable_list_x2/foldable_list/data/mixins/idraggable.dart';
import 'package:foldable_list_x2/foldable_list/data/mixins/iretractable.dart';

import '../interfaces/build_widget.dart';
import '../api/basic_controller.dart';
import '../interfaces/controller_dependencies_operator.dart';

/// For TileItemController, FoldableListController
abstract interface class BasicTileController
    implements ControllerDependenciesOperator,
        BasicController,
        BuildWidget,
        IBind,
        IDraggable,
        IRetractable
{

}