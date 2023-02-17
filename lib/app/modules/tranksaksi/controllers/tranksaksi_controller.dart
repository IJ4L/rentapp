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

  batalkanPesanan(
      String email, String id, String penyewa, String idProduk, int brg) async {
    await _firestore
        .collection('users')
        .doc(email)
        .collection('transaksi')
        .doc(id)
        .update(
      {
        'status': 'Selesai',
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

    stokUpdate(idProduk, brg);
  }

  stokUpdate(String id, int brg) async {
    var stok;

    var document = await _firestore.collection('produk').doc(id);
    await document.get().then(
      (value) {
        stok = value['Stok'];
      },
    );

    print(stok);

    _firestore.collection('produk').doc(id).update(
      {
        "Stok": stok + brg,
      },
    );
  }

  @override
  void onClose() {
    super.onClose();
  }
}
