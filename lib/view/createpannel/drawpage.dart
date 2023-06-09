// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart' hide Image;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:mandeladrawing/widgets/drawcanvas.dart';

import '../../models/drawingmode.dart';
import '../../models/sketch.dart';
import '../../models/sketchmodel.dart';
import '../../utils/mycolors.dart';
import '../../widgets/canvassidedar.dart';
import '../../widgets/create.dart';
import '../../widgets/drawingboardcanvas.dart';
import '../settings/settingsscreen.dart';
import 'package:path/path.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class DrawingPage extends HookWidget {
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
      fontSize = 15.0;
      title = 28;

      heading = 21; // Medium screen (e.g., iPhone 6, 7, 8)
    } else if (screenWidth < 414) {
      fontSize = 17.0;
      title = 32;

      heading = 25; // Large screen (e.g., iPhone 6 Plus, 7 Plus, 8 Plus)
    } else if (screenWidth < 600) {
      fontSize = 19.0;
      title = 36;

      heading = 27; // Large screen (e.g., iPhone 6 Plus, 7 Plus, 8 Plus)
    } else {
      fontSize = 22.0;
      title = 40;

      heading = 30; // Extra large screen or unknown device
    }

    final sliderValue = useState(200.0);
    void updateSlider(double value) {
      sliderValue.value = value;
    }

    final selectedColor = useState(Colors.black);
    final strokeSize = useState<double>(1);
    final eraserSize = useState<double>(30);
    final drawingMode = useState(DrawingMode.pencil);
    final filled = useState<bool>(false);
    final polygonSides = useState<int>(3);
    final backgroundImage = useState<Image?>(null);

    final canvasGlobalKey = GlobalKey();
    ValueNotifier<Sketch?> currentSketch = useState(null);
    ValueNotifier<List<Sketch>> allSketches = useState([]);

    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 150),
      initialValue: 1,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Animal Mandela",
          style: TextStyle(fontSize: title, color: Colors.black),
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 1 / 10,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.turn_left,
            color: Colors.black,
            size: 30,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: GestureDetector(
              onTap: () {
                Get.to(() => SettingsScreen());
              },
              child: Icon(
                Icons.settings,
                size: 30,
                color: Colors.black,
              ),
            ),
          )
        ],
        backgroundColor: appbg,
        elevation: 0,
      ),
      backgroundColor: kCanvasColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: screenheight / 12,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: const [gd2, gd1],
              ),
            ),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Get All Pictures!",
                    style: TextStyle(
                        color: appbg,
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Try Premium",
                    style: TextStyle(
                        color: appbg,
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
          Stack(children: [
            Container(
              decoration: BoxDecoration(
                  //color: Colors.red,

                  //  image: DecorationImage(image: AssetImage(sketch.url))),
                  ),
              width: MediaQuery.of(context).size.width - 30,
              height: MediaQuery.of(context).size.height / 2.6,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: kCanvasColor,
                      border:
                          Border.all(color: Colors.grey.shade200, width: 1)),
                  width: sliderValue.value,
                  height: sliderValue.value,
                  child: Center(
                    child: DrawingBoardCanvas(
                      width: 300,
                      height: 300,
                      drawingMode: drawingMode,
                      selectedColor: selectedColor,
                      strokeSize: strokeSize,
                      eraserSize: eraserSize,
                      sideBarController: animationController,
                      currentSketch: currentSketch,
                      allSketches: allSketches,
                      canvasGlobalKey: canvasGlobalKey,
                      filled: filled,
                      polygonSides: polygonSides,
                      backgroundImage: backgroundImage,
                    ),
                  ),
                ),

                // Positioned(
                //   top: kToolbarHeight + 10,
                //   // left: -5,
                //   child: SlideTransition(
                //     position: Tween<Offset>(
                //       begin: const Offset(-1, 0),
                //       end: Offset.zero,
                //     ).animate(animationController),
                //     child: CanvasSideBar(
                //       drawingMode: drawingMode,
                //       selectedColor: selectedColor,
                //       strokeSize: strokeSize,
                //       eraserSize: eraserSize,
                //       currentSketch: currentSketch,
                //       allSketches: allSketches,
                //       canvasGlobalKey: canvasGlobalKey,
                //       filled: filled,
                //       polygonSides: polygonSides,
                //       backgroundImage: backgroundImage,
                //     ),
                //   ),
                // ),
                // _CustomAppBar(animationController: animationController),
              ),
            ),
          ]),
          Container(
            color: Colors.white,
            height: 150,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    height: 50,
                    child: Slider(
                      label: sliderValue.toString(),
                      value: sliderValue.value,
                      min: 200,
                      max: 1000,
                      onChanged: updateSlider,
                    ),
                  ),
                ),
                Center(child: Text("Adjust the Drawing board Size")),
                Expanded(
                  child: MyDrawing(
                      selectedColor: selectedColor,
                      strokeSize: strokeSize,
                      eraserSize: eraserSize,
                      drawingMode: drawingMode,
                      currentSketch: currentSketch,
                      allSketches: allSketches,
                      canvasGlobalKey: canvasGlobalKey,
                      filled: filled,
                      polygonSides: polygonSides,
                      backgroundImage: backgroundImage),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
