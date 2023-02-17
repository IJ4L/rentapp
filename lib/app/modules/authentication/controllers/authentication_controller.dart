import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kuesewa/app/modules/chat/views/chatroom_view.dart';

import '../../../data/usersModel.dart';
import '../../../routes/app_pages.dart';

class AuthenticationController extends GetxController {
  late TextEditingController emailController = TextEditingController();
  late TextEditingController pwController = TextEditingController();
  late TextEditingController usernameController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController phoneC = TextEditingController();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _currentUser;
  UserCredential? userCredential;

  late String emailGoogle = _currentUser!.email;
  late User? user = _firebaseAuth.currentUser;
  var userModel = UserModel().obs;
  var isAuth = false.obs;

  String country = '';
  String name = '';
  String street = '';
  String postalCode = '';

  var lat = 0.1.obs;
  var long = 0.1.obs;

  @override
  void onInit()  {
    emailController = TextEditingController();
    pwController = TextEditingController();
    usernameController = TextEditingController();
    super.onInit();
  }

  Future<void> firstInitialized() async {
    await autoLogin().then(
      (value) {
        if (value) {
          isAuth.value = true;
        }
        print(isAuth.value);
      },
    );
  }

  Future<dynamic> register() async {
    CollectionReference users = _firestore.collection('users');

    await _firebaseAuth.createUserWithEmailAndPassword(
      email: emailController.text,
      password: pwController.text,
    );

    await _firestore.collection('users').doc(emailController.text).set(
      {
        'Uid': user!.uid.toString(),
        'Username': usernameController.text,
        'Email': emailController.text,
        "kota": '-',
        "phoneNumer": '-',
        'PhotoUrl': "https://i.ibb.co/S32HNjD/no-image.jpg",
        'lastSignIn': DateTime.now().toIso8601String(),
      },
    );

    await _firestore
        .collection('users')
        .doc(emailController.text)
        .collection('alamat')
        .doc('utama')
        .set(
      {
        'label': 'k',
        'alamatLengkap': 'k',
        'namaPenerima': 'k',
        'nomerTelepon': 'k',
        'utama': true,
      },
    );

    await users.doc(emailController.text).collection("chats");

    final currUser = await users.doc(emailController.text).get();
    final currUserData = currUser.data() as Map<String, dynamic>;

    userModel(UserModel.fromJson(currUserData));

    userModel.refresh();

    final listChats =
        await users.doc(emailController.text).collection("chats").get();

    if (listChats.docs.length != 0) {
      List<ChatUser> dataListChats = [];
      listChats.docs.forEach(
        (element) {
          var dataDocChat = element.data();
          var dataDocChatId = element.id;
          dataListChats.add(
            ChatUser(
              chatId: dataDocChatId,
              connection: dataDocChat["connection"],
              lastTime: dataDocChat["lastTime"],
              total_unread: dataDocChat["total_unread"],
            ),
          );
        },
      );

      userModel.update(
        (user) {
          user!.chats = dataListChats;
        },
      );
    } else {
      userModel.update(
        (user) {
          user!.chats = [];
        },
      );
    }

    userModel.refresh();

    isAuth.value = true;

    Get.toNamed(Routes.HALAMAN_UTAMA);
  }

  Future<dynamic> loginEmail() async {
    CollectionReference users = _firestore.collection('users');

    await _firebaseAuth.signInWithEmailAndPassword(
      email: emailController.text,
      password: pwController.text,
    );

    await _firestore.collection('users').doc(emailController.text).update(
      {
        'lastSignIn': DateTime.now().toIso8601String(),
      },
    );

    await users.doc(emailController.text).collection("chats");

    final currUser = await users.doc(emailController.text).get();
    final currUserData = currUser.data() as Map<String, dynamic>;

    print(currUserData);

    userModel(UserModel.fromJson(currUserData));

    userModel.refresh();

    final listChats =
        await users.doc(emailController.text).collection("chats").get();

    if (listChats.docs.length != 0) {
      List<ChatUser> dataListChats = [];
      listChats.docs.forEach(
        (element) {
          var dataDocChat = element.data();
          var dataDocChatId = element.id;
          dataListChats.add(
            ChatUser(
              chatId: dataDocChatId,
              connection: dataDocChat["connection"],
              lastTime: dataDocChat["lastTime"],
              total_unread: dataDocChat["total_unread"],
            ),
          );
        },
      );

      userModel.update(
        (user) {
          user!.chats = dataListChats;
        },
      );
    } else {
      userModel.update(
        (user) {
          user!.chats = [];
        },
      );
    }

    userModel.refresh();

    isAuth.value = true;

    Get.toNamed(Routes.HALAMAN_UTAMA);
  }

  Future<bool> autoLogin() async {
    try {
      final isSignIn = await _googleSignIn.isSignedIn();
      if (isSignIn) {
        await _googleSignIn
            .signInSilently()
            .then((value) => _currentUser = value);
        final googleAuth = await _currentUser!.authentication;

        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) => userCredential = value);

        print("USER CREDENTIAL");
        print(userCredential);

        // masukan data ke firebase...
        CollectionReference users = _firestore.collection('users');

        await users.doc(_currentUser!.email).update({
          "lastSignInTime":
              userCredential!.user!.metadata.lastSignInTime!.toIso8601String(),
        });

        final currUser = await users.doc(_currentUser!.email).get();
        final currUserData = currUser.data() as Map<String, dynamic>;

        userModel(UserModel.fromJson(currUserData));

        userModel.refresh();

        final listChats =
            await users.doc(_currentUser!.email).collection("chats").get();

        if (listChats.docs.length != 0) {
          List<ChatUser> dataListChats = [];
          listChats.docs.forEach((element) {
            var dataDocChat = element.data();
            var dataDocChatId = element.id;
            dataListChats.add(ChatUser(
              chatId: dataDocChatId,
              connection: dataDocChat["connection"],
              lastTime: dataDocChat["lastTime"],
              total_unread: dataDocChat["total_unread"],
            ));
          });

          userModel.update((user) {
            user!.chats = dataListChats;
          });
        } else {
          userModel.update((user) {
            user!.chats = [];
          });
        }

        userModel.refresh();

        return true;
      }
      return false;
    } catch (err) {
      return false;
    }
  }

  Future<void> loginGoogle() async {
    try {
      await _googleSignIn.signOut();

      await _googleSignIn.signIn().then((value) => _currentUser = value);

      final isSignIn = await _googleSignIn.isSignedIn();

      if (isSignIn) {
        print("SUDAH BERHASIL LOGIN DENGAN AKUN : ");
        print(_currentUser);

        final googleAuth = await _currentUser!.authentication;

        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) => userCredential = value);

        print("USER CREDENTIAL");
        print(userCredential);
        CollectionReference users = _firestore.collection('users');

        final checkuser = await users.doc(_currentUser!.email).get();

        if (checkuser.data() == null) {
          await users.doc(_currentUser!.email).set(
            {
              "Uid": userCredential!.user!.uid,
              "Username": _currentUser!.displayName,
              "Email": _currentUser!.email,
              "kota": '-',
              "phoneNumer": '-',
              "PhotoUrl": _currentUser!.photoUrl ?? "noimage",
              "lastSignIn": userCredential!.user!.metadata.lastSignInTime!
                  .toIso8601String(),
            },
          );

          await _firestore
              .collection('users')
              .doc(_currentUser!.email)
              .collection('alamat')
              .doc('utama')
              .set(
            {
              'label': 'k',
              'alamatLengkap': 'k',
              'namaPenerima': 'k',
              'nomerTelepon': 'k',
              'utama': true,
            },
          );

          await users.doc(_currentUser!.email).collection("chats");
        } else {
          await users.doc(_currentUser!.email).update(
            {
              "lastSignIn": userCredential!.user!.metadata.lastSignInTime!
                  .toIso8601String(),
            },
          );
        }

        final currUser = await users.doc(_currentUser!.email).get();
        final currUserData = currUser.data() as Map<String, dynamic>;

        userModel(UserModel.fromJson(currUserData));

        userModel.refresh();

        final listChats =
            await users.doc(_currentUser!.email).collection("chats").get();

        if (listChats.docs.length != 0) {
          List<ChatUser> dataListChats = [];
          listChats.docs.forEach(
            (element) {
              var dataDocChat = element.data();
              var dataDocChatId = element.id;
              dataListChats.add(
                ChatUser(
                  chatId: dataDocChatId,
                  connection: dataDocChat["connection"],
                  lastTime: dataDocChat["lastTime"],
                  total_unread: dataDocChat["total_unread"],
                ),
              );
            },
          );

          userModel.update(
            (user) {
              user!.chats = dataListChats;
            },
          );
        } else {
          userModel.update(
            (user) {
              user!.chats = [];
            },
          );
        }

        userModel.refresh();

        isAuth.value = true;

        Get.toNamed(Routes.HALAMAN_UTAMA);
      } else {
        print("TIDAK BERHASIL LOGIN");
      }
    } catch (error) {
      print(error);
    }
  }

  void addNewConnection(String friendEmail, String email) async {
    bool flagNewConnection = false;
    var chat_id;
    String date = DateTime.now().toIso8601String();
    CollectionReference chats = _firestore.collection("chats");
    CollectionReference users = _firestore.collection("users");

    final docChats = await users.doc(email).collection("chats").get();

    if (docChats.docs.length != 0) {
      final checkConnection = await users
          .doc(email)
          .collection("chats")
          .where("connection", isEqualTo: friendEmail)
          .get();

      if (checkConnection.docs.length != 0) {
        flagNewConnection = false;
        chat_id = checkConnection.docs[0].id;
      } else {
        flagNewConnection = true;
      }
    } else {
      flagNewConnection = true;
    }

    if (flagNewConnection) {
      final chatsDocs = await chats.where(
        "connections",
        whereIn: [
          [
            email,
            friendEmail,
          ],
          [
            friendEmail,
            email,
          ],
        ],
      ).get();

      if (chatsDocs.docs.length != 0) {
        final chatDataId = chatsDocs.docs[0].id;
        final chatsData = chatsDocs.docs[0].data() as Map<String, dynamic>;

        await users.doc(email).collection("chats").doc(chatDataId).set({
          "connection": friendEmail,
          "lastTime": chatsData["lastTime"],
          "total_unread": 0,
        });

        final listChats = await users.doc(email).collection("chats").get();

        if (listChats.docs.length != 0) {
          List<ChatUser> dataListChats = [];
          listChats.docs.forEach((element) {
            var dataDocChat = element.data();
            var dataDocChatId = element.id;
            dataListChats.add(ChatUser(
              chatId: dataDocChatId,
              connection: dataDocChat["connection"],
              lastTime: dataDocChat["lastTime"],
              total_unread: dataDocChat["total_unread"],
            ));
          });
          userModel.update((user) {
            user!.chats = dataListChats;
          });
        } else {
          userModel.update((user) {
            user!.chats = [];
          });
        }

        chat_id = chatDataId;

        userModel.refresh();
      } else {
        final newChatDoc = await chats.add({
          "connections": [
            email,
            friendEmail,
          ],
        });

        await chats.doc(newChatDoc.id).collection("chat");

        await users.doc(email).collection("chats").doc(newChatDoc.id).set({
          "connection": friendEmail,
          "lastTime": date,
          "total_unread": 0,
        });

        final listChats = await users.doc(email).collection("chats").get();

        if (listChats.docs.length != 0) {
          List<ChatUser> dataListChats = [];
          listChats.docs.forEach((element) {
            var dataDocChat = element.data();
            var dataDocChatId = element.id;
            dataListChats.add(ChatUser(
              chatId: dataDocChatId,
              connection: dataDocChat["connection"],
              lastTime: dataDocChat["lastTime"],
              total_unread: dataDocChat["total_unread"],
            ));
          });
          userModel.update((user) {
            user!.chats = dataListChats;
          });
        } else {
          userModel.update((user) {
            user!.chats = [];
          });
        }

        chat_id = newChatDoc.id;

        userModel.refresh();
      }
    }

    print(chat_id);
    print(friendEmail);

    final updateStatusChat = await chats
        .doc(chat_id)
        .collection("chat")
        .where("isRead", isEqualTo: false)
        .where("penerima", isEqualTo: email)
        .get();

    updateStatusChat.docs.forEach((element) async {
      await chats
          .doc(chat_id)
          .collection("chat")
          .doc(element.id)
          .update({"isRead": true});
    });

    await users
        .doc(email)
        .collection("chats")
        .doc(chat_id)
        .update({"total_unread": 0});

    Get.to(
      chatroom(),
      arguments: {
        "chat_id": "$chat_id",
        "friendEmail": friendEmail,
      },
    );
  }
}
