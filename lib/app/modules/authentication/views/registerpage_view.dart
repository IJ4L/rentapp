import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kuesewa/app/modules/authentication/views/loginpage_view.dart';

import '../controllers/authentication_controller.dart';

class Registerpageview extends GetView<AuthenticationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: Get.width * 0.35,
            ),
            Image.asset(
              "assets/images/logo.png",
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              "Buat Akun",
              style: GoogleFonts.roboto(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: controller.usernameController,
                cursorColor: Color(0xff0fc7b0),
                decoration: InputDecoration(
                  hintText: 'Username',
                  hintStyle: GoogleFonts.roboto(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.2),
                  ),
                  prefixIcon: Icon(
                    Icons.people_outline_outlined,
                    color: Color(0xff0fc7b0),
                  ),
                  prefixIconColor: Colors.grey,
                  filled: true,
                  fillColor: Colors.black.withOpacity(0.025),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff0fc7b0),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 18.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: controller.emailController,
                cursorColor: Color(0xff0fc7b0),
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: GoogleFonts.roboto(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.2),
                  ),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Color(0xff0fc7b0),
                  ),
                  prefixIconColor: Colors.grey,
                  filled: true,
                  fillColor: Colors.black.withOpacity(0.025),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff0fc7b0),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 18.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: controller.pwController,
                cursorColor: Color(0xff0fc7b0),
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: GoogleFonts.roboto(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.2),
                  ),
                  prefixIcon: Icon(
                    Icons.key,
                    color: Color(0xff0fc7b0),
                  ),
                  prefixIconColor: Colors.grey,
                  filled: true,
                  fillColor: Colors.black.withOpacity(0.025),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff0fc7b0),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 18.0,
            ),
            GestureDetector(
              onTap: () => controller.register(),
              child: Container(
                height: Get.width * 0.14,
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
                    'Daftar',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 32.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 1,
                  width: Get.width * 0.28,
                  margin: EdgeInsets.only(left: 16, right: 16),
                  color: Colors.black.withOpacity(0.1),
                ),
                Text(
                  'or continue with',
                  style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 1,
                  width: Get.width * 0.28,
                  margin: EdgeInsets.only(left: 16, right: 16),
                  color: Colors.black.withOpacity(0.1),
                )
              ],
            ),
            const SizedBox(
              height: 22.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {},
                  child: Container(
                    height: Get.width * 0.16,
                    width: Get.width * 0.2,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black.withOpacity(0.2),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Image.asset(
                        "assets/images/fb.png",
                        width: 35,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                InkWell(
                  onTap: () => controller.loginGoogle(),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: Get.width * 0.16,
                    width: Get.width * 0.2,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black.withOpacity(0.2),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Image.asset(
                        "assets/images/google.png",
                        width: 35,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                
              ],
            ),
            const SizedBox(
              height: 32.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sudah punya akun?',
                  style: GoogleFonts.roboto(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                GestureDetector(
                  onTap: () => Get.to(Loginpageview()),
                  child: Text(
                    'Sign in',
                    style: GoogleFonts.roboto(
                      color: Color(0xff0fc7b0),
                      fontWeight: FontWeight.bold,
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
}
