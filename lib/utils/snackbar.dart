import 'package:flutter/material.dart';

import 'colors.dart';

setSnackBar(String msg, context, bool status) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        msg,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      duration: const Duration(
        seconds: 4,
      ),
      backgroundColor: status ? AppColor.green : AppColor.red,
      elevation: 1.0,
    ),
  );
}
