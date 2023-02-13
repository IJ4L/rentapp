import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kuesewa/app/modules/authentication/views/loginpage_view.dart';
import 'package:kuesewa/app/modules/authentication/views/registerpage_view.dart';

import '../controllers/authentication_controller.dart';

class Authentication extends GetView<AuthenticationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: Get.width * 0.5,
          ),
          Image.asset(
            "assets/images/masukdengan.png",
          ),
          Text(
            "Hei Ayo Masuk",
            style: GoogleFonts.roboto(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => controller.loginGoogle(),
              child: Container(
                height: Get.width * 0.15,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black.withOpacity(0.1),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/google.png",
                        width: 30,
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Text(
                        'Masuk dengan akun Google',
                        style: GoogleFonts.roboto(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Row(
            children: [
              Container(
                height: 1,
                width: Get.width * 0.4,
                margin: EdgeInsets.only(left: 16, right: 16),
                color: Colors.black.withOpacity(0.1),
              ),
              Text(
                'or',
                style: GoogleFonts.roboto(),
              ),
              Container(
                height: 1,
                width: Get.width * 0.4,
                margin: EdgeInsets.only(left: 16, right: 16),
                color: Colors.black.withOpacity(0.1),
              )
            ],
          ),
          const SizedBox(
            height: 22.0,
          ),
          InkWell(
            onTap: () => Get.to(Loginpageview()),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: Get.width * 0.15,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16),
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
                  'Masuk dengan email',
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: Get.width * 0.08,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Tidak punya akun?',
                style: GoogleFonts.roboto(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              const SizedBox(
                width: 5.0,
              ),
              GestureDetector(
                onTap: () => Get.to(Registerpageview()),
                child: Text(
                  'Sign up',
                  style: GoogleFonts.roboto(
                    color: Color(0xff0fc7b0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: Get.width * 0.08,
          ),
        ],
      ),
    );
  }
}
