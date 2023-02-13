import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kuesewa/app/modules/profile/controllers/profile_controller.dart';
import 'package:kuesewa/main.dart';

class editProfile extends GetView<ProfileController> {
  final controller = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          height: Get.width * 0.11,
                          width: Get.width * 0.11,
                          decoration: BoxDecoration(
                            color: Color(0xff0fc7b0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_back_ios_new_outlined,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Edit Profile',
                        style: GoogleFonts.plusJakartaSans(
                          color: Color(0xff0fc7b0),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => controller.uploadImage(
                          authC.userModel.value.email!,
                        ),
                        child: Container(
                          height: Get.width * 0.11,
                          width: Get.width * 0.11,
                          decoration: BoxDecoration(
                            color: Color(0xff0fc7b0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.update_outlined,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Stack(
                  children: [
                    Container(
                      height: Get.width * 0.45,
                      width: Get.width * 0.45,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Get.width * 0.45 / 2),
                      ),
                      child: GetBuilder<ProfileController>(
                        init: ProfileController(),
                        builder: (controller) => ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: controller.pickedImage != null
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      image: FileImage(
                                        File(controller.pickedImage!.path),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Image.network(
                                  authC.userModel.value.photoUrl!,
                                  fit: BoxFit.fill,
                                ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 14,
                      child: GestureDetector(
                        onTap: () => controller.selectImage(),
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.edit_outlined,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                _textfieldMaker('Nama toko', 1, controller.email),
                _textfieldMaker('Nomer', 1, controller.nomer),
                _textfieldMaker('Kota', 1, controller.kota),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _textfieldMaker(
      String nama, int maxLine, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10.0,
        ),
        Text(
          '$nama*',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        TextField(
          controller: controller,
          cursorColor: Color(0xff0fc7b0),
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            color: Color(0xff0fc7b0),
            fontWeight: FontWeight.w600,
          ),
          maxLines: maxLine,
          textAlign: TextAlign.justify,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xff0fc7b0),
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        )
      ],
    );
  }
}
