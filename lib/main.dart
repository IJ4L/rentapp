import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:kuesewa/app/modules/authentication/controllers/authentication_controller.dart';

import 'app/routes/app_pages.dart';

final authC = Get.put(AuthenticationController(), permanent: true);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(
      FutureBuilder(
        future: Future.delayed(Duration(seconds: 5)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Obx(
              () => GetMaterialApp(
                title: "ChatApp",
                debugShowCheckedModeBanner: false,
                debugShowMaterialGrid: false,
                theme: ThemeData(
                  brightness: Brightness.light,
                  primaryColor: Colors.white,
                ),
                initialRoute: authC.isAuth.isTrue
                    ? Routes.HALAMAN_UTAMA
                    : Routes.AUTHENTICATION,
                getPages: AppPages.routes,
              ),
            );
          }
          return FutureBuilder(
            future: authC.firstInitialized(),
            builder: (context, snapshot) => Container(
              color: Colors.white,
              child: Center(
                child: Image.asset(
                  "assets/images/logo2.jpg",
                  width: Get.width * 0.3,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}
