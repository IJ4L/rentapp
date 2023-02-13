import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kuesewa/app/modules/feed/controllers/feed_controller.dart';
import 'package:kuesewa/app/routes/app_pages.dart';
import 'package:shimmer/shimmer.dart';

class updateView extends GetView<FeedController> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot<Object?>>(
        stream: controller.streamPost(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Shimmer.fromColors(
              child: Column(
                children: [
                  Container(
                    height: Get.width * 1,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ),
                  )
                ],
              ),
              baseColor: Colors.grey.shade200,
              highlightColor: Colors.grey.shade500,
              direction: ShimmerDirection.ltr,
            );
          }
          if (snapshot.connectionState == ConnectionState.active) {
            var listPost = snapshot.data!.docs;
            return ListView.separated(
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(8),
                        ),
                        border: Border.all(
                          color: Color(0xffe5ecf7),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: Get.height * 0.06,
                            width: Get.height * 0.06,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.network(
                                listPost[index]["PhotoUrl"],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.04,
                          ),
                          Text(
                            listPost[index]["UsernameBy"],
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Column(
                      children: [
                        Container(
                          height: Get.width * 0.8,
                          width: double.infinity,
                          child: Image.network(
                            listPost[index]["Img"],
                            fit: BoxFit.cover,
                          ),
                        ),
                        InkWell(
                          onTap: () => Get.toNamed(
                            Routes.MERCHANTPROFILE,
                            arguments: {
                              'By': listPost[index]["UsernameBy"],
                              'Email': listPost[index]["UploadBy"],
                              'PhotoUrl': listPost[index]["PhotoUrl"],
                            },
                          ),
                          child: Container(
                            height: Get.width * 0.08,
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Color(0xff2ad88f),
                                  Color(0xff0fc7b0),
                                ],
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Cek toko',
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_right_outlined,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(8),
                        ),
                        border: Border.all(
                          color: Color(0xffe5ecf7),
                        ),
                      ),
                      child: Text(
                        listPost[index]["Tentang"],
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
              separatorBuilder: (_, index) => SizedBox(height: 10),
              itemCount: listPost.length,
            );
          }
          return const SizedBox(
            height: 1.0,
          );
        },
      ),
    );
  }
}
