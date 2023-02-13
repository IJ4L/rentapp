import 'package:get/get.dart';

import '../controllers/tranksaksi_controller.dart';

class TranksaksiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TranksaksiController>(
      () => TranksaksiController(),
    );
  }
}
