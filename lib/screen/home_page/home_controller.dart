import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../get_controller_builder.dart';
import '../../models/view_pending_subscription_response.dart';
import '../../shared_preferences/local_data.dart';
import '../../utils/apis.dart';
import '../../utils/snackbar.dart';

class HomePageController extends GetxController {

  TextEditingController searchController = TextEditingController();
  List<Vahan>? filteredList;
  var isLoading = false.obs;
  DateTime now = DateTime.now();

  List<Vahan>? vahans;
  String? imageBaseUrl;
  Stats? stats;
  int? balance;
  int? todaysEarning;
  File? pickedImage;

  @override
  void onInit() async {
    await getPendingVahanData();
    if(vahans != null) {
      for(int i = 0; i >= vahans!.length; i++) {
        filteredList?.add(vahans![i]);
        print("Single Item ${i} = $filteredList");
      }
    }
    print("filter list: $filteredList");
    super.onInit();
  }

  /// Refresh page.
  Future<void> pullRefresh() async {
    await getPendingVahanData();
  }

  /// Method use to filter the data by search bar.
  void filterList(String query) {
    isLoading(true);
    filteredList?.clear();
    if (query.isEmpty) {
      filteredList?.addAll(vahans ?? []);
    } else {
      vahans?.forEach(
        (item) {
          if ((item.regNumber ?? "")
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              (item.parkingLocation ?? "")
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              (item.name ?? "").toLowerCase().contains(query.toLowerCase())) {
            filteredList?.add(item);
          }
        },
      );
    }
    isLoading(false);
    update([GetXControllerBuilders.homePageController]);
  }

  /// Method use to get pending vehicles brands response.
  Future<void> getPendingVahanData() async {
    isLoading(true);
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    try {
      final response = await http.get(Uri.parse("${Apis.baseUrl}${Apis.getPendingCleaner}${GetSfLocalStorage.getAuthToken()}&date=$formattedDate"));
      ViewPendingSubscriptionResponse vahansLIst = viewSubscriptionResponseFromJson(response.body);
      if (response.statusCode == 200) {
        if (vahansLIst.status ?? false) {
          vahans = vahansLIst.vahans;
          imageBaseUrl = vahansLIst.baseurl ?? "";
          stats = vahansLIst.stats;
          balance = stats?.balance;
          todaysEarning = stats?.todaysEarning;
          printApiResponse(url: (Uri.parse("${Apis.baseUrl}${Apis.getPendingCleaner}${GetSfLocalStorage.getAuthToken()}&date=$formattedDate").toString()), response: response.body, statusCode: response.statusCode.toString());
        }
      } else {
        printApiResponse(url: (Uri.parse("${Apis.baseUrl}${Apis.getPendingCleaner}${GetSfLocalStorage.getAuthToken()}&date=$formattedDate").toString()), response: response.body, statusCode: response.statusCode.toString());
        setSnackBar("Failed to load data. Status code: ${response.statusCode}", Get.context, vahansLIst.status ?? false);
      }
    } catch (e) {
      printCatchError(url: (Uri.parse("${Apis.baseUrl}${Apis.getPendingCleaner}${GetSfLocalStorage.getAuthToken()}&date=$formattedDate").toString()), error: e.toString());
    }
    isLoading(false);
    update([GetXControllerBuilders.homePageController]);
  }
}