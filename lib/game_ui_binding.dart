import 'package:get/get.dart';
import 'controllers/game_ui_controller.dart';

class GameUiBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GameUiController());
    }
}