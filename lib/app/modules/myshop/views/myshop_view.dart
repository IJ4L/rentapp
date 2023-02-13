import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kuesewa/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:kuesewa/app/modules/myshop/controllers/myshop_controller.dart';
import 'package:kuesewa/app/modules/profile/controllers/profile_controller.dart';
import 'package:kuesewa/app/routes/app_pages.dart';

class Myshop extends GetView<Myshop_controller> {
  final profilC = Get.put(ProfileController());
  final authc = Get.find<AuthenticationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        'Myshop',
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                    ),
                    Expanded(
                      child: const SizedBox(),
                    ),
                    Container(
                      height: Get.width * 0.09,
                      width: Get.width * 0.09,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          Get.width * 0.1 / 1,
                        ),
                        border: Border.all(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.width * 0.07,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    children: [
                      Container(
                        height: Get.width * 0.2,
                        width: Get.width * 0.2,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Get.width * 0.2 / 2),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.08),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(Get.width * 0.2 / 2),
                          child: Obx(
                            () => Image.network(
                              profilC.userModel.value.photoUrl!,
                              fit: BoxFit.fill,
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
                            profilC.userModel.value.username!,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w900,
                              fontSize: Get.width * 0.036,
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            '18 Followers',
                            style: GoogleFonts.ptSansNarrow(
                              fontWeight: FontWeight.w300,
                              fontSize: Get.width * 0.034,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                _garisMakes(),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.RIWAYAT),
                  child: _rowMaker('Penyewaan', 'Lihat riwayat'),
                ),
                SizedBox(
                  height: Get.width * 0.03,
                ),
                InkWell(
                  onTap: () => Get.toNamed(Routes.PESANAN),
                  borderRadius: BorderRadius.circular(8),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.width * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Pesanan',
                              style: GoogleFonts.plusJakartaSans(),
                            ),
                            Icon(Icons.arrow_right_outlined)
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Get.width * 0.02,
                      ),
                    ],
                  ),
                ),
                _garisMakes(),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.ADDPRODUCT),
                  child: _rowMaker('Produk', 'Tambah produk'),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                InkWell(
                  onTap: () => Get.toNamed(Routes.DAFTARPRODUK),
                  borderRadius: BorderRadius.circular(8),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Daftar Produk',
                                  style: GoogleFonts.ptSansNarrow(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                                StreamBuilder<
                                    QuerySnapshot<Map<String, dynamic>>>(
                                  stream: controller.streamProduk(
                                      authc.userModel.value.email.toString()),
                                  builder: (context, snapshot) {
                                    var listPost = snapshot.data?.docs;
                                    if (snapshot.connectionState ==
                                        ConnectionState.active) {
                                      return Row(
                                        children: [
                                          Text(
                                            listPost!.length.toString(),
                                            style: GoogleFonts.ptSansNarrow(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            ' Produk',
                                            style: GoogleFonts.ptSansNarrow(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    return Container();
                                  },
                                ),
                              ],
                            ),
                            Expanded(child: SizedBox()),
                            Icon(Icons.arrow_right_outlined),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
                _garisMakes(),
                _rowMaker('Kata penyewa', ''),
                const SizedBox(
                  height: 12.0,
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(8),
                      child: _pelangganMaker(
                        'Ulasan',
                        Icons.star_border_outlined,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(8),
                      child: _pelangganMaker(
                        'Diskusi',
                        Icons.chat_outlined,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(8),
                      child: _pelangganMaker(
                        'Pesanan  komplain',
                        Icons.indeterminate_check_box_outlined,
                      ),
                    ),
                  ],
                ),
                _garisMakes(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bantuan dan info lainnya',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(8),
                      child: _pelangganMaker(
                        'Pusat edukasi renter',
                        Icons.school_outlined,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(8),
                      child: _pelangganMaker(
                        'Bantuan tokopedia care',
                        Icons.medical_services_outlined,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(8),
                      child: _pelangganMaker(
                        'Pengaturan toko',
                        Icons.settings_outlined,
                      ),
                    ),
                  ],
                ),
                _garisMakes(),
                Text(
                  'Pengembangan bisnis',
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: Get.width * 0.35,
                          width: Get.width * 0.45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                offset: Offset(2, 1),
                                blurRadius: 1,
                                spreadRadius: 1,
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 12.0,
                              ),
                              Text(
                                'Statistik toko',
                                style: GoogleFonts.bebasNeue(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 9.0,
                        ),
                        Container(
                          height: Get.width * 0.35,
                          width: Get.width * 0.45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                offset: Offset(2, 1),
                                blurRadius: 1,
                                spreadRadius: 1,
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 12.0,
                              ),
                              Text(
                                'Feed',
                                style: GoogleFonts.bebasNeue(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      children: [
                        Container(
                          height: Get.width * 0.35,
                          width: Get.width * 0.45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                offset: Offset(2, 1),
                                blurRadius: 1,
                                spreadRadius: 1,
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 12.0,
                              ),
                              Text(
                                'Iklan dan promosi',
                                style: GoogleFonts.bebasNeue(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 9.0,
                        ),
                        Container(
                          height: Get.width * 0.35,
                          width: Get.width * 0.45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                offset: Offset(2, 1),
                                blurRadius: 1,
                                spreadRadius: 1,
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 12.0,
                              ),
                              Text(
                                'Layanan keuangan',
                                style: GoogleFonts.bebasNeue(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _pelangganMaker(String txt, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          const SizedBox(
            height: 4.0,
          ),
          Row(
            children: [
              Icon(
                icon,
                color: Colors.black,
              ),
              const SizedBox(
                width: 8.0,
              ),
              Text(
                txt,
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 4.0,
          ),
        ],
      ),
    );
  }

  Row _rowMaker(String txt, String txt2) {
    return Row(
      children: [
        Text(
          txt,
          style: GoogleFonts.ptSansNarrow(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        Expanded(child: SizedBox()),
        Text(
          txt2,
          style: GoogleFonts.ptSansNarrow(
            color: Color(0xff0fc7b0),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Column _garisMakes() {
    return Column(
      children: [
        const SizedBox(
          height: 16.0,
        ),
        Container(
          height: 0.5,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
        ),
        SizedBox(
          height: Get.width * 0.04,
        ),
      ],
    );
  }
}
