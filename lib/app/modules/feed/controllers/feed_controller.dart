import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kuesewa/app/data/usersModel.dart';
import 'package:kuesewa/app/modules/feed/views/exploreView.dart';

import '../views/updateView.dart';

class FeedController extends GetxController {
  late TextEditingController tentang;
  late ImagePicker imagePicker;

  XFile? pickedImage = null;
  var user = UserModel().obs;
  late String photoUrl;

  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final feedCategory = 0.obs;
  final tab = 0.obs;
  final produkCategory = 0.obs;

  @override
  void onInit() {
    tentang = TextEditingController();
    imagePicker = ImagePicker();
    super.onInit();
  }

  List<String> category = ['Update', 'Explore', 'Video'];

  List feedPage = [
    updateView(),
    exploreView(),
    exploreView(),
  ];

  List<String> produkCategorys = ['Terbaru', 'Terlaris', 'Rating'];

  klik(int index) {
    feedCategory.value = index;
  }

  ontap(int index) {
    tab.value = index;
  }

  onKlikProduk(int index) {
    produkCategory.value = index;
  }

  Future<String?> uploadImage() async {
    Reference storageRef = storage.ref("${pickedImage!.name}.png");
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

  post(String email, String username, String url) async {
    await uploadImage();
    await _firestore.collection('Posts').add(
      {
        'Img': photoUrl,
        'Tentang': tentang.text,
        'UsernameBy': username,
        'UploadBy': email,
        'PhotoUrl': url,
        'UploadAt': DateTime.now().toIso8601String(),
      },
    );
    Get.back();
    resetImage();
  }

  Stream<QuerySnapshot<Object?>> streamPost() {
    CollectionReference post = _firestore.collection("Posts");

    return post.snapshots();
  }

  @override
  void onClose() {
    tentang.dispose();
    super.onClose();
  }
}
