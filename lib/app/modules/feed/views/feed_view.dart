import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kuesewa/app/modules/feed/views/addPost__View.dart';

import '../controllers/feed_controller.dart';

class FeedView extends GetView<FeedController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            Container(
              height: Get.width * 0.08,
              width: Get.width * 0.1,
              child: ClipRRect(
                child: Image.asset(
                  "assets/images/logo2.jpg",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(
              width: 12.0,
            ),
            Text(
              'Feed',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Get.width * 0.04,
                    ),
                    Container(
                      height: Get.width * 0.12,
                      width: double.infinity,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () => controller.klik(index),
                          child: Column(
                            children: [
                              Obx(
                                () => Stack(
                                  children: [
                                    Container(
                                      height: Get.width * 0.12,
                                      width: Get.width * 0.45,
                                      decoration: BoxDecoration(
                                        gradient:
                                            controller.feedCategory.value ==
                                                    index
                                                ? LinearGradient(
                                                    begin: Alignment.topRight,
                                                    end: Alignment.bottomLeft,
                                                    colors: [
                                                      Color(0xff2ad88f),
                                                      Color(0xff0fc7b0),
                                                    ],
                                                  )
                                                : LinearGradient(
                                                    colors: [
                                                      Colors.white,
                                                      Colors.white,
                                                    ],
                                                  ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      top: 0,
                                      right: 0,
                                      left: 0,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          controller.category[index],
                                          style: GoogleFonts.plusJakartaSans(
                                            color:
                                                controller.feedCategory.value ==
                                                        index
                                                    ? Colors.white
                                                    : Color(0xff2ad88f),
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        separatorBuilder: (_, index) => SizedBox(
                          width: 4,
                        ),
                        itemCount: 2,
                      ),
                    ),
                    SizedBox(
                      height: Get.width * 0.02,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Get.width * 0.01,
            ),
            Obx(
              () => controller.feedPage[controller.feedCategory.value],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: Color(0xff2ad88f),
        ),
        onPressed: () => Get.to(postView()),
      ),
    );
  }
}
