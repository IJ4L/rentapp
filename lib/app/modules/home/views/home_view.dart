// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kuesewa/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:kuesewa/app/modules/detailProduk/controllers/detail_produk_controller.dart';
import 'package:kuesewa/app/modules/myshop/controllers/myshop_controller.dart';
import 'package:kuesewa/app/modules/profile/controllers/profile_controller.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final authC = Get.find<AuthenticationController>();
  final profileC = Get.put(ProfileController());
  final produkC = Get.put(Myshop_controller());
  final detailC = Get.put(DetailProdukController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
              child: Column(
                children: [
                  SizedBox(
                    height: Get.width * 0.05,
                  ),
                  Row(
                    children: [
                      Container(
                        height: Get.width * 0.14,
                        width: Get.width * 0.14,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Get.width * 0.14 / 2),
                        ),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(Get.width * 0.14 / 2),
                          child: Obx(
                            () => Image.network(
                              profileC.userModel.value.photoUrl == null
                                  ? "https://i.ibb.co/S32HNjD/no-image.jpg"
                                  : profileC.userModel.value.photoUrl
                                      .toString(),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Kirim ke ',
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(
                            height: 3.5,
                          ),
                          Container(
                            width: 100,
                            child: StreamBuilder<
                                QuerySnapshot<Map<String, dynamic>>>(
                              stream: detailC
                                  .streamAlamat(authC.userModel.value.email!),
                              builder: (context, snapshot) {
                                var alamat = snapshot.data?.docs;
                                if (snapshot.connectionState ==
                                        ConnectionState.active &&
                                    alamat![0]['label'] != 'k') {
                                  return Text(
                                    alamat[0]['label'],
                                    style: GoogleFonts.plusJakartaSans(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }
                                return Text(
                                  'Indonesia',
                                  style: GoogleFonts.plusJakartaSans(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Expanded(child: SizedBox()),
                      Container(
                        height: Get.width * 0.13,
                        width: Get.width * 0.13,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Get.width * 0.13 / 2),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.2),
                          ),
                        ),
                        child: Center(
                          child: Icon(Icons.notifications_outlined),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      InkWell(
                        onTap: () => Get.toNamed(Routes.CART),
                        child: Container(
                          height: Get.width * 0.13,
                          width: Get.width * 0.13,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Get.width * 0.13 / 2),
                            border: Border.all(
                              color: Colors.black.withOpacity(0.2),
                            ),
                          ),
                          child: Center(
                            child: Icon(Icons.shopping_bag_outlined),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.SEARCH),
                    child: Container(
                      height: Get.width * 0.13,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search_rounded,
                            color: Colors.black.withOpacity(0.4),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'Mau sewa apa nih?',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.4),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  _rowMaker('Opening'),
                  Container(
                    height: Get.width * 0.45,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color(0xff2ad88f),
                          Color(0xff0fc7b0),
                        ],
                      ),
                      borderRadius:
                          BorderRadius.circular(Get.width * 0.4 / 4.5),
                    ),
                  ),
                  _rowMaker('Barang pilihan'),
                  Container(
                    height: Get.width * 0.1,
                    width: double.infinity,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          controller.onClick(index);
                        },
                        child: Obx(
                          () => Column(
                            children: [
                              Container(
                                height: Get.width * 0.1,
                                width: Get.width * 0.285,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xff0fc7b0),
                                    width: 1.5,
                                  ),
                                  gradient: controller.currentIndex == index
                                      ? const LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          colors: [
                                            Color(0xff2ad88f),
                                            Color(0xff0fc7b0),
                                          ],
                                        )
                                      : const LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          colors: [
                                            Colors.white,
                                            Colors.white,
                                          ],
                                        ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    controller.category[index],
                                    style: GoogleFonts.plusJakartaSans(
                                      color: controller.currentIndex == index
                                          ? Colors.white
                                          : Color(0xff0fc7b0),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      separatorBuilder: (_, index) => SizedBox(
                        width: 8.0,
                      ),
                      itemCount: 3,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Obx(
                    () => Center(
                      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: controller.currentIndex == 0
                            ? controller
                                .streamBarang(authC.userModel.value.email!)
                            : controller.currentIndex == 1
                                ? controller
                                    .streamJasa(authC.userModel.value.email!)
                                : controller
                                    .streamTempat(authC.userModel.value.email!),
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
                                    maxCrossAxisExtent: Get.width * 0.5,
                                    mainAxisExtent: Get.width * 0.6,
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
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color: Color(0xffe5ecf7),
                                          ),
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
                                                      listProduk[index2]['Img'],
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
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
                                                style:
                                                    GoogleFonts.plusJakartaSans(
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
                                                  Text(
                                                    'Rp',
                                                    style: GoogleFonts
                                                        .plusJakartaSans(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Color(0xff0fc7b0),
                                                    ),
                                                  ),
                                                  Text(
                                                    listProduk[index2]['Harga'],
                                                    style: GoogleFonts
                                                        .plusJakartaSans(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Color(0xff0fc7b0),
                                                    ),
                                                  ),
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
                  ),
                  const SizedBox(
                    height: 18.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column _rowMaker(String txt) {
    return Column(
      children: [
        const SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              txt,
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            Icon(Icons.arrow_drop_down_circle_outlined)
          ],
        ),
        const SizedBox(height: 15.0),
      ],
    );
  }
}
