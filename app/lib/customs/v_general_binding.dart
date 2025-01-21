import 'package:get/get.dart';
import 'v_network_manager.dart';

class VGeneralBindings extends Bindings {

  @override
  void dependencies() {
    Get.put(VNetworkManager());
  }
}