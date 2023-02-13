import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kuesewa/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:kuesewa/app/modules/feed/controllers/feed_controller.dart';

import '../../../routes/app_pages.dart';
import '../../myshop/controllers/myshop_controller.dart';

class MerchantProfile extends GetView<FeedController> {
  final controller = Get.find<FeedController>();
  final authC = Get.find<AuthenticationController>();
  final produkC = Get.find<Myshop_controller>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Merchant profile',
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 22,
          ),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: Get.width * 0.01,
                ),
                Container(
                  height: Get.width * 0.38,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Color(0xffe5ecf7),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 65,
                            width: 65,
                            margin: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(32),
                              child: Image.network(
                                (Get.arguments
                                    as Map<String, dynamic>)["PhotoUrl"],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            (Get.arguments as Map<String, dynamic>)["By"],
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () => authC.addNewConnection(
                                (Get.arguments
                                    as Map<String, dynamic>)["Email"],
                                authC.userModel.value.email!,
                              ),
                              child: Container(
                                height: Get.width * 0.09,
                                width: Get.width * 0.32,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xff0fc7b0),
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    'Pesan',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      color: Color(0xff0fc7b0),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Container(
                              height: Get.width * 0.09,
                              width: Get.width * 0.32,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xff0fc7b0),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  'Peraturan',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12,
                                    color: Color(0xff0fc7b0),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Expanded(
                              child: Container(
                                height: Get.width * 0.09,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xff0fc7b0),
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.warning_outlined,
                                    color: Colors.red,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Color(0xffe5ecf7),
                    ),
                  ),
                  child: Obx(
                    () => TabBar(
                      unselectedLabelColor: Color(0xff0fc7b0),
                      onTap: (value) => controller.ontap(value),
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color(0xff2ad88f),
                            Color(0xff0fc7b0),
                          ],
                        ),
                      ),
                      tabs: [
                        Tab(
                          icon: controller.tab.value != 0
                              ? Icon(
                                  Icons.shop,
                                )
                              : Icon(
                                  Icons.shop_two_outlined,
                                  color: Colors.white,
                                ),
                        ),
                        Tab(
                          icon: controller.tab.value != 1
                              ? Icon(
                                  Icons.photo,
                                )
                              : Icon(
                                  Icons.photo_outlined,
                                  color: Colors.white,
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: produkC.streamAllProduk(
                            authC.userModel.value.email!,
                          ),
                          builder: (context, snapshot) {
                            var listProduk = snapshot.data?.docs;
                            if (snapshot.connectionState ==
                                ConnectionState.active) {
                              return ListView.builder(
                                itemCount: 1,
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: const ScrollPhysics(),
                                itemBuilder: (context, int index) {
                                  return GridView.builder(
                                    padding: EdgeInsets.zero,
                                    physics: ScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                      mainAxisExtent: 260,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                    ),
                                    itemCount: listProduk!.length,
                                    itemBuilder: (context, int index2) {
                                      return GestureDetector(
                                        onTap: () => Get.toNamed(
                                          Routes.DETAIL_PRODUK,
                                          arguments: [
                                            listProduk,
                                            index2.toInt(),
                                          ],
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              color: Color(0xffe5ecf7),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: 155,
                                                  width: 176,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                        listProduk[index2]
                                                            ['Img'],
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                  vertical: 3,
                                                ),
                                                child: Text(
                                                  listProduk[index2]
                                                      ['NamaProduk'],
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                  vertical: 3,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.location_pin,
                                                      size: 14,
                                                      color: Color(0xff0fc7b0),
                                                    ),
                                                    const SizedBox(
                                                      width: 2.0,
                                                    ),
                                                    Text(
                                                      // TODO Api google maps
                                                      'Kota Makassar',
                                                      style: GoogleFonts
                                                          .plusJakartaSans(
                                                        fontSize: 13,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                  vertical: 3,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Rp',
                                                      style: GoogleFonts
                                                          .plusJakartaSans(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        color:
                                                            Color(0xff0fc7b0),
                                                      ),
                                                    ),
                                                    Text(
                                                      listProduk[index2]
                                                          ['Harga'],
                                                      style: GoogleFonts
                                                          .plusJakartaSans(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        color:
                                                            Color(0xff0fc7b0),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            }
                            return Container();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: StreamBuilder<QuerySnapshot<Object?>>(
                          stream: controller.streamPost(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.active) {
                              var listPost = snapshot.data!.docs;
                              return ListView.separated(
                                itemBuilder: (context, index) {
                                  if (listPost[index]['UploadBy'] ==
                                      (Get.arguments
                                          as Map<String, dynamic>)["Email"]) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(8),
                                            ),
                                            border: Border.all(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                            ),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  child: Image.network(
                                                    listPost[index]["PhotoUrl"],
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 15.0,
                                              ),
                                              Text(
                                                listPost[index]["UsernameBy"],
                                                style:
                                                    GoogleFonts.plusJakartaSans(
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                              Expanded(child: SizedBox()),
                                              Icon(Icons.menu_outlined)
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
                                              width: double.maxFinite,
                                              child: Image.network(
                                                listPost[index]["Img"],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8.0,
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
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                            ),
                                          ),
                                          child: Text(
                                            listPost[index]["Tentang"],
                                            textAlign: TextAlign.justify,
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 14,
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                      ],
                                    );
                                  }
                                  return null;
                                },
                                separatorBuilder: (_, index) =>
                                    SizedBox(height: 10),
                                itemCount: listPost.length,
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                    ],
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
