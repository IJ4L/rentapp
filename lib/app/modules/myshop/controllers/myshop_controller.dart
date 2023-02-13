import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Myshop_controller extends GetxController {
  TextEditingController namaproduk = TextEditingController();
  TextEditingController harga = TextEditingController();
  TextEditingController stok = TextEditingController();
  TextEditingController minpesan = TextEditingController();
  TextEditingController deskripsi = TextEditingController();
  TextEditingController berat = TextEditingController();

  FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late ImagePicker imagePicker;
  XFile? pickedImage = null;
  late String photoUrl;

  var dropdownvalu = 'barang'.obs;
  var kota = false.obs;

  @override
  void onInit() {
    namaproduk = TextEditingController();
    harga = TextEditingController();
    stok = TextEditingController(text: '1');
    minpesan = TextEditingController(text: '1');
    deskripsi = TextEditingController();
    berat = TextEditingController();
    imagePicker = ImagePicker();
    super.onInit();
  }

  Future<String?> uploadImage() async {
    Reference storageRef = _storage.ref("${pickedImage!.name}.png");
    File file = File(pickedImage!.path);

    try {
      await storageRef.putFile(file);
      photoUrl = await storageRef.getDownloadURL();
      return photoUrl;
    } catch (err) {
      print(err);
      return null;
    }
  }

  void resetImage() {
    pickedImage = null;
    update();
  }

  void selectImage() async {
    try {
      final checkDataImage =
          await imagePicker.pickImage(source: ImageSource.gallery);

      if (checkDataImage != null) {
        print(checkDataImage.name);
        print(checkDataImage.path);
        pickedImage = checkDataImage;
      }
      update();
    } catch (err) {
      print(err);
      pickedImage = null;
      update();
    }
  }

  addProduk(String email, String username, String url, String kota) async {
    await uploadImage();
    await _firestore.collection('produk').add(
      {
        'Img': photoUrl,
        'NamaProduk': namaproduk.text,
        'Harga': harga.text,
        'Stok': stok.text,
        'jenis': dropdownvalu.value.toString(),
        'Minpesanan': minpesan.text,
        'Deskripsi': deskripsi.text,
        'Berat': berat.text,
        'UsernameBy': username,
        'UploadBy': email,
        'PhotoUrl': url,
        'kota': kota,
        'UploadAt': DateTime.now().toIso8601String(),
      },
    );
    Get.back();
    resetImage();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamProduk(String email) {
    Query<Map<String, dynamic>> post =
        _firestore.collection("produk").where("UploadBy", isEqualTo: email);

    return post.snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamAllProduk(String email) {
    Query<Map<String, dynamic>> post =
        _firestore.collection("produk").where("UploadBy", isNotEqualTo: email);

    return post.snapshots();
  }

  konfirmasiPesanan(
      String email, String id, String penyewa, String status) async {
    await _firestore
        .collection('users')
        .doc(email)
        .collection('transaksi')
        .doc(id)
        .update(
      {
        'status': status,
      },
    );

    await _firestore
        .collection('users')
        .doc(penyewa)
        .collection('transaksi')
        .doc(id)
        .update(
      {
        'status': status,
      },
    );
  }

  stokUpdate(String id, int brg) async {
    var stok;

    var document = await _firestore.collection('produk').doc(id);
    await document.get().then((value) {
      stok = value['Stok'];
    });

    print(stok);

    _firestore.collection('produk').doc(id).update(
      {
        "Stok": stok + brg,
      },
    );
  }

  updateHarga(String id) async {
    await _firestore.collection('produk').doc(id).update(
      {
        'Harga': harga.text,
      },
    );
  }

  updateStok(String id) async {
    await _firestore.collection('produk').doc(id).update(
      {
        'Stok': stok.text,
      },
    );
  }

  hapusProduk(String id) async {
    await _firestore.collection('produk').doc(id).delete();
  }

  @override
  void onClose() {
    namaproduk.dispose();
    harga.dispose();
    stok.dispose();
    minpesan.dispose();
    deskripsi.dispose();
    berat.dispose();
    super.onClose();
  }
}
