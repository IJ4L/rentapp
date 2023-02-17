// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kuesewa/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:kuesewa/app/modules/chat/controllers/chat_controller.dart';
import 'package:kuesewa/app/routes/app_pages.dart';

import '../../myshop/controllers/myshop_controller.dart';
import '../controllers/detail_produk_controller.dart';

class DetailProdukView extends GetView<DetailProdukController> {
  final authC = Get.find<AuthenticationController>();
  final chatC = Get.find<ChatController>();
  final produkC = Get.find<Myshop_controller>();
  final detailProduk = Get.arguments[0];
  int index = Get.arguments[1];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Detail produk',
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xff2ad88f),
                Color(0xff0fc7b0),
              ],
            ),
          ),
        ),
        actions: [Container()],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Get.width * 0.9,
              width: double.infinity,
              child: Image.network(
                detailProduk[index]['Img'],
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Color(0xffe5ecf7),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      detailProduk[index]['NamaProduk'],
                      style: GoogleFonts.roboto(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    linear(),
                    Text(
                      'Rp${detailProduk[index]['Harga']}',
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    linear(),
                    Text(
                      'Detail Produk',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    _detailProduk(
                        'Min. Sewa', detailProduk[index]['Minpesanan']),
                    _detailProduk(
                      'Stok',
                      detailProduk[index]['Stok'] != 0
                          ? detailProduk[index]['Stok'].toString()
                          : 'kosong',
                    ),
                    _detailProduk(
                      'Berat',
                      '${detailProduk[index]['Berat']} Gram',
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      'Deskripsi Produk',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      detailProduk[index]['Deskripsi'],
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.roboto(),
                    ),
                    linear(),
                    GestureDetector(
                      onTap: () => authC.addNewConnection(
                        detailProduk[index]['UploadBy'],
                        authC.userModel.value.email!,
                      ),
                      child: Container(
                        height: Get.width * 0.14,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Get.width * 0.14 / 2),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                Get.width * 0.14 / 2,
                              ),
                              child: Image.network(
                                detailProduk[index]['PhotoUrl'],
                                width: 60,
                                height: 60,
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.04,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  detailProduk[index]['UsernameBy'],
                                ),
                                SizedBox(
                                  height: Get.width * 0.02,
                                ),
                                Text(
                                  detailProduk[index]['kota'],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Mungkin cocok ',
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Icon(Icons.arrow_drop_down_circle_outlined)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: produkC.streamAllProduk(authC.userModel.value.email!),
                  builder: (context, snapshot) {
                    var listProduk = snapshot.data?.docs;
                    if (snapshot.connectionState == ConnectionState.active) {
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
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.black.withOpacity(0.1),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
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
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 3,
                                        ),
                                        child: Text(
                                          listProduk[index2]['NamaProduk'],
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
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
                                              'Kota Makassar',
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                fontSize: 13,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 3,
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Rp',
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800,
                                                color: Color(0xff0fc7b0),
                                              ),
                                            ),
                                            Text(
                                              listProduk[index2]['Harga'],
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800,
                                                color: Color(0xff0fc7b0),
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
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 40,
        color: Colors.white,
        width: Get.width * 0.92,
        margin: EdgeInsets.all(16),
        child: Row(
          children: [
            InkWell(
              onTap: () => authC.addNewConnection(
                detailProduk[index]['UploadBy'],
                authC.userModel.value.email!,
              ),
              child: Container(
                height: 40,
                width: 55,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xffe5ecf7),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Icon(
                    Icons.chat_outlined,
                    size: 24,
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            InkWell(
              onTap: () => controller.keranjang(
                authC.userModel.value.email!,
                detailProduk[index]['Img'],
                detailProduk[index]['NamaProduk'],
                detailProduk[index]['Harga'],
                detailProduk[index]['UploadBy'],
                ' ${detailProduk[index]['Stok']}',
              ),
              child: Container(
                height: Get.height * 0.4,
                width: Get.width * 0.36,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xffe5ecf7),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 16,
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        'Keranjang',
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            GestureDetector(
              child: detailProduk[index]['Stok'] != 0
                  ? GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          Routes.PEMBAYARAN,
                          arguments: [detailProduk, index.toInt()],
                        );
                        controller
                            .subtotal(int.parse(detailProduk[index]['Harga']));
                      },
                      child: Container(
                        height: 40,
                        width: Get.width * 0.36,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color(0xff2ad88f),
                              Color(0xff0fc7b0),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'Sewa',
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(
                      height: 40,
                      width: Get.width * 0.36,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Sewa',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
            ),
            const SizedBox(
              width: 10.0,
            ),
          ],
        ),
      ),
    );
  }

  Column _detailProduk(String kategori, String status) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                kategori,
                style: GoogleFonts.roboto(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
            const SizedBox(
              width: 86.0,
            ),
            Text(
              status,
              style: GoogleFonts.roboto(
                color: Colors.black.withOpacity(0.8),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8.0,
        ),
        Container(
          height: 1,
          width: double.infinity,
          color: Color(0xffe5ecf7),
        ),
        const SizedBox(
          height: 8.0,
        ),
      ],
    );
  }

  Column linear() {
    return Column(
      children: [
        const SizedBox(
          height: 16.0,
        ),
        Container(
          height: 1,
          width: double.infinity,
          color: Color(0xffe5ecf7),
        ),
        const SizedBox(
          height: 16.0,
        ),
      ],
    );
  }
}
