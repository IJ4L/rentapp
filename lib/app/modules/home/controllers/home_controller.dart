import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  onClick(int index) {
    currentIndex.value = index;
  }

  List category = [
    'Barang',
    'Jasa',
    'Tempat',
  ];

  Stream<QuerySnapshot<Map<String, dynamic>>> streamKeranjang(String email) {
    var keranjang = FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .collection('keranjang')
        .snapshots();

    return keranjang;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamJasa(String email) {
    Query<Map<String, dynamic>> post =
        _firestore.collection("produk").where("jenis", isEqualTo: 'Jasa');

    return post.snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamBarang(String email) {
    Query<Map<String, dynamic>> post =
        _firestore.collection("produk").where("jenis", isEqualTo: 'barang');

    return post.snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamTempat(String email) {
    Query<Map<String, dynamic>> post =
        _firestore.collection("produk").where("jenis", isEqualTo: 'tempat');

    return post.snapshots();
  }

  hapusKeranjang(String id, String email) {
    _firestore
        .collection('users')
        .doc(email)
        .collection('keranjang')
        .doc(id)
        .delete();
  }
}
