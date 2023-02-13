import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kuesewa/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:kuesewa/app/modules/chat/controllers/chat_controller.dart';
import 'package:intl/intl.dart';

class chatroom extends GetView<ChatController> {
  final controller = Get.put(ChatController());
  final authC = Get.put(AuthenticationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
        ),
        title: StreamBuilder<DocumentSnapshot<Object?>>(
          stream: controller.streamFriendData(
              (Get.arguments as Map<String, dynamic>)["friendEmail"]),
          builder: (context, snapFriendUser) {
            if (snapFriendUser.connectionState == ConnectionState.active) {
              var dataFriend =
                  snapFriendUser.data!.data() as Map<String, dynamic>;
              return Text(
                dataFriend["Username"],
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(26),
                  bottomRight: Radius.circular(26),
                ),
              ),
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: controller.streamChats(
                    (Get.arguments as Map<String, dynamic>)["chat_id"]
                        .toString()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    var alldata = snapshot.data!.docs;
                    Timer(
                      Duration.zero,
                      () => controller.scrollC
                          .jumpTo(controller.scrollC.position.maxScrollExtent),
                    );
                    return ListView.builder(
                      controller: controller.scrollC,
                      itemCount: alldata.length,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Column(
                            children: [
                              SizedBox(height: 10),
                              Text(
                                "${alldata[index]["groupTime"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              ItemChat(
                                msg: "${alldata[index]["msg"]}",
                                isSender: alldata[index]["pengirim"] ==
                                        authC.userModel.value.email!
                                    ? true
                                    : false,
                                time: "${alldata[index]["time"]}",
                              ),
                            ],
                          );
                        } else {
                          if (alldata[index]["groupTime"] ==
                              alldata[index - 1]["groupTime"]) {
                            return ItemChat(
                              msg: "${alldata[index]["msg"]}",
                              isSender: alldata[index]["pengirim"] ==
                                      authC.userModel.value.email!
                                  ? true
                                  : false,
                              time: "${alldata[index]["time"]}",
                            );
                          } else {
                            return Column(
                              children: [
                                const SizedBox(
                                  height: 15.0,
                                ),
                                Text(
                                  "${alldata[index]["groupTime"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                ItemChat(
                                  msg: "${alldata[index]["msg"]}",
                                  isSender: alldata[index]["pengirim"] ==
                                          authC.userModel.value.email!
                                      ? true
                                      : false,
                                  time: "${alldata[index]["time"]}",
                                ),
                              ],
                            );
                          }
                        }
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    autocorrect: false,
                    controller: controller.chatC,
                    focusNode: controller.focusNode,
                    onEditingComplete: () => controller.newChat(
                      authC.userModel.value.email!,
                      Get.arguments as Map<String, dynamic>,
                      controller.chatC.text,
                    ),
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      fillColor: Colors.black.withOpacity(0.02),
                      filled: true,
                      hintText: 'Masukkan pesan',
                      hintStyle: GoogleFonts.plusJakartaSans(
                        color: Colors.black.withOpacity(0.4),
                        fontWeight: FontWeight.w500,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff0fc7b0),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  height: Get.width * 0.14,
                  width: Get.width * 0.14,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Get.width * 0.14 / 2),
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xff2ad88f),
                        Color(0xff0fc7b0),
                      ],
                    ),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () => controller.newChat(
                      authC.userModel.value.email!,
                      Get.arguments as Map<String, dynamic>,
                      controller.chatC.text,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: Get.width * 0.01),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ItemChat extends StatelessWidget {
  const ItemChat({
    Key? key,
    required this.isSender,
    required this.msg,
    required this.time,
  }) : super(key: key);

  final bool isSender;
  final String msg;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          isSender
              ? Container()
              : Text(
                  DateFormat.jm().format(
                    DateTime.parse(time),
                  ),
                  style: GoogleFonts.roboto(color: Colors.black, fontSize: 10),
                ),
          SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
              color:
                  isSender ? Color(0xff0fc7b0) : Colors.black.withOpacity(0.03),
              gradient: isSender
                  ? const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xff2ad88f),
                        Color(0xff0fc7b0),
                      ],
                    )
                  : LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.black,
                        Colors.black,
                      ],
                    ),
              borderRadius: isSender
                  ? BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    )
                  : BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
            ),
            padding: EdgeInsets.all(15),
            child: Text(
              "$msg",
              style: GoogleFonts.roboto(
                color: isSender ? Colors.white : Colors.black,
              ),
            ),
          ),
          SizedBox(height: 5),
          isSender
              ? Text(
                  DateFormat.jm().format(
                    DateTime.parse(time),
                  ),
                  style: GoogleFonts.roboto(color: Colors.black, fontSize: 10),
                )
              : Container(),
        ],
      ),
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
    );
  }
}
