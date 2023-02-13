import 'package:get/get.dart';
import 'package:kuesewa/app/modules/search/controller/searchcontroller.dart';

class Searchbindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<searchcotroller>(
      () => searchcotroller(),
    );
  }
}
