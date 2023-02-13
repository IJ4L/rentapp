import 'package:get/get.dart';

import '../controllers/myshop_controller.dart';

class Myshopbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Myshop_controller>(
      () => Myshop_controller(),
    );
  }
}
