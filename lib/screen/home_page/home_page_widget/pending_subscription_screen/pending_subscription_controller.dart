import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:vahan_cleaner/shared_preferences/local_data.dart';
import '../../../../get_controller_builder.dart';
import '../../../../models/view_pending_subscription_response.dart';
import '../../../../utils/apis.dart';
import '../../../../utils/snackbar.dart';

class PendingSubscriptionController extends GetxController {

  TextEditingController searchController = TextEditingController();
  var isLoading = false.obs;
  DateTime now = DateTime.now();
  List<Vahan>? pendingVahans;
  List<Vahan> filteredList = [];
  String? imageBaseUrl;
  Stats? stats;
  int balance = 0;
  int todaysEarning = 0;
  File? pickedImage;

  @override
  void onInit() {
    getPendingVahanData();
    super.onInit();
  }

  /// Refresh page.
  Future<void> pullRefresh() async {
    await getPendingVahanData();
  }

  /// Method use to filter the data by search bar.
  void filterList(String query) {
    try {
      filteredList = [];
      pendingVahans?.forEach((item) {
          if ((item.regNumber ?? "").toLowerCase().contains(query.toLowerCase()) ||
              (item.parkingLocation ?? "").toLowerCase().contains(query.toLowerCase()) ||
              (item.name ?? "").toLowerCase().contains(query.toLowerCase())) {
              filteredList.add(item);
          }
        },
      );
    } catch (e) {
      printCatchError(url: filteredList.toString(), error: e.toString());
    }
    update([GetXControllerBuilders.pendingScreenController]);
  }

  /// Method use to get pending vehicles brands response.
  Future<void> getPendingVahanData() async {
    isLoading(true);
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    try {
      final response = await http.get(Uri.parse("${Apis.baseUrl}${Apis.getPendingCleanerUrl}${GetSfLocalStorage.getAuthToken()}&date=$formattedDate"));
      ViewPendingSubscriptionResponse vahansLIst = viewSubscriptionResponseFromJson(response.body);
      if (response.statusCode == 200) {
        if (vahansLIst.status ?? false) {
          pendingVahans = vahansLIst.vahans;
          for (Vahan vahan in pendingVahans ?? []) {
            filteredList.add(vahan);
          }
          imageBaseUrl = vahansLIst.baseurl ?? "";
          stats = vahansLIst.stats;
          balance = stats?.balance ?? 0;
          todaysEarning = stats?.todaysEarning ?? 0;
          printApiResponse(url: (Uri.parse("${Apis.baseUrl}${Apis.getPendingCleanerUrl}${GetSfLocalStorage.getAuthToken()}&date=$formattedDate").toString()), response: response.body, statusCode: response.statusCode.toString());
        }
      } else {
        printApiResponse(url: (Uri.parse("${Apis.baseUrl}${Apis.getPendingCleanerUrl}${GetSfLocalStorage.getAuthToken()}&date=$formattedDate").toString()), response: response.body, statusCode: response.statusCode.toString());
        setSnackBar("Failed to load data. Status code: ${response.statusCode}", Get.context, vahansLIst.status ?? false);
      }
    } catch (e) {
      printCatchError(url: (Uri.parse("${Apis.baseUrl}${Apis.getPendingCleanerUrl}${GetSfLocalStorage.getAuthToken()}&date=$formattedDate").toString()), error: e.toString());
    }
    isLoading(false);
    update([GetXControllerBuilders.pendingScreenController]);
  }
}