import 'package:google_fonts/google_fonts.dart';
// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuesewa/app/modules/detailProduk/controllers/detail_produk_controller.dart';
import 'package:kuesewa/app/routes/app_pages.dart';

import '../../authentication/controllers/authentication_controller.dart';

class Bayar extends GetView<DetailProdukController> {
  final authC = Get.find<AuthenticationController>();
  final detailProduk = Get.arguments[0];
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
          'Pembayaran',
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 22,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.width * 0.025,
              ),
              Obx(
                () => controller.error.value
                    ? Container(
                        height: Get.width * 0.12,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Mohon, Isi data dengan lengkap',
                              style: GoogleFonts.plusJakartaSans(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              Icons.warning_outlined,
                              size: 20,
                              color: Colors.red,
                            )
                          ],
                        ),
                      )
                    : Container(),
              ),
              SizedBox(
                height: Get.width * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Alamat pengiriman',
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.ALAMAT),
                    child: Text(
                      'Pilih alamat',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff0fc7b0),
                      ),
                    ),
                  )
                ],
              ),
              _garisMakes(),
              Container(
                height: Get.width * 0.12,
                width: double.infinity,
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: controller
                      .streamPembayarm(authC.userModel.value.email.toString()),
                  builder: (context, snapshot) {
                    var alamat = snapshot.data?.docs;
                    if (snapshot.connectionState == ConnectionState.active) {
                      controller.labelPenerima.value = alamat![0]['label'];
                      controller.penerima.value = alamat[0]['namaPenerima'];
                      controller.nomer.value = alamat[0]['nomerTelepon'];
                      controller.alamat.value = alamat[0]['alamatLengkap'];
                      if (alamat[0]['label'] == 'k') {
                        return Container(
                          height: Get.width * 0.12,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Masukkan alamat',
                                style: GoogleFonts.plusJakartaSans(),
                              ),
                              Icon(
                                Icons.warning_outlined,
                                size: 15,
                                color: Colors.red,
                              )
                            ],
                          ),
                        );
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            alamat[0]['label'],
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 4.0,
                          ),
                          Row(
                            children: [
                              Text(
                                alamat[0]['namaPenerima'],
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                ' (${alamat[0]['nomerTelepon']})',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            alamat[0]['alamatLengkap'],
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      );
                    }
                    return Container();
                  },
                ),
              ),
              SizedBox(
                height: Get.width * 0.06,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: Get.width * 0.16,
                        width: Get.width * 0.16,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            detailProduk['Img'],
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            detailProduk['NamaProduk'],
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: Get.width * 0.02,
                          ),
                          Row(
                            children: [
                              Text(
                                'Rp',
                                style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                '${detailProduk['Harga']}',
                                style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: Get.width * 0.06,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Jumlah',
                    style: GoogleFonts.plusJakartaSans(
                      color: Color(0xff0fc7b0),
                    ),
                  ),
                  Container(
                    height: Get.width * 0.1,
                    width: Get.width * 0.28,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black.withOpacity(0.1),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            // onTap: () => controller.decrement(
                            //     int.parse(detailProduk[index]['Harga'])),
                            child: Image.asset(
                              "assets/icons/miin.png",
                              width: 15,
                              color: Color(0xff0fc7b0),
                            ),
                          ),
                          Obx(
                            () => Text(controller.count.value.toString()),
                          ),
                          GestureDetector(
                            // onTap: () => controller.increament(
                            //   int.parse(detailProduk[index]['Harga']),
                            // ),
                            child: Icon(
                              Icons.add_outlined,
                              size: 15,
                              color: Color(0xff0fc7b0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Get.width * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Lama sewa / hari',
                    style: GoogleFonts.plusJakartaSans(
                      color: Color(0xff0fc7b0),
                    ),
                  ),
                  Container(
                    height: Get.width * 0.1,
                    width: Get.width * 0.28,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black.withOpacity(0.1),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            // onTap: () => controller.decrement2(
                            //   int.parse(detailProduk[index]['Harga']),
                            // ),
                            child: Image.asset(
                              "assets/icons/miin.png",
                              width: 15,
                              color: Color(0xff0fc7b0),
                            ),
                          ),
                          Obx(
                            () => Text(controller.lamaSewa.value.toString()),
                          ),
                          GestureDetector(
                            // onTap: () => controller.increament2(
                            //   int.parse(detailProduk[index]['Harga']),
                            // ),
                            child: Icon(
                              Icons.add_outlined,
                              size: 15,
                              color: Color(0xff0fc7b0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Get.width * 0.06,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => Get.bottomSheet(
                  Container(
                    height: Get.width * 0.84,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 26,
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Pilih pembayaran',
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: Get.width * 0.06,
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/gopay.png',
                                width: 50,
                              ),
                              const SizedBox(
                                width: 16.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Gopay',
                                    style: GoogleFonts.plusJakartaSans(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.grey.withOpacity(0.4)),
                                  ),
                                  const SizedBox(
                                    height: 6.0,
                                  ),
                                  Text(
                                    'Belum didukung',
                                    style: GoogleFonts.plusJakartaSans(
                                      color: Colors.grey.withOpacity(0.4),
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(child: SizedBox()),
                              Icon(Icons.arrow_right_outlined),
                            ],
                          ),
                          SizedBox(
                            height: Get.width * 0.045,
                          ),
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: Colors.black.withOpacity(0.1),
                          ),
                          SizedBox(
                            height: Get.width * 0.045,
                          ),
                          GestureDetector(
                            onTap: () => controller.bayar(),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.motorcycle_outlined,
                                  size: 45,
                                ),
                                const SizedBox(
                                  width: 16.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Cod',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 6.0,
                                    ),
                                    Text(
                                      'Cash or Duel',
                                      style: GoogleFonts.plusJakartaSans(),
                                    ),
                                  ],
                                ),
                                Expanded(child: SizedBox()),
                                Icon(Icons.arrow_right_outlined),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                child: Container(
                  height: Get.width * 0.14,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black.withOpacity(0.1),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Text(
                          'Pilih Pembayaran',
                          style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        Icon(Icons.arrow_right_outlined),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Get.width * 0.06,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subtotal',
                    style: GoogleFonts.plusJakartaSans(),
                  ),
                  Obx(
                    () => Text(
                      'Rp${controller.hargaTotal.value}',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Get.width * 0.04,
              ),
              _garisMakes(),
              SizedBox(
                height: Get.width * 0.04,
              ),
              Text(
                'Ringkasan sewa',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: Get.width * 0.03,
              ),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total harga (${controller.count} barang)',
                      style: GoogleFonts.plusJakartaSans(),
                    ),
                    Text(
                      'Rp${controller.hargaTotal.value}',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.width * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Pembayaran'),
                  Obx(
                    () => Text(
                      controller.pembayaran.value,
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: Get.width * 0.15,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total tagihan',
                    style: GoogleFonts.plusJakartaSans(),
                  ),
                  Obx(
                    () => Text(
                      'Rp${controller.hargaTotal.value}',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  controller.kirim(
                    authC.userModel.value.email!,
                    detailProduk['UploadBy'],
                    detailProduk['NamaProduk'],
                    detailProduk['Harga'],
                    detailProduk['Img'],
                    detailProduk.id,
                    detailProduk['Stok'],
                  );
                  controller.deletKeranjang(
                    detailProduk.id,
                    authC.userModel.value.email!,
                  );
                },
                child: Container(
                  height: Get.width * 0.12,
                  width: Get.width * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xff2ad88f),
                        Color(0xff0fc7b0),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Sewa',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
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
