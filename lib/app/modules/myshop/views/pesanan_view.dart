import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kuesewa/app/modules/myshop/controllers/myshop_controller.dart';

import '../../authentication/controllers/authentication_controller.dart';
import '../../tranksaksi/controllers/tranksaksi_controller.dart';

class Pesanan extends GetView<Myshop_controller> {
  final transaksiC = Get.put(TranksaksiController());
  final authC = Get.put(AuthenticationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Icon(
                Icons.arrow_back_outlined,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Text(
                'Pesanan',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: transaksiC.streamTranksaksi(
            authC.userModel.value.email.toString(),
          ),
          builder: (context, snaphot) {
            var data = snaphot.data?.docs;

            if (snaphot.connectionState == ConnectionState.active) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  if (snaphot.connectionState == ConnectionState.active &&
                      data![index]['status'] != 'Selesai') {
                    return Container(
                      height: Get.width * 0.65,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                    color: data[index]['status'] == 'confirm'
                                        ? Colors.yellow.withOpacity(0.015)
                                        : Color(0xff0fc7b0).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: data[index]['status'] == 'confirm'
                                        ? Text(
                                            'Menunggu konfirmasi dari kamu nih!!',
                                            style: GoogleFonts.plusJakartaSans(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.yellow,
                                            ),
                                          )
                                        : data[index]['status'] == 'Dikirim'
                                            ? Text(
                                                'Dikirim',
                                                style:
                                                    GoogleFonts.plusJakartaSans(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xff0fc7b0),
                                                ),
                                              )
                                            : Text(
                                                'Barang disewa',
                                                style:
                                                    GoogleFonts.plusJakartaSans(
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: Get.width * 0.15,
                                  width: Get.width * 0.15,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data[index]['barang'],
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 3.0,
                                    ),
                                    Text(
                                      'Nama penerima : ${data[index]['namaPenerima']}',
                                      style: GoogleFonts.plusJakartaSans(),
                                    ),
                                    const SizedBox(
                                      height: 3.0,
                                    ),
                                    Text(
                                      'Nomer                         : ${data[index]['nomerPenyewa']}',
                                      style: GoogleFonts.plusJakartaSans(),
                                    ),
                                    const SizedBox(
                                      height: 3.0,
                                    ),
                                    Container(
                                      width: Get.width * 0.65,
                                      child: Text(
                                        'Alamat                         : ${data[index]['alamatPenyewa']}',
                                        style: GoogleFonts.plusJakartaSans(),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 3.0,
                                    ),
                                    Text(
                                      'lama sewa                : ${data[index]['lamaSewa']} Hari',
                                      style: GoogleFonts.plusJakartaSans(),
                                    ),
                                    const SizedBox(
                                      height: 3.0,
                                    ),
                                    Text(
                                      'Pembayaran          : ${data[index]['pembayaran']}',
                                      style: GoogleFonts.plusJakartaSans(),
                                    ),
                                    const SizedBox(
                                      height: 3.0,
                                    ),
                                    Text(
                                      'Jumlah barang      : ${data[index]['jumlahBarang']}',
                                      style: GoogleFonts.plusJakartaSans(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Expanded(child: SizedBox()),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Total sewa',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 3.0,
                                    ),
                                    Text(
                                      'Rp ${data[index]['totalHarga']}',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
                                ),
                                data[index]['status'] == 'confirm'
                                    ? GestureDetector(
                                        onTap: () =>
                                            controller.konfirmasiPesanan(
                                                authC.userModel.value.email!,
                                                data[index].id,
                                                data[index]['penyewa'],
                                                'Dikirim'),
                                        child: Container(
                                          height: Get.width * 0.08,
                                          width: Get.width * 0.25,
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
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : data[index]['status'] == 'Diterima'
                                        ? GestureDetector(
                                            onTap: () {
                                              controller.konfirmasiPesanan(
                                                authC.userModel.value.email!,
                                                data[index].id,
                                                data[index]['penyewa'],
                                                'Selesai',
                                              );
                                              controller.stokUpdate(
                                                data[index]['produkId'],
                                                int.parse(
                                                  data[index]['jumlahBarang'],
                                                ),
                                              );
                                            },
                                            child: Container(
                                              height: Get.width * 0.08,
                                              width: Get.width * 0.25,
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
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                    color: Color(0xff0fc7b0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(),
                              ],
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
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
