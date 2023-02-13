import 'package:get/get.dart';

import '../controllers/halaman_utama_controller.dart';

class HalamanUtamaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HalamanUtamaController>(() => HalamanUtamaController());
  }
}
