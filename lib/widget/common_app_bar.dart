import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vahan_cleaner/shared_preferences/local_data.dart';
import '../app_routes/app_routes.dart';
import '../utils/colors.dart';
import '../utils/font_family.dart';
import '../utils/snackbar.dart';

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
            child: Image.asset(
              'Assets/Images/vahanlogo1.png',
              color: AppColor.neutral_100,
              scale: 5,
            ),
          ),
        ],
      ),
      leading: widget.isBack ? GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Container(
          height: 40,
          width: 40,
          margin: const EdgeInsets.only(left: 16, top: 16),
          decoration: BoxDecoration(
            color: AppColor.neutral_100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(child: Icon(Icons.arrow_back, color: AppColor.neutral_700,)),
        ),
      ) : null,
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.only(right: 16, top: 16),
            decoration: BoxDecoration(
              color: AppColor.neutral_100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(child: Icon(Icons.search_outlined, color: AppColor.neutral_700,)),
          ),
        ),
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Center(
                    child: Text('Confirmation',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        fontFamily: FontFamily.fontFamily,
                      ),
                    ),
                  ),
                  content: Text('Are you sure you want to log out?',
                    style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    fontFamily: FontFamily.fontFamily,
                  ),
                                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text('Cancel',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          fontFamily: FontFamily.fontFamily,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        GetSfLocalStorage.clear();
                        setSnackBar("Logout Successfully", context, true);
                        Get.offAllNamed(AppRoutes.loginPage);
                      },
                      child: Text('OK',
                        style: TextStyle(
                          color: buttoncolor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          fontFamily: FontFamily.fontFamily,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          child: Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.only(right: 16, top: 16),
            decoration: BoxDecoration(
              color: AppColor.neutral_100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(child: Icon(Icons.logout_outlined, color: AppColor.neutral_700,)),
          ),
        )
      ],
      backgroundColor: primaryColor,

    );
  }
}