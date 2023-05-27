import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandeladrawing/utils/mycolors.dart';
import 'package:mandeladrawing/view/colorpannel/selectmandelas.dart';
import 'package:mandeladrawing/widgets/mybutton.dart';

import '../settings/settingsscreen.dart';

class Plans extends StatelessWidget {
  const Plans({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    double fontSize;
    double title;
    double heading;

    // Adjust the font size based on the screen width
    if (screenWidth < 320) {
      fontSize = 13.0;
      title = 20;
      heading = 20; // Small screen (e.g., iPhone 4S)
    } else if (screenWidth < 375) {
      fontSize = 17.0;
      title = 28;

      heading = 21; // Medium screen (e.g., iPhone 6, 7, 8)
    } else if (screenWidth < 414) {
      fontSize = 19.0;
      title = 32;

      heading = 25; // Large screen (e.g., iPhone 6 Plus, 7 Plus, 8 Plus)
    } else if (screenWidth < 600) {
      fontSize = 21.0;
      title = 36;

      heading = 27; // Large screen (e.g., iPhone 6 Plus, 7 Plus, 8 Plus)
    } else {
      fontSize = 25.0;
      title = 40;

      heading = 30; // Extra large screen or unknown device
    }

    return Scaffold(
      backgroundColor: appbg,
      appBar: AppBar(
        backgroundColor: appbg,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            CupertinoIcons.left_chevron,
            color: Colors.black,
            size: 30,
          ),
        ),
        title: Text(
          "Packages",
          style: TextStyle(fontSize: title, color: appbartitle),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()));
            },
            icon: const Icon(
              Icons.settings,
              color: Colors.black,
              size: 30,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            MyPlanButton(
                lefttitle: "KSH. 2000",
                righttitle: "Enjoy All Mandelas \nfor a Year",
                borderrad: 25,
                onaction: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SelectMandelas(
                                package: 9,
                                money: "2000",
                              )));
                },
                color1: gd2,
                color2: gd1,
                width: MediaQuery.of(context).size.width),
            const SizedBox(
              height: 20,
            ),
            MyPlanButton(
                lefttitle: "KSH. 50",
                righttitle: "for 2 Mandelas",
                borderrad: 25,
                onaction: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SelectMandelas(
                                package: 2,
                                money: "50",
                              )));
                },
                color1: const Color(0xff2c36ba),
                color2: const Color(0xff74bcea),
                width: MediaQuery.of(context).size.width),
            const SizedBox(
              height: 20,
            ),
            MyPlanButton(
                lefttitle: "KSH. 100",
                righttitle: "for 5 Mandelas",
                borderrad: 25,
                onaction: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SelectMandelas(
                                package: 5,
                                money: "100",
                              )));
                },
                color1: const Color(0xffdf6617),
                color2: const Color(0xffebc73d),
                width: MediaQuery.of(context).size.width),
            const SizedBox(
              height: 20,
            ),
            MyPlanButton(
                lefttitle: "KSH. 200",
                righttitle: "for 11 Mandelas",
                borderrad: 25,
                onaction: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SelectMandelas(
                                package: 11,
                                money: "200",
                              )));
                },
                color1: const Color(0xff418fa9),
                color2: const Color(0xff90d0ca),
                width: MediaQuery.of(context).size.width),
            const SizedBox(
              height: 20,
            ),
            MyPlanButton(
                lefttitle: "KSH. 500",
                righttitle: "for 29 Mandelas",
                borderrad: 25,
                onaction: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SelectMandelas(
                                package: 29,
                                money: '',
                              )));
                },
                color1: const Color(0xfff9977c),
                color2: const Color(0xffe55088),
                width: MediaQuery.of(context).size.width),
            const SizedBox(
              height: 20,
            ),
            MyPlanButton(
                lefttitle: "KSH. 1000",
                righttitle: "for 60 Mandelas",
                borderrad: 25,
                onaction: () {},
                color1: const Color(0xffb8d94a),
                color2: const Color(0xff148229),
                width: MediaQuery.of(context).size.width),
            const SizedBox(
              height: 20,
            ),
            MyPlanButton(
                lefttitle: "KSH. 1500",
                righttitle: "for 100 Mandelas",
                borderrad: 25,
                onaction: () {},
                color1: const Color(0xff703eaf),
                color2: const Color(0xff6b7dec),
                width: MediaQuery.of(context).size.width),
          ],
        ),
      ),
    );
  }
}

class MyPlanButton extends StatelessWidget {
  final String lefttitle;
  final String righttitle;
  final double borderrad;
  final VoidCallback onaction;
  final Color color1;
  final Color color2;
  final double width;

  const MyPlanButton(
      {super.key,
      required this.lefttitle,
      required this.righttitle,
      required this.borderrad,
      required this.onaction,
      required this.color1,
      required this.color2,
      required this.width});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    double fontSize;
    double title;
    double heading;

    // Adjust the font size based on the screen width
    if (screenWidth < 320) {
      fontSize = 10.0;
      title = 20;
      heading = 20; // Small screen (e.g., iPhone 4S)
    } else if (screenWidth < 375) {
      fontSize = 13.0;
      title = 28;

      heading = 21; // Medium screen (e.g., iPhone 6, 7, 8)
    } else if (screenWidth < 414) {
      fontSize = 15.0;
      title = 32;

      heading = 25; // Large screen (e.g., iPhone 6 Plus, 7 Plus, 8 Plus)
    } else if (screenWidth < 600) {
      fontSize = 18.0;
      title = 36;

      heading = 27; // Large screen (e.g., iPhone 6 Plus, 7 Plus, 8 Plus)
    } else {
      fontSize = 25.0;
      title = 40;

      heading = 30; // Extra large screen or unknown device
    }

    return InkWell(
      onTap: onaction,
      child: Container(
        height: 60,
        width: width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color1, color2],
            ),
            borderRadius: BorderRadius.circular(borderrad)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  lefttitle,
                  style: TextStyle(
                      fontSize: heading,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  righttitle,
                  style: TextStyle(
                      fontSize: fontSize,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
