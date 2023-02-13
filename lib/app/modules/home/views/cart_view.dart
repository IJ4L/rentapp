import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kuesewa/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:kuesewa/app/modules/detailProduk/controllers/detail_produk_controller.dart';
import 'package:kuesewa/app/modules/home/controllers/home_controller.dart';
import 'package:kuesewa/app/routes/app_pages.dart';

class Cartview extends GetView<HomeController> {
  final authC = Get.find<AuthenticationController>();
  final detailC = Get.put(DetailProdukController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Keranjang',
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 22,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream:
                    controller.streamKeranjang(authC.userModel.value.email!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    var dataKeranjang = snapshot.data!.docs;
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          return Container(
                            height: Get.width * 0.38,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.black.withOpacity(0.1),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.shopping_bag_outlined,
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.02,
                                      ),
                                      Text(
                                        'Mau Sewa barang ini?',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Expanded(child: SizedBox()),
                                      Container(),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Get.width * 0.04,
                                  ),
                                  Container(
                                    height: 1,
                                    width: double.infinity,
                                    color: Colors.black.withOpacity(0.1),
                                  ),
                                  SizedBox(
                                    height: Get.width * 0.04,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: Get.width * 0.15,
                                        width: Get.width * 0.15,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                            dataKeranjang[index]['Img'],
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 12.0,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            dataKeranjang[index]['NamaProduk'],
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.plusJakartaSans(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          Text(
                                            'Rp${dataKeranjang[index]['Harga']}',
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(child: SizedBox()),
                                      GestureDetector(
                                        onTap: () {
                                          print(dataKeranjang[index]);
                                          Get.toNamed(
                                            Routes.BAYARCART,
                                            arguments: [
                                              dataKeranjang[index],
                                            ],
                                          );
                                        },
                                        child: Container(
                                          width: Get.width * 0.2,
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Color(0xff0fc7b0)
                                                .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Sewa',
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                color: Color(0xff0fc7b0),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return Container();
                      },
                      separatorBuilder: (_, index) => SizedBox(),
                      itemCount: dataKeranjang.length,
                    );
                    
                  }
                  return Container();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
