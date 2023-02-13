import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class TranksaksiController extends GetxController {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var date = (DateTime.now().year.toString() +
          DateTime.now().month.toString() +
          DateTime.now().day.toString())
      .obs;

  @override
  void onInit() {
    super.onInit();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamTranksaksiBuyer(
      String email) {
    Stream<QuerySnapshot<Map<String, dynamic>>> dataTransaksi = _firestore
        .collection('users')
        .doc(email)
        .collection('transaksi')
        .where('renter', isNotEqualTo: email)
        .snapshots();

    return dataTransaksi;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamTranksaksi(String email) {
    Stream<QuerySnapshot<Map<String, dynamic>>> dataTransaksi = _firestore
        .collection('users')
        .doc(email)
        .collection('transaksi')
        .where('renter', isEqualTo: email)
        .snapshots();

    return dataTransaksi;
  }

  konfirmasiDiterima(String email, String id, String penyewa) async {
    await _firestore
        .collection('users')
        .doc(email)
        .collection('transaksi')
        .doc(id)
        .update(
      {
        'status': 'Diterima',
      },
    );

    await _firestore
        .collection('users')
        .doc(penyewa)
        .collection('transaksi')
        .doc(id)
        .update(
      {
        'status': 'Diterima',
      },
    );
  }

  batalkanPesanan(String email, String id, String penyewa) async {
    await _firestore
        .collection('users')
        .doc(email)
        .collection('transaksi')
        .doc(id)
        .update(
      {
        'status': 'Batal',
      },
    );

    await _firestore
        .collection('users')
        .doc(penyewa)
        .collection('transaksi')
        .doc(id)
        .update(
      {
        'status': 'Batal',
      },
    );
  }

  @override
  void onClose() {
    super.onClose();
  }
}
