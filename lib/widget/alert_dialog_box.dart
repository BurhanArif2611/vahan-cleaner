
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';
import '../utils/font_family.dart';

Future confirmationDialog({required BuildContext context, required void Function()? onPressedYes, required String contentText, required String titleText}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(
          child: Text(
            titleText,
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: FontFamily.fontFamily,
            ),
          ),
        ),
        content: Text(
          contentText,
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w400,
            fontSize: 12,
            fontFamily: FontFamily.fontFamily,
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'NO',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    fontFamily: FontFamily.fontFamily,
                  ),
                ),
              ),
              Container(
                height: 30,
                width: 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColor.neutral_500,
                ),
              ),
              TextButton(
                onPressed: onPressedYes,
                child: Text(
                  'YES',
                  style: TextStyle(
                    color: buttoncolor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    fontFamily: FontFamily.fontFamily,
                  ),
                ),
              ),
            ],
          )
        ],
      );
    },
  );
}

Future warningDialog({required BuildContext context, required void Function()? onPressedYes, required String contentText, required String titleText}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(
          child: Text(
            titleText,
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: FontFamily.fontFamily,
            ),
          ),
        ),
        content: Text(
          contentText,
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w400,
            fontSize: 12,
            fontFamily: FontFamily.fontFamily,
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: onPressedYes,
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: buttoncolor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    fontFamily: FontFamily.fontFamily,
                  ),
                ),
              ),
            ],
          )
        ],
      );
    },
  );
}

