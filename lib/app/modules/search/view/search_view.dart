import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kuesewa/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:kuesewa/app/modules/search/controller/searchcontroller.dart';
import 'package:kuesewa/app/routes/app_pages.dart';

class searchview extends GetView<searchcotroller> {
  final controller = Get.put(searchcotroller());
  final authC = Get.put(AuthenticationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 15.0,
              ),
              TextField(
                onChanged: (value) => controller.onCari(value),
                cursorColor: Color(0xff0fc7b0),
                decoration: InputDecoration(
                  hintText: 'Pencarian',
                  hintStyle: GoogleFonts.roboto(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.2),
                  ),
                  prefixIcon: Icon(Icons.search_rounded),
                  prefixIconColor: Color(0xff0fc7b0),
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
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('produk')
                      .snapshots(),
                  builder: (context, snapshots) {
                    return (snapshots.connectionState ==
                            ConnectionState.waiting)
                        ? Center(child: CircularProgressIndicator())
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                'Produk',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: GetBuilder<searchcotroller>(
                                  init: searchcotroller(),
                                  builder: (controller) => ListView.builder(
                                    itemCount: snapshots.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      var data = snapshots.data!.docs;

                                      if (controller.name.value == '') {
                                        return GestureDetector(
                                          onTap: () => Get.toNamed(
                                            Routes.DETAIL_PRODUK,
                                            arguments: [
                                              data,
                                              index.toInt(),
                                            ],
                                          ),
                                          child: ListTile(
                                            title: Text(
                                              data[index]['NamaProduk'],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            subtitle: Text(
                                              data[index]['UsernameBy']
                                                  .toString(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            leading: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                data[index]['Img'],
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      if (data[index]['NamaProduk']
                                          .toString()
                                          .toLowerCase()
                                          .startsWith(
                                            controller.name.value,
                                          )) {
                                        return ListTile(
                                          title: Text(
                                            data[index]['NamaProduk']
                                                .toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          subtitle: Text(
                                            data[index]['UsernameBy']
                                                .toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          leading: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              data[index]['Img'].toString(),
                                            ),
                                          ),
                                        );
                                      }
                                      return Container();
                                    },
                                  ),
                                ),
                              ),
                            ],
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
