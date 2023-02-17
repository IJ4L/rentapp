import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kuesewa/app/modules/detailProduk/controllers/detail_produk_controller.dart';
import 'package:kuesewa/app/routes/app_pages.dart';

import '../../authentication/controllers/authentication_controller.dart';

class Alamatview extends GetView<DetailProdukController> {
  final authC = Get.find<AuthenticationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                      'Alamat',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Expanded(
                    child: const SizedBox(),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.TAMBAHALAMAT),
                    child: Icon(Icons.add_outlined),
                  ),
                ],
              ),
              SizedBox(height: Get.width * 0.06),
              Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: controller
                      .streamAlamat(authC.userModel.value.email.toString()),
                  builder: (context, snapshot) {
                    var semuaAlamat = snapshot.data?.docs;
                    if (snapshot.connectionState == ConnectionState.active) {
                      return ListView.separated(
                        itemBuilder: (context, index) {
                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            return GestureDetector(
                              onTap: () {
                                controller.klikUtama(
                                  authC.userModel.value.email!,
                                  semuaAlamat![index]['label'],
                                  semuaAlamat[index]['alamatLengkap'],
                                  semuaAlamat[index]['namaPenerima'],
                                  semuaAlamat[index]['nomerTelepon'],
                                  controller.currenIndex.value,
                                );
                                controller.onkilk(index);
                              },
                              child: semuaAlamat![index]['utama']
                                  ? const SizedBox()
                                  : Container(
                                      height: Get.width * 0.27,
                                      width: double.infinity,
                                      padding: EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: controller.currenIndex.value ==
                                                  index
                                              ? Color(0xff0fc7b0)
                                              : Color(0xffe5ecf7),
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                semuaAlamat[index]['label'],
                                                style:
                                                    GoogleFonts.plusJakartaSans(
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 3.0,
                                              ),
                                              Text(
                                                semuaAlamat[index]
                                                    ['namaPenerima'],
                                                style:
                                                    GoogleFonts.plusJakartaSans(
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 3.0,
                                              ),
                                              Text(
                                                semuaAlamat[index]
                                                    ['nomerTelepon'],
                                                style:
                                                    GoogleFonts.plusJakartaSans(
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 3.0,
                                              ),
                                              Text(
                                                semuaAlamat[index]
                                                    ['alamatLengkap'],
                                                style:
                                                    GoogleFonts.plusJakartaSans(
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10.0,
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            child: SizedBox(),
                                          ),
                                          GestureDetector(
                                            onTap: () => controller.deletAlamat(
                                              semuaAlamat[index].id,
                                              authC.userModel.value.email!,
                                            ),
                                            child: Container(
                                              height: Get.width * 0.37,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                color:
                                                    Colors.red.withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Icon(
                                                Icons.delete_outline_outlined,
                                                color: Colors.red,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                            );
                          }
                          return Container();
                        },
                        separatorBuilder: (_, index) => SizedBox(height: 12.0),
                        itemCount: semuaAlamat!.length,
                      );
                    }
                    return Container();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
