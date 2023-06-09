// ignore_for_file: prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, prefer_const_constructors, curly_braces_in_flow_control_structures, unused_import, duplicate_import

import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mandeladrawing/controllers/profilecontroller.dart';
import 'package:mandeladrawing/methods/authmodels.dart';
import 'package:mandeladrawing/view/authview/login.dart';
import 'package:mandeladrawing/widgets/mybutton.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../models/usermodel.dart';
import '../../utils/mycolors.dart';
import '../dashboard.dart';
import 'editprofile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileView extends StatefulWidget {
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  signOut() async {
    print('object');
    await auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  final userId = FirebaseAuth.instance.currentUser!.uid;
  int check = 0;
  String name = "loading....";
  String email = "loading....";
  String phone = 'loading....';

  void getInfo() async {
    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collection.doc(userId).get();
    if (docSnapshot.exists) {
      print("ok");
      Map<String, dynamic>? data = docSnapshot.data();
      setState(() {
        name = data?["First Name"];
        email = data?["Email"];
        //phone = data?["Phone"];
      });
    }
    print(userId);
  }

  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (check == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) => getInfo());
      check++;
    }
    // final controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: appbar,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appbar,
        leading: IconButton(
            onPressed: () {
              Get.to(() => Home(
                  //  selectedImagesList: [],
                  ));
            },
            icon: Icon(
              CupertinoIcons.left_chevron,
              color: Colors.black,
            )),
        title: Text(
          name,
          style: TextStyle(fontSize: 26, color: appbartitle),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: IconButton(
                onPressed: () {
                  Get.to(() => Settings());
                },
                icon: Icon(
                  CupertinoIcons.left_chevron,
                  color: Colors.black,
                )),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            Center(
              child: Stack(children: [
                const CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage('assets/dp.jpg'),
                ),
              ]),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 1 / 40,
            ),
            Center(
              child: Text(
                name,
                //                   user!.email,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 1 / 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(children: [
                Container(
                    height: MediaQuery.of(context).size.height / 14,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: appbg, borderRadius: BorderRadius.circular(50)),
                    child: ListTile(
                      leading: Icon(Icons.mark_email_read_sharp),
                      title: Text(
                        email,
                        style: TextStyle(fontSize: 14),
                      ),
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 50,
                ),
                Container(
                    height: MediaQuery.of(context).size.height / 14,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: appbg, borderRadius: BorderRadius.circular(50)),
                    child: ListTile(
                      leading: Icon(Icons.phone_callback_sharp),
                      title: Text(
                        phone,
                        style: TextStyle(fontSize: 14),
                      ),
                    )),
              ]),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            MyCustomButton(
                title: "Edit Profile",
                borderrad: 50,
                onaction: () {
                  Get.to(() => EditProfile());
                },
                color1: gd2,
                color2: gd1,
                width: MediaQuery.of(context).size.width - 40),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                signOut();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        //signOut();
                      },
                      icon: Icon(
                        Icons.logout_rounded,
                        color: red,
                        size: 40,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Log out",
                    style: TextStyle(
                        color: red, fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}
