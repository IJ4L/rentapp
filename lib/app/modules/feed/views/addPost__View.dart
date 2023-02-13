import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kuesewa/app/modules/authentication/controllers/authentication_controller.dart';

import '../controllers/feed_controller.dart';

class postView extends GetView<FeedController> {
  final controller = Get.put(FeedController());
  final authC = Get.put(AuthenticationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          height: Get.width * 0.12,
                          width: Get.width * 0.12,
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
                        "Post",
                        style: GoogleFonts.plusJakartaSans(
                          color: Color(0xff0fc7b0),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      InkWell(
                        onTap: () => controller.post(
                          authC.userModel.value.email.toString(),
                          authC.userModel.value.username.toString(),
                          authC.userModel.value.photoUrl.toString(),
                        ),
                        child: Container(
                          height: Get.width * 0.12,
                          width: Get.width * 0.12,
                          decoration: BoxDecoration(
                            color: Color(0xff0fc7b0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.upload_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                GetBuilder<FeedController>(
                  builder: (controller) => Container(
                    height: Get.width * 0.6,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: controller.pickedImage != null
                            ? Color(0xff0fc7b0)
                            : Colors.black.withOpacity(0.2),
                      ),
                    ),
                    child: controller.pickedImage != null
                        ? Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: FileImage(
                                      File(controller.pickedImage!.path),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                child: InkWell(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                  onTap: () => controller.resetImage(),
                                  child: Container(
                                    height: Get.width * 0.12,
                                    width: Get.width * 0.12,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.delete_outline,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () => controller.selectImage(),
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_a_photo_outlined,
                                    size: 30,
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    'Add Photo',
                                    style: GoogleFonts.plusJakartaSans(),
                                  )
                                ],
                              ),
                            ),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Tentang*',
                  style: GoogleFonts.plusJakartaSans(),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextField(
                  controller: controller.tentang,
                  cursorColor: Color(0xff0fc7b0),
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                  ),
                  maxLines: 6,
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
            ),
          ),
        ),
      ),
    );
  }
}
