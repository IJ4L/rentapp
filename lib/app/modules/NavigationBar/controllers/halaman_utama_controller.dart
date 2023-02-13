import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuesewa/app/modules/chat/bindings/chat_binding.dart';
import 'package:kuesewa/app/modules/chat/views/chat_view.dart';
import 'package:kuesewa/app/modules/feed/bindings/feed_binding.dart';
import 'package:kuesewa/app/modules/feed/views/feed_view.dart';
import 'package:kuesewa/app/modules/home/bindings/home_binding.dart';
import 'package:kuesewa/app/modules/home/views/home_view.dart';
import 'package:kuesewa/app/modules/profile/bindings/profile_binding.dart';
import 'package:kuesewa/app/modules/profile/views/profile_view.dart';
import 'package:kuesewa/app/modules/tranksaksi/bindings/tranksaksi_binding.dart';
import 'package:kuesewa/app/modules/tranksaksi/views/tranksaksi_view.dart';

import '../../home/controllers/home_controller.dart';

class HalamanUtamaController extends GetxController {

  var notif = false.obs;

  click(int index) {
    currentIndex.value = index;
  }

  List<String> image = [
    'assets/icons/home.png',
    'assets/icons/feed.png',
    'assets/icons/chatrounded.png',
    'assets/icons/favorite.png',
    'assets/icons/useroutline.png',
  ];

  List<String> image2 = [
    'assets/icons/homerounded.png',
    'assets/icons/feed.png',
    'assets/icons/chatoutliene.png',
    'assets/icons/struk.png',
    'assets/icons/usereounded.png',
  ];

  static HomeController get to => Get.find();

  var currentIndex = 0.obs;

  final pages = <String>['/home', '/feed', '/chat', '/transaksi', '/profile'];

  void changePage(int index) {
    currentIndex.value = index;
    Get.toNamed(pages[index], id: 1);
  }

  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/home')
      return GetPageRoute(
        settings: settings,
        page: () => HomeView(),
        binding: HomeBinding(),
      );

    if (settings.name == '/feed')
      return GetPageRoute(
        settings: settings,
        page: () => FeedView(),
        binding: FeedBinding(),
      );

    if (settings.name == '/chat')
      return GetPageRoute(
        settings: settings,
        page: () => ChatView(),
        binding: ChatBinding(),
      );

    if (settings.name == '/transaksi')
      return GetPageRoute(
        settings: settings,
        page: () => TranksaksiView(),
        binding: TranksaksiBinding(),
      );

    if (settings.name == '/profile')
      return GetPageRoute(
        settings: settings,
        page: () => ProfileView(),
        binding: ProfileBinding(),
      );

    return null;
  }
}
