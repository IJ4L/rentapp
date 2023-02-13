import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kuesewa/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:kuesewa/app/modules/detailProduk/controllers/detail_produk_controller.dart';

class Tambahalamatview extends GetView<DetailProdukController> {
  final authC = Get.find<AuthenticationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
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
                        'Tambah Alamat',
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ],
                ),
                _textfieldMaker('Label Alamat', controller.label),
                _textfieldMaker('Alamat Lengkap', controller.alamatLengkap),
                _textfieldMaker(
                    'Pesan untuk pengirim (Opsional)', controller.pesan),
                _textfieldMaker('Nama penerima', controller.namaPenerima),
                _textfieldMaker('Nomer Wa / Telepon', controller.nomerTelepon),
                SizedBox(
                  height: Get.width * 0.06,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Dengan klik 'simpan' kamu menyetujui ",
                      style: GoogleFonts.plusJakartaSans(),
                    ),
                    Text(
                      'syarat & ketentuan',
                      style: GoogleFonts.plusJakartaSans(
                        color: Color(0xff0fc7b0),
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: Get.width * 0.04,
                ),
                GestureDetector(
                  onTap: () => controller.addAlamat(
                    authC.userModel.value.email!,
                  ),
                  child: Container(
                    height: Get.width * 0.12,
                    width: double.infinity,
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
                        'Simpan',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _textfieldMaker(String txt, TextEditingController controller) {
    return Column(
      children: [
        SizedBox(
          height: Get.width * 0.06,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: controller,
            cursorColor: Color(0xff0fc7b0),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 8),
              label: Text(
                txt,
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.black.withOpacity(0.4),
                  fontSize: 14,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xffe5ecf7),
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xff0fc7b0),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
