import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kuesewa/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:kuesewa/app/modules/myshop/controllers/myshop_controller.dart';
import 'package:kuesewa/app/routes/app_pages.dart';

class Daftarproduk extends GetView<Myshop_controller> {
  final authc = Get.find<AuthenticationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 12.0,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(Icons.arrow_back_outlined),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    child: Text(
                      'Daftar produk',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                    ),
                  ),
                  Expanded(
                    child: const SizedBox(),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.ADDPRODUCT),
                    child: Icon(Icons.add_outlined),
                  ),
                ],
              ),
              SizedBox(
                height: Get.width * 0.07,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Cari produk',
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xff0fc7b0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.1),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Color(0xff0fc7b0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Get.width * 0.04,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: controller
                      .streamProduk(authc.userModel.value.email.toString()),
                  builder: (context, snapshot) {
                    var listPost = snapshot.data?.docs;
                    if (snapshot.connectionState == ConnectionState.active) {
                      return ListView.separated(
                        itemBuilder: (context, index) => Container(
                          height: Get.width * 0.28,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black.withOpacity(0.1),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: Get.width * 0.14,
                                      width: Get.width * 0.14,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          listPost?[index]['Img'],
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          listPost![index]['NamaProduk'],
                                          style: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8.0,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Rp',
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              listPost[index]['Harga'],
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8.0,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Stok : ',
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              "${listPost[index]['Stok']}",
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Expanded(child: SizedBox()),
                                    GestureDetector(
                                      onTap: () => controller
                                          .hapusProduk(listPost[index].id),
                                      child: Container(
                                        height: Get.width * 0.1,
                                        width: Get.width * 0.1,
                                        decoration: BoxDecoration(
                                          color: Colors.red.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.delete_outline_outlined,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 6.0,
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.bottomSheet(
                                          Container(
                                            height: Get.width * 0.4,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                top: Radius.circular(25),
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: 15,
                                                  height: 5,
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                ),
                                                const SizedBox(
                                                  height: 15.0,
                                                ),
                                                TextField(
                                                  controller: controller.stok,
                                                  decoration: InputDecoration(
                                                    hintText: 'Stok baru',
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.black
                                                            .withOpacity(0.1),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xff0fc7b0),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                GestureDetector(
                                                  onTap: () =>
                                                      controller.updateStok(
                                                    listPost[index].id,
                                                  ),
                                                  child: Container(
                                                    height: Get.width * 0.12,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      gradient:
                                                          const LinearGradient(
                                                        begin:
                                                            Alignment.topRight,
                                                        end: Alignment
                                                            .bottomLeft,
                                                        colors: [
                                                          Color(0xff2ad88f),
                                                          Color(0xff0fc7b0),
                                                        ],
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        8,
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        'Update',
                                                        style: GoogleFonts
                                                            .plusJakartaSans(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      borderRadius: BorderRadius.circular(8),
                                      child: Container(
                                        height: Get.width * 0.08,
                                        width: Get.width * 0.42,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Ubah Stok',
                                            style:
                                                GoogleFonts.plusJakartaSans(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 14.0,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.bottomSheet(
                                          Container(
                                            height: Get.width * 0.4,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                top: Radius.circular(25),
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: 15,
                                                  height: 5,
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                ),
                                                const SizedBox(
                                                  height: 15.0,
                                                ),
                                                TextField(
                                                  controller: controller.harga,
                                                  decoration: InputDecoration(
                                                    hintText: 'Harga baru',
                                                    prefixIcon: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 16,
                                                        vertical: 16,
                                                      ),
                                                      child: Text(
                                                        'Rp',
                                                        style: GoogleFonts
                                                            .plusJakartaSans(
                                                          fontWeight:
                                                              FontWeight.w900,
                                                        ),
                                                      ),
                                                    ),
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 16),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.black
                                                            .withOpacity(0.1),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xff0fc7b0),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                GestureDetector(
                                                  onTap: () =>
                                                      controller.updateHarga(
                                                    listPost[index].id,
                                                  ),
                                                  child: Container(
                                                    height: Get.width * 0.12,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      gradient:
                                                          const LinearGradient(
                                                        begin:
                                                            Alignment.topRight,
                                                        end: Alignment
                                                            .bottomLeft,
                                                        colors: [
                                                          Color(0xff2ad88f),
                                                          Color(0xff0fc7b0),
                                                        ],
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        8,
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        'Update',
                                                        style: GoogleFonts
                                                            .plusJakartaSans(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      borderRadius: BorderRadius.circular(8),
                                      child: Container(
                                        height: Get.width * 0.08,
                                        width: Get.width * 0.42,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Ubah harga',
                                            style:
                                                GoogleFonts.plusJakartaSans(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        separatorBuilder: (_, index) =>
                            const SizedBox(height: 8.0),
                        itemCount: listPost!.length,
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
