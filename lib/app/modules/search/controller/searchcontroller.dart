
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class searchcotroller extends GetxController {


  var name = ''.obs;

  onCari(String value){
    name.value = value;
    update();
  }

}
