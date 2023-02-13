// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kuesewa/app/modules/NavigationBar/controllers/halaman_utama_controller.dart';
import 'package:kuesewa/app/modules/chat/controllers/chat_controller.dart';

class HalamanUtamaView extends GetView<HalamanUtamaController> {
  final controller = Get.put(HalamanUtamaController());
  final chatC = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: Get.nestedKey(1),
        initialRoute: '/home',
        onGenerateRoute: controller.onGenerateRoute,
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: controller.currentIndex.value != 0
                  ? Image.asset(
                      "assets/icons/home.png",
                      color: Colors.black,
                      width: 25,
                    )
                  : Image.asset(
                      "assets/icons/homerounded.png",
                      color: Color(0xff0fc7b0),
                    ),
              label: 'home',
            ),
            BottomNavigationBarItem(
              icon: controller.currentIndex.value != 1
                  ? Image.asset(
                      "assets/icons/feed.png",
                      color: Colors.black,
                      width: 22,
                    )
                  : Image.asset(
                      "assets/icons/feed.png",
                      color: Color(0xff0fc7b0),
                      width: 22,
                    ),
              label: 'feed',
            ),
            BottomNavigationBarItem(
              icon: controller.currentIndex.value != 2
                  ? Image.asset(
                      "assets/icons/chatrounded.png",
                      color: Colors.black,
                      width: 22,
                    )
                  : Image.asset(
                      "assets/icons/chatoutliene.png",
                      color: Color(0xff0fc7b0),
                      width: 22,
                    ),
              label: 'chat',
            ),
            BottomNavigationBarItem(
              icon: controller.currentIndex.value != 3
                  ? Image.asset(
                      'assets/icons/struk.png',
                      color: Colors.black,
                      width: 22,
                    )
                  : Image.asset(
                      'assets/icons/struk.png',
                      color: Color(0xff0fc7b0),
                      width: 22,
                    ),
              label: 'transaksi',
            ),
            BottomNavigationBarItem(
              icon:  controller.currentIndex.value != 4
                  ? Image.asset(
                      'assets/icons/useroutline.png',
                      color: Colors.black,
                      width: 22,
                    )
                  : Image.asset(
                      'assets/icons/usereounded.png',
                      color: Color(0xff0fc7b0),
                      width: 22,
                    ),
              label: 'profile',
            ),
          ],
          currentIndex: controller.currentIndex.value,
          selectedItemColor: Color(0xff0fc7b0),
          unselectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          onTap: controller.changePage,
        ),
      ),
    );
  }
}
