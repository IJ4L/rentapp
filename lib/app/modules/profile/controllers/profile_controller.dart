import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kuesewa/app/data/usersModel.dart';

import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController nomer = TextEditingController();
  TextEditingController kota = TextEditingController();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseStorage _storage = FirebaseStorage.instance;

  late ImagePicker imagePicker;
  XFile? pickedImage = null;
  late String photoUrl;

  late User? user = _firebaseAuth.currentUser;

  var userModel = UserModel().obs;

  getProfile() async {
    final data = await _firestore.collection('users').doc(user!.email).get();
    final dataProfile = data.data() as Map<String, dynamic>;

    print(dataProfile);

    await userModel(
      UserModel(
        uid: dataProfile["Uid"],
        username: dataProfile["Username"],
        email: dataProfile["Email"],
        photoUrl: dataProfile["PhotoUrl"],
        lastSignIn: dataProfile["lastSignIn"],
      ),
    );

    userModel.refresh();
  }

  logOut() async {
    _firebaseAuth.signOut();
    _googleSignIn.disconnect();
    _googleSignIn.signOut();
    Get.offAllNamed(Routes.AUTHENTICATION);
  }

  Future<String?> uploadImage(String email1) async {
    Reference storageRef = _storage.ref("${pickedImage!.name}.png");
    File file = File(pickedImage!.path);

    try {
      await storageRef.putFile(file);
      photoUrl = await storageRef.getDownloadURL();
      updatePhotoUrl(photoUrl, email1);
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

  void updatePhotoUrl(String url, String email1) async {
    CollectionReference users = _firestore.collection('users');

    await users.doc(email1).update(
      {
        "Username": email.text.isEmpty ? email1 : email.text,
        "Nomer": nomer.text.isEmpty ? '-' : nomer.text,
        "kota": kota.text.isEmpty ? '-' : kota.text,
        "PhotoUrl": url,
      },
    );

    // Update model
    userModel.update((user) {
      user!.photoUrl = url;
    });

    userModel.refresh();
  }

  @override
  void onInit() async {
    await getProfile();
    email = TextEditingController();
    nomer = TextEditingController();
    kota = TextEditingController();
    imagePicker = ImagePicker();
    super.onInit();
  }

  @override
  void onClose() {
    email.dispose();
    nomer.dispose();
    kota.dispose();
    super.onClose();
  }
}
