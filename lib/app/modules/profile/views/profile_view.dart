import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kuesewa/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:kuesewa/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final authC = Get.find<AuthenticationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Profile',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.width * 0.04,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    children: [
                      Obx(
                        () => Container(
                          height: Get.width * 0.18,
                          width: Get.width * 0.18,
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(Get.width * 0.2 / 2),
                            child: Image.network(
                              controller.userModel.value.photoUrl.toString(),
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
                            controller.userModel.value.username!,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w900,
                              fontSize: Get.width * 0.036,
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Text(
                            controller.userModel.value.email!,
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w300,
                              fontSize: Get.width * 0.034,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.width * 0.03,
                ),
                _garisMakes(),
                InkWell(
                  onTap: () => Get.toNamed(Routes.MYSHOP),
                  borderRadius: BorderRadius.circular(8),
                  child: _rowMaker('My Shop', Icons.calendar_month_outlined),
                ),
                _rowMaker(
                    'Special Offers & Promo', Icons.price_change_outlined),
                _rowMaker('Payments Method', Icons.money_outlined),
                SizedBox(
                  height: Get.width * 0.03,
                ),
                _garisMakes(),
                InkWell(
                  onTap: () => Get.toNamed(Routes.EDITPROFILE),
                  child: _rowMaker(
                      'Profile', Icons.supervised_user_circle_outlined),
                ),
                InkWell(
                  onTap: () => Get.toNamed(Routes.ALAMAT),
                  child: _rowMaker('Address', Icons.location_pin),
                ),
                _rowMaker('Security', Icons.security_outlined),
                InkWell(
                  onTap: () => authC.addNewConnection(
                    'vccxv60@gmail.com',
                    authC.userModel.value.email!,
                  ),
                  child: _rowMaker('Help Center', Icons.info_outline),
                ),
                _rowMaker('Invite Friends', Icons.child_friendly_outlined),
                InkWell(
                  onTap: () => Get.bottomSheet(
                    Container(
                      height: Get.width * 0.6,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            SizedBox(
                              height: Get.width * 0.03,
                            ),
                            Container(
                              height: 4,
                              width: Get.width * 0.08,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            SizedBox(
                              height: Get.width * 0.06,
                            ),
                            Text(
                              'Logout',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(
                              height: Get.width * 0.06,
                            ),
                            Container(
                              height: 1,
                              width: double.infinity,
                              color: Colors.black.withOpacity(0.1),
                            ),
                            SizedBox(
                              height: Get.width * 0.06,
                            ),
                            Text(
                              'Apakah kamu yakin ingin keluar?',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: Get.width * 0.05,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () => Get.back(),
                                  child: Container(
                                    height: Get.width * 0.14,
                                    width: Get.width * 0.43,
                                    decoration: BoxDecoration(
                                      color: Color(0xff0fc7b0).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(
                                        Get.width * 0.16 / 2,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Cancel',
                                        style: GoogleFonts.plusJakartaSans(
                                          color: Color(0xff0fc7b0),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.035,
                                ),
                                GestureDetector(
                                  onTap: () => controller.logOut(),
                                  child: Container(
                                    height: Get.width * 0.14,
                                    width: Get.width * 0.43,
                                    decoration: BoxDecoration(
                                      color: Color(0xff0fc7b0),
                                      borderRadius: BorderRadius.circular(
                                        Get.width * 0.16 / 2,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Yes, Logout',
                                        style: GoogleFonts.plusJakartaSans(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
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
                    ),
                  ),
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.width * 0.025,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.logout_outlined,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 12.0,
                            ),
                            Text(
                              'Logout',
                              style: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.width * 0.025,
                        ),
                      ],
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

  Padding _rowMaker(String txt, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          SizedBox(
            height: Get.width * 0.025,
          ),
          Row(
            children: [
              Icon(icon),
              const SizedBox(
                width: 12.0,
              ),
              Text(
                txt,
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Expanded(child: const SizedBox()),
              Icon(Icons.arrow_right_outlined),
            ],
          ),
          SizedBox(
            height: Get.width * 0.025,
          ),
        ],
      ),
    );
  }

  Column _garisMakes() {
    return Column(
      children: [
        Container(
          height: 0.5,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.1)),
        ),
        SizedBox(
          height: Get.width * 0.04,
        ),
      ],
    );
  }
}
