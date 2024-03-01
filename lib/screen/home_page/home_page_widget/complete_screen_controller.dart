import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../get_controller_builder.dart';
import '../../../models/view_completed_subscription_response.dart';
import '../../../shared_preferences/local_data.dart';
import '../../../utils/apis.dart';
import '../../../utils/snackbar.dart';

class CompleteScreenController extends GetxController {

  TextEditingController searchController = TextEditingController();
  var isLoading = false.obs;
  DateTime now = DateTime.now();

  List<CompleteVahan>? completeVahans;
  String? imageBaseUrl;
  Stats? stats;
  int? balance;
  int? todaysEarning;
  File? pickedImage;

  @override
  void onInit() async {
    super.onInit();
    await getCompletedVahanData();
  }

  /// Refresh page.
  Future<void> pullRefresh() async {
    await getCompletedVahanData();
  }

  /// Method use to get pending vehicles brands response.
  Future<void> getCompletedVahanData() async {
    isLoading(true);
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    try {
      final response = await http.get(Uri.parse("${Apis.baseUrl}${Apis.getCompletedCleaner}${GetSfLocalStorage.getAuthToken()}&date=$formattedDate"));
      ViewCompletedSubscriptionResponse vahansLIst = viewCompletedSubscriptionResponseFromJson(response.body);
      if (response.statusCode == 200) {
        if (vahansLIst.status ?? false) {
          completeVahans = vahansLIst.completeVahans;
          imageBaseUrl = vahansLIst.baseurl ?? "";
          stats = vahansLIst.stats;
          balance = stats?.balance;
          todaysEarning = stats?.todaysEarning;
          printApiResponse(url: (Uri.parse("${Apis.baseUrl}${Apis.getCompletedCleaner}${GetSfLocalStorage.getAuthToken()}&date=$formattedDate").toString()), response: response.body, statusCode: response.statusCode.toString());
        }
      } else {
        printApiResponse(url: (Uri.parse("${Apis.baseUrl}${Apis.getCompletedCleaner}${GetSfLocalStorage.getAuthToken()}&date=$formattedDate").toString()), response: response.body, statusCode: response.statusCode.toString());
        setSnackBar("Failed to load data. Status code: ${response.statusCode}", Get.context, vahansLIst.status ?? false);
      }
    } catch (e) {
      printCatchError(url: (Uri.parse("${Apis.baseUrl}${Apis.getCompletedCleaner}${GetSfLocalStorage.getAuthToken()}&date=$formattedDate").toString()), error: e.toString());
    }
    isLoading(false);
    update([GetXControllerBuilders.completedScreenController]);
  }
}