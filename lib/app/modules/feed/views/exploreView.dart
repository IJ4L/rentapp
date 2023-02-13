import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuesewa/app/modules/feed/controllers/feed_controller.dart';
import 'package:shimmer/shimmer.dart';

class exploreView extends GetView<FeedController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder<QuerySnapshot<Object?>>(
                stream: controller.streamPost(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Shimmer.fromColors(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [_shimmwe(), _shimmwe(), _shimmwe()],
                        ),
                        baseColor: Colors.grey.shade200,
                        highlightColor: Colors.grey.shade500,
                        direction: ShimmerDirection.ltr,
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.active) {
                    var listPost = snapshot.data!.docs;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListView.builder(
                        itemCount: 1,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const ScrollPhysics(),
                        itemBuilder: (context, int index) {
                          return Container(
                            height: Get.width * 1.36,
                            child: GridView.builder(
                              padding: EdgeInsets.zero,
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 150,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                              ),
                              itemCount: listPost.length,
                              itemBuilder: (context, int index) {
                                return Container(
                                  height: 100,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      listPost[index]["Img"],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox();
                },
              )
            ],
          ),
        ),
      ],
    );
  }

  Container _shimmwe() {
    return Container(
      height: Get.width * 0.3,
      width: Get.width * 0.3,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
