import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kuesewa/app/modules/authentication/controllers/authentication_controller.dart';

import '../controllers/tranksaksi_controller.dart';

class TranksaksiView extends GetView<TranksaksiController> {
  final authC = Get.find<AuthenticationController>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Row(
            children: [
              Container(
                height: Get.width * 0.08,
                width: Get.width * 0.1,
                child: ClipRRect(
                  child: Image.asset(
                    "assets/images/logo2.jpg",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                width: 12.0,
              ),
              Text(
                'Transaksi',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          bottom: TabBar(
            labelColor: Color(0xff0fc7b0),
            unselectedLabelColor: Colors.black,
            indicatorColor: Color(0xff0fc7b0),
            tabs: [
              Tab(
                child: Text(
                  'Pesanan',
                  style: GoogleFonts.plusJakartaSans(),
                ),
              ),
              Tab(
                child: Text(
                  'Dikirim',
                  style: GoogleFonts.plusJakartaSans(),
                ),
              ),
              Tab(
                child: Text(
                  'Berlangsung',
                  style: GoogleFonts.plusJakartaSans(),
                ),
              ),
              Tab(
                child: Text(
                  'Selesai',
                  style: GoogleFonts.plusJakartaSans(),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: controller.streamTranksaksiBuyer(
                  authC.userModel.value.email.toString(),
                ),
                builder: (context, snaphot) {
                  var data = snaphot.data?.docs;
                  if (snaphot.connectionState == ConnectionState.active) {
                    return Column(
                      children: [
                        Container(
                          height: Get.width * 0.12,
                          width: double.infinity,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.black.withOpacity(0.1),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Pesananmu menunggu konfirmasi',
                                style: GoogleFonts.plusJakartaSans(),
                              ),
                              Icon(
                                Icons.info_outline,
                                size: 20,
                                color: Colors.black.withOpacity(0.35),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.width * 0.02,
                        ),
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              if (snaphot.connectionState ==
                                      ConnectionState.active &&
                                  data![index]['status'] == 'confirm') {
                                return Container(
                                  height: Get.width * 0.45,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
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
                                              'Sewa',
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Expanded(child: SizedBox()),
                                            Container(
                                              padding: EdgeInsets.all(6),
                                              decoration: BoxDecoration(
                                                color: Colors.yellow
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Menunggu konfirmasi renter',
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.yellow,
                                                  ),
                                                ),
                                              ),
                                            ),
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
                                                  data[index]['produkImg'],
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
                                                  data[index]['barang'],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 3.0,
                                                ),
                                                Text(
                                                  'Jumlah barang : ${data[index]['jumlahBarang']}',
                                                  style: GoogleFonts
                                                      .plusJakartaSans(),
                                                )
                                              ],
                                            ),
                                            Expanded(child: SizedBox()),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  'Total belanja',
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 3.0,
                                                ),
                                                Text(
                                                  'Rp ${data[index]['totalHarga']}',
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () =>
                                              controller.batalkanPesanan(
                                            data[index]['renter'],
                                            data[index].id,
                                            authC.userModel.value.email!,
                                          ),
                                          child: Container(
                                            width: Get.width * 0.2,
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.red
                                                    .withOpacity(0.15),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Batalkan',
                                                style:
                                                    GoogleFonts.plusJakartaSans(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
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
                            separatorBuilder: (_, index) => const SizedBox(
                              height: 12.0,
                            ),
                            itemCount: data!.length,
                          ),
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: controller.streamTranksaksiBuyer(
                  authC.userModel.value.email.toString(),
                ),
                builder: (context, snaphot) {
                  var data = snaphot.data?.docs;
                  if (snaphot.connectionState == ConnectionState.active) {
                    return Column(
                      children: [
                        Container(
                          height: Get.width * 0.12,
                          width: double.infinity,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.black.withOpacity(0.1),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Panduan pengiriman',
                                style: GoogleFonts.plusJakartaSans(),
                              ),
                              Icon(
                                Icons.info_outline,
                                size: 20,
                                color: Colors.black.withOpacity(0.35),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.width * 0.02,
                        ),
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              if (snaphot.connectionState ==
                                      ConnectionState.active &&
                                  data![index]['status'] == 'Dikirim') {
                                return Container(
                                  height: Get.width * 0.48,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
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
                                              'Sewa',
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Expanded(child: SizedBox()),
                                            Container(
                                              padding: EdgeInsets.all(6),
                                              decoration: BoxDecoration(
                                                color: Color(0xff0fc7b0)
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Dikirim',
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xff0fc7b0),
                                                  ),
                                                ),
                                              ),
                                            )
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
                                                  data[index]['produkImg'],
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
                                                  data[index]['barang'],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 3.0,
                                                ),
                                                Text(
                                                  'Jumlah barang : ${data[index]['jumlahBarang']}',
                                                  style: GoogleFonts
                                                      .plusJakartaSans(),
                                                )
                                              ],
                                            ),
                                            Expanded(child: SizedBox()),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  'Total belanja',
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 3.0,
                                                ),
                                                Text(
                                                  'Rp ${data[index]['totalHarga']}',
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () =>
                                              controller.konfirmasiDiterima(
                                            data[index]['renter'],
                                            data[index].id,
                                            authC.userModel.value.email!,
                                          ),
                                          child: Container(
                                            height: Get.width * 0.1,
                                            width: Get.width * 0.3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                color: Color(0xff0fc7b0),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Konfirmasi',
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
                                  ),
                                );
                              }
                              return Container();
                            },
                            separatorBuilder: (_, index) => const SizedBox(),
                            itemCount: data!.length,
                          ),
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: controller.streamTranksaksiBuyer(
                  authC.userModel.value.email.toString(),
                ),
                builder: (context, snaphot) {
                  var data = snaphot.data?.docs;
                  if (snaphot.connectionState == ConnectionState.active) {
                    return Column(
                      children: [
                        Container(
                          height: Get.width * 0.12,
                          width: double.infinity,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.black.withOpacity(0.1),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Panduan barang sewa',
                                style: GoogleFonts.plusJakartaSans(),
                              ),
                              Icon(
                                Icons.info_outline,
                                size: 20,
                                color: Colors.black.withOpacity(0.35),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.width * 0.02,
                        ),
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              if (snaphot.connectionState ==
                                      ConnectionState.active &&
                                  data![index]['status'] == 'Diterima') {
                                return Container(
                                  height: Get.width * 0.48,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
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
                                              'Sewa',
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Expanded(child: SizedBox()),
                                            Container(
                                              padding: EdgeInsets.all(6),
                                              decoration: BoxDecoration(
                                                color: Color(0xff0fc7b0)
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Diterima',
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xff0fc7b0),
                                                  ),
                                                ),
                                              ),
                                            )
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
                                                  data[index]['produkImg'],
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
                                                  data[index]['barang'],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 3.0,
                                                ),
                                                Text(
                                                  'Jumlah barang : ${data[index]['jumlahBarang']}',
                                                  style: GoogleFonts
                                                      .plusJakartaSans(),
                                                )
                                              ],
                                            ),
                                            Expanded(child: SizedBox()),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  'Total belanja',
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 3.0,
                                                ),
                                                Text(
                                                  'Rp ${data[index]['totalHarga']}',
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Get.width * 0.025,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: controller.date.value ==
                                                    data[index]['pickAt']
                                                ? Colors.red.withOpacity(0.15)
                                                : Color(0xff0fc7b0)
                                                    .withOpacity(0.2),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Tanggal pengembalian : ',
                                                style:
                                                    GoogleFonts.plusJakartaSans(
                                                  color: controller
                                                              .date.value ==
                                                          data[index]['pickAt']
                                                      ? Colors.red
                                                      : Color(0xff0fc7b0),
                                                ),
                                              ),
                                              Text(
                                                data[index]['pickAt'],
                                                style:
                                                    GoogleFonts.plusJakartaSans(
                                                  color: controller
                                                              .date.value ==
                                                          data[index]['pickAt']
                                                      ? Colors.red
                                                      : Color(0xff0fc7b0),
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }
                              return Container();
                            },
                            separatorBuilder: (_, index) => const SizedBox(
                            ),
                            itemCount: data!.length,
                          ),
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: controller.streamTranksaksiBuyer(
                  authC.userModel.value.email.toString(),
                ),
                builder: (context, snaphot) {
                  var data = snaphot.data?.docs;
                  if (snaphot.connectionState == ConnectionState.active) {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        if (snaphot.connectionState ==
                                    ConnectionState.active &&
                                data![index]['status'] == 'Selesai' ||
                            data![index]['status'] == 'Batal') {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 8),
                            child: Container(
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
                                  crossAxisAlignment: CrossAxisAlignment.end,
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
                                          'Sewa',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Expanded(child: SizedBox()),
                                        Container(
                                          padding: EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color: data[index]['status'] ==
                                                    'Batal'
                                                ? Colors.red.withOpacity(0.15)
                                                : Color(0xff0fc7b0)
                                                    .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                            child: data[index]['status'] ==
                                                    'Batal'
                                                ? Text(
                                                    'Batal',
                                                    style: GoogleFonts
                                                        .plusJakartaSans(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red,
                                                    ),
                                                  )
                                                : Text(
                                                    'Selesai',
                                                    style: GoogleFonts
                                                        .plusJakartaSans(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          Color(0xff0fc7b0),
                                                    ),
                                                  ),
                                          ),
                                        )
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
                                              data[index]['produkImg'],
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
                                              data[index]['barang'],
                                              overflow: TextOverflow.ellipsis,
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 3.0,
                                            ),
                                            Text(
                                              'Jumlah barang : ${data[index]['jumlahBarang']}',
                                              style: GoogleFonts
                                                  .plusJakartaSans(),
                                            )
                                          ],
                                        ),
                                        Expanded(child: SizedBox()),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Total belanja',
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                fontSize: 12,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 3.0,
                                            ),
                                            Text(
                                              'Rp ${data[index]['totalHarga']}',
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        return Container();
                      },
                      separatorBuilder: (_, index) => const SizedBox(),
                      itemCount: data!.length,
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
