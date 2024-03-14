import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../../get_controller_builder.dart';
import '../../../../models/view_completed_subscription_response.dart';
import '../../../../shared_preferences/local_data.dart';
import '../../../../utils/apis.dart';
import '../../../../utils/snackbar.dart';

class CompleteSubscriptionController extends GetxController {

  TextEditingController searchController = TextEditingController();
  var isLoading = false.obs;
  DateTime now = DateTime.now();

  List<CompleteVahan>? completeVahans;
  List<CompleteVahan> filteredCompleteVahans = [];
  String? imageBaseUrl;
  Stats? stats;
  int? balance;
  int? todaysEarning;
  File? pickedImage;

  @override
  void onInit() async {
    await getCompletedVahanData();
    super.onInit();
  }

  /// Refresh page.
  Future<void> pullRefresh() async {
    await getCompletedVahanData();
  }

  /// Method use to filter the data by search bar.
  void filterCompleteVahanList(String query) {
    try {
      filteredCompleteVahans = [];
      completeVahans?.forEach((item) {
        if ((item.regNumber ?? "").toLowerCase().contains(query.toLowerCase()) ||
            (item.parkingLocation ?? "").toLowerCase().contains(query.toLowerCase()) ||
            (item.name ?? "").toLowerCase().contains(query.toLowerCase())) {
          filteredCompleteVahans.add(item);
        }
      },
      );
    } catch (e) {
      printCatchError(url: filteredCompleteVahans.toString(), error: e.toString());
    }
    update([GetXControllerBuilders.completedScreenController]);
  }

  /// Method use to get pending vehicles brands response.
  Future<void> getCompletedVahanData() async {
    isLoading(true);
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    try {
      final response = await http.get(Uri.parse("${Apis.baseUrl}${Apis.getCompletedCleanerUrl}${GetSfLocalStorage.getAuthToken()}&date=$formattedDate"));
      ViewCompletedSubscriptionResponse completeVahanData = viewCompletedSubscriptionResponseFromJson(response.body);
      if (response.statusCode == 200) {
        if (completeVahanData.status ?? false) {
          completeVahans = completeVahanData.completeVahans;
          for (CompleteVahan vahan in completeVahans ?? []) {
            filteredCompleteVahans.add(vahan);
          }
          imageBaseUrl = completeVahanData.baseurl ?? "";
          stats = completeVahanData.stats;
          balance = stats?.balance;
          todaysEarning = stats?.todaysEarning;
          printApiResponse(url: (Uri.parse("${Apis.baseUrl}${Apis.getCompletedCleanerUrl}${GetSfLocalStorage.getAuthToken()}&date=$formattedDate").toString()), response: response.body, statusCode: response.statusCode.toString());
        }
      } else {
        printApiResponse(url: (Uri.parse("${Apis.baseUrl}${Apis.getCompletedCleanerUrl}${GetSfLocalStorage.getAuthToken()}&date=$formattedDate").toString()), response: response.body, statusCode: response.statusCode.toString());
        setSnackBar("Failed to load data. Status code: ${response.statusCode}", Get.context, completeVahanData.status ?? false);
      }
    } catch (e) {
      printCatchError(url: (Uri.parse("${Apis.baseUrl}${Apis.getCompletedCleanerUrl}${GetSfLocalStorage.getAuthToken()}&date=$formattedDate").toString()), error: e.toString());
    }
    isLoading(false);
    update([GetXControllerBuilders.completedScreenController]);
  }
}