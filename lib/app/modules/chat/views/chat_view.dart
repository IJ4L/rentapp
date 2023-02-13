import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kuesewa/app/modules/NavigationBar/controllers/halaman_utama_controller.dart';
import 'package:kuesewa/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';

import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  final navbarc = Get.put(HalamanUtamaController());
  final authC = Get.find<AuthenticationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              'Message',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(
                height: Get.width * 0.035,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: controller
                        .chatsStream(authC.userModel.value.email.toString()),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        var listDocsChats = snapshot.data?.docs;
                        return ListView.separated(
                          itemBuilder: (context, index) {
                            listDocsChats != 0
                                ? navbarc.notif.value = true
                                : navbarc.notif.value = false;
                            return StreamBuilder<
                                DocumentSnapshot<Map<String, dynamic>>>(
                              stream: controller.friendStream(
                                listDocsChats![index]["connection"],
                              ),
                              builder: (context, snapshot2) {
                                if (snapshot2.connectionState ==
                                    ConnectionState.active) {
                                  var data = snapshot2.data!.data();
                                  return GestureDetector(
                                    onTap: () => controller.goToChatRoom(
                                      "${listDocsChats[index].id}",
                                      authC.userModel.value.email!,
                                      listDocsChats[index]["connection"],
                                    ),
                                    child: Container(
                                      height: Get.width * 0.22,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Color(0xffe5ecf7),
                                        ),
                                      ),
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(35),
                                            child: Image.network(
                                              data!['PhotoUrl'],
                                              width: 60.0,
                                              height: 60.0,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15.0,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data['Username'],
                                                style:
                                                    GoogleFonts.plusJakartaSans(
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10.0,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    width: Get.width * 0.45,
                                                    child: Text(
                                                      listDocsChats[index]
                                                          ['lastChat'],
                                                      style: GoogleFonts
                                                          .plusJakartaSans(),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    DateFormat.jm().format(
                                                      DateTime.parse(
                                                        listDocsChats[index]
                                                            ['lastTime'],
                                                      ),
                                                    ),
                                                    style: GoogleFonts
                                                        .plusJakartaSans(
                                                      color: Colors.black,
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          Expanded(child: SizedBox()),
                                          SizedBox(
                                            child: listDocsChats[index]
                                                        ["total_unread"] !=
                                                    0
                                                ? Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        20 / 2,
                                                      ),
                                                      gradient:
                                                          const LinearGradient(
                                                        begin:
                                                            Alignment.topRight,
                                                        end: Alignment
                                                            .bottomLeft,
                                                        colors: [
                                                          Color(0xff2ad88f),
                                                          Color(0xff0fc7b0),
                                                        ],
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        listDocsChats[index]
                                                                ["total_unread"]
                                                            .toString(),
                                                        style: GoogleFonts
                                                            .plusJakartaSans(
                                                          color: Colors.white,
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : SizedBox(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                return Shimmer.fromColors(
                                  child: Container(
                                    height: Get.width * 0.22,
                                    width: double.infinity,
                                  ),
                                  period: Duration(seconds: 2),
                                  baseColor: Colors.black.withOpacity(0.1),
                                  highlightColor: Colors.black.withOpacity(0.5),
                                );
                              },
                            );
                          },
                          separatorBuilder: (_, index) => SizedBox(
                            height: 5,
                          ),
                          itemCount: listDocsChats!.length,
                        );
                      }
                      return Shimmer.fromColors(
                        child: Container(
                          height: Get.width * 0.22,
                          width: double.infinity,
                        ),
                        period: Duration(seconds: 2),
                        baseColor: Colors.black,
                        highlightColor: Colors.black.withOpacity(0.5),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
