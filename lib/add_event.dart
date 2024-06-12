import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddEventOverlay extends StatefulWidget {
  const AddEventOverlay({super.key});

  AddEventOverlayState createState() => AddEventOverlayState();
}

class AddEventOverlayState extends State<AddEventOverlay> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: SmoothBorderRadius(
          cornerRadius: 25,
          cornerSmoothing: 0.6,
        ),
      ),
      insetPadding: const EdgeInsets.all(10),
      child: Container(
        width: 0.9.sw,
        height: 0.9.sh,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
