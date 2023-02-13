// ignore_for_file: unnecessary_null_comparison
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DetailProdukController extends GetxController {
  late TextEditingController label = TextEditingController();
  late TextEditingController alamatLengkap = TextEditingController();
  late TextEditingController pesan = TextEditingController();
  late TextEditingController namaPenerima = TextEditingController();
  late TextEditingController nomerTelepon = TextEditingController();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var currenIndex = 0.obs;
  var count = 1.obs;
  var hargaTotal = 0.obs;
  var lamaSewa = 1.obs;
  var pembayaran = '-'.obs;

  var labelPenerima = ''.obs;
  var penerima = ''.obs;
  var nomer = ''.obs;
  var alamat = ''.obs;

  var error = false.obs;

  @override
  void onInit() {
    label = TextEditingController();
    alamatLengkap = TextEditingController();
    pesan = TextEditingController();
    namaPenerima = TextEditingController();
    nomerTelepon = TextEditingController();
    super.onInit();
  }

  addAlamat(String email) async {
    await _firestore.collection('users').doc(email).collection('alamat').add(
      {
        'label': label.text,
        'alamatLengkap': alamatLengkap.text,
        'pesan': pesan.text != null ? pesan.text : '',
        'namaPenerima': namaPenerima.text,
        'nomerTelepon': nomerTelepon.text,
        'utama': false,
      },
    );

    Get.back();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamAlamat(String email) {
    var allAlamat = _firestore
        .collection('users')
        .doc(email)
        .collection('alamat')
        .snapshots();

    return allAlamat;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamPembayarm(String email) {
    var allAlamat = _firestore
        .collection('users')
        .doc(email)
        .collection('alamat')
        .where('utama', isEqualTo: true)
        .snapshots();

    return allAlamat;
  }

  klikUtama(
    String email,
    String label,
    String alamatLengkap,
    String namaPenerima,
    String nomerTelepon,
    int index,
  ) async {
    await _firestore
        .collection('users')
        .doc(email)
        .collection('alamat')
        .doc('utama')
        .update(
      {
        'label': label,
        'alamatLengkap': alamatLengkap,
        'namaPenerima': namaPenerima,
        'nomerTelepon': nomerTelepon,
        'index': index,
      },
    );
  }

  kirim(String email, String renter, String barang, String hargaBarang,
      String img, String id, int stok) async {
    var random = Random();
    var n1 = random.nextInt(1000000000);
    var tanggal, bulan;

    if (DateTime.now().month % 2 == 0) {
      if ((lamaSewa.value + DateTime.now().day) > 30) {
        tanggal = (lamaSewa.value + DateTime.now().day + 1) - 30;
        bulan = DateTime.now().month + 1;
      } else
        tanggal = lamaSewa.value + DateTime.now().day + 1;
      bulan = DateTime.now().month;
    } else {
      if (lamaSewa.value + DateTime.now().day > 31) {
        tanggal = (lamaSewa.value + DateTime.now().day + 1) - 31;
        bulan = DateTime.now().month + 1;
      } else
        tanggal = lamaSewa.value + DateTime.now().day + 1;
      bulan = DateTime.now().month;
    }

    if (labelPenerima.value != 'k' && pembayaran.value != '-') {
      _firestore
          .collection('users')
          .doc(email)
          .collection('transaksi')
          .doc(n1.toString())
          .set(
        {
          'produkId': id,
          'renter': renter,
          'penyewa': email,
          'label': labelPenerima.value.toString(),
          'namaPenerima': penerima.value.toString(),
          'nomerPenyewa': nomer.value.toString(),
          'alamatPenyewa': alamat.value.toString(),
          'barang': barang,
          'harga': hargaBarang,
          'lamaSewa': lamaSewa.value.toString(),
          'jumlahBarang': count.value.toString(),
          'pembayaran': pembayaran.value.toString(),
          'totalHarga': hargaTotal.value.toString(),
          'status': 'confirm',
          'orderAt': DateTime.now().toString(),
          'produkImg': img,
          'pickAt': tanggal.toString() +
              ' - ' +
              bulan.toString() +
              ' - ' +
              DateTime.now().year.toString(),
        },
      );

      _firestore
          .collection('users')
          .doc(renter)
          .collection('transaksi')
          .doc(n1.toString())
          .set(
        {
          'produkId': id,
          'renter': renter,
          'penyewa': email,
          'label': labelPenerima.value.toString(),
          'namaPenerima': penerima.value.toString(),
          'nomerPenyewa': nomer.value.toString(),
          'alamatPenyewa': alamat.value.toString(),
          'barang': barang,
          'harga': hargaBarang,
          'lamaSewa': lamaSewa.value.toString(),
          'jumlahBarang': count.value.toString(),
          'pembayaran': pembayaran.value.toString(),
          'totalHarga': hargaTotal.value.toString(),
          'status': 'confirm',
          'orderAt': DateTime.now().toString(),
          'produkImg': img,
          'pickAt': tanggal.toString() +
              ' - ' +
              bulan.toString() +
              ' - ' +
              DateTime.now().year.toString(),
        },
      );

      _firestore.collection('produk').doc(id).update(
        {
          "Stok": stok - count.value,
        },
      );

      error.value = false;
      subtotal(int.parse(hargaBarang));
      Get.back();
      Get.back();
    } else {
      error.value = true;
    }
  }

  keranjang(String email, String photoUrl, String namaproduk, String harga,
      String renter) {
    _firestore.collection('users').doc(email).collection('keranjang').add(
      {
        'Img': photoUrl,
        'NamaProduk': namaproduk,
        'Harga': harga,
        'UploadBy': renter,
      },
    );
  }

  deletKeranjang(String id, String email) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .collection('keranjang')
        .doc(id)
        .delete();
  }

  onkilk(int index) {
    currenIndex.value = index;
  }

  increament(int harga, int stok) {
    if (count.value < stok) count.value++;
    subtotal(harga);
  }

  decrement(int harga) {
    if (count.value != 1) count.value--;
    subtotal(harga);
  }

  increament2(int harga) {
    lamaSewa.value++;
    subtotal(harga);
  }

  decrement2(int harga) {
    if (lamaSewa.value != 1) lamaSewa.value--;
    subtotal(harga);
  }

  subtotal(int harga) {
    hargaTotal.value = (count.value * harga) * lamaSewa.value;
  }

  bayar() {
    pembayaran.value = 'Cash on Delivery';
    Get.back();
  }

  @override
  void onClose() {
    label.dispose();
    alamatLengkap.dispose();
    pesan.dispose();
    namaPenerima.dispose();
    nomerTelepon.dispose();
    super.onClose();
  }
}
