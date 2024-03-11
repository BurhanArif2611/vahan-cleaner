import 'dart:async';

import 'package:get/get.dart';

import '../../../../get_controller_builder.dart';

class DashBoardScreenController extends GetxController{
  bool isMark = false;
  var isLoading = false.obs;

  /// method use to refresh the page.
  pullRefresh() async {
    await getDashBoardData();
  }

  clockIn() {
    isMark = !isMark;
    update([GetXControllerBuilders.dashBoardScreenController]);
  }

  /// Method use to get the dashboard data.
  getDashBoardData() {
    isLoading(true);
    Future.delayed(Duration(seconds: 2));
    isLoading(false);
  }
}