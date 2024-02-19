import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/colors.dart';

class CustomAppBar extends StatefulWidget {
bool isBack;
  CustomAppBar({required this.isBack, Key? key}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Container(
              child: Image.asset(
                'Assets/Images/vahanlogo1.png',
                color: AppColor.neutral_100,
                scale: 5,
              ),
            ),
          ),
        ],
      ),
      leading: widget.isBack ? GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Container(
          height: 17,
          width: 17,
          margin: EdgeInsets.only(left: 16, top: 16),
          decoration: BoxDecoration(
            color: AppColor.neutral_100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(child: Icon(Icons.arrow_back, color: AppColor.neutral_700,)),
        ),
      ) : null,
      backgroundColor: primaryColor,
    );
  }
}