import 'package:get/get.dart';

import 'package:kuesewa/app/modules/authentication/bindings/authentication_binding.dart';
import 'package:kuesewa/app/modules/authentication/views/authentication_view.dart';
import 'package:kuesewa/app/modules/chat/views/chatroom_view.dart';
import 'package:kuesewa/app/modules/detailProduk/bindings/detail_produk_binding.dart';
import 'package:kuesewa/app/modules/detailProduk/views/alamat_view.dart';
import 'package:kuesewa/app/modules/detailProduk/views/detail_produk_view.dart';
import 'package:kuesewa/app/modules/detailProduk/views/pembayaran_view.dart';
import 'package:kuesewa/app/modules/detailProduk/views/tambahAlamat_view.dart';
import 'package:kuesewa/app/modules/feed/bindings/feed_binding.dart';
import 'package:kuesewa/app/modules/feed/views/merchantProfile_view.dart';
import 'package:kuesewa/app/modules/home/bindings/home_binding.dart';
import 'package:kuesewa/app/modules/home/views/bayar_view.dart';
import 'package:kuesewa/app/modules/home/views/cart_view.dart';
import 'package:kuesewa/app/modules/myshop/bindings/myshop_binding.dart';
import 'package:kuesewa/app/modules/myshop/views/addproduct_view.dart';
import 'package:kuesewa/app/modules/myshop/views/daftarproduk.dart';
import 'package:kuesewa/app/modules/myshop/views/myshop_view.dart';
import 'package:kuesewa/app/modules/myshop/views/pesanan_view.dart';
import 'package:kuesewa/app/modules/myshop/views/riwayat_view.dart';
import 'package:kuesewa/app/modules/profile/views/editProfile.dart';
import 'package:kuesewa/app/modules/search/view/search_view.dart';

import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/NavigationBar/bindings/halaman_utama_binding.dart';
import '../modules/NavigationBar/views/halaman_utama_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/search/bindings/serach_bindings.dart';
import '../modules/tranksaksi/bindings/tranksaksi_binding.dart';
import '../modules/tranksaksi/views/tranksaksi_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.AUTHENTICATION;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HalamanUtamaBinding(),
    ),
    GetPage(
      name: _Paths.HALAMAN_UTAMA,
      page: () => HalamanUtamaView(),
      binding: HalamanUtamaBinding(),
    ),
    GetPage(
      name: _Paths.TRANKSAKSI,
      page: () => TranksaksiView(),
      binding: TranksaksiBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PRODUK,
      page: () => DetailProdukView(),
      binding: DetailProdukBinding(),
    ),
    GetPage(
      name: _Paths.AUTHENTICATION,
      page: () => Authentication(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => searchview(),
      binding: Searchbindings(),
    ),
    GetPage(
      name: _Paths.CHATROOM,
      page: () => chatroom(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.EDITPROFILE,
      page: () => editProfile(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.MYSHOP,
      page: () => Myshop(),
      binding: Myshopbinding(),
    ),
    GetPage(
      name: _Paths.ADDPRODUCT,
      page: () => Addproduct(),
      binding: Myshopbinding(),
    ),
    GetPage(
      name: _Paths.DAFTARPRODUK,
      page: () => Daftarproduk(),
      binding: Myshopbinding(),
    ),
    GetPage(
      name: _Paths.PEMBAYARAN,
      page: () => Pembayaranview(),
      binding: DetailProdukBinding(),
    ),
    GetPage(
      name: _Paths.ALAMAT,
      page: () => Alamatview(),
      binding: DetailProdukBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAHALAMAT,
      page: () => Tambahalamatview(),
      binding: DetailProdukBinding(),
    ),
    GetPage(
      name: _Paths.PESANAN,
      page: () => Pesanan(),
      binding: Myshopbinding(),
    ),
    GetPage(
      name: _Paths.RIWAYAT,
      page: () => Riwayatview(),
      binding: Myshopbinding(),
    ),
    GetPage(
      name: _Paths.MERCHANTPROFILE,
      page: () => MerchantProfile(),
      binding: FeedBinding(),
    ),
    GetPage(
      name: _Paths.BAYARCART,
      page: () => Bayar(),
      binding: DetailProdukBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => Cartview(),
      binding: HomeBinding(),
    )
  ];
}
