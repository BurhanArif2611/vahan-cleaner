import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../../get_controller_builder.dart';
import '../../../../models/view_other_subscription_response.dart';
import '../../../../shared_preferences/local_data.dart';
import '../../../../utils/apis.dart';
import '../../../../utils/snackbar.dart';

class OtherSubscriptionController extends GetxController {

  TextEditingController searchController = TextEditingController();
  var isLoading = false.obs;
  DateTime now = DateTime.now();
  List<OthersVahan>? othersVahans;
  List<OthersVahan> filterOthersVahans = [];
  String? imageBaseUrl;
  OthersStats? othersStats;
  int balance = 0;
  int todaysEarning = 0;

  @override
  void onInit() async {
    super.onInit();
    await getOthersVahanData();
  }

  /// Refresh page.
  Future<void> pullRefresh() async {
    await getOthersVahanData();
  }

  /// Method use to filter the data by search bar.
  void filterList(String query) {
    try {
      filterOthersVahans = [];
      othersVahans?.forEach((item) {
        if ((item.regNumber ?? "").toLowerCase().contains(query.toLowerCase()) ||
            (item.parkingLocation ?? "").toLowerCase().contains(query.toLowerCase()) ||
            (item.name ?? "").toLowerCase().contains(query.toLowerCase())) {
          filterOthersVahans.add(item);
        }
      },
      );
    } catch (e) {
      printCatchError(url: filterOthersVahans.toString(), error: e.toString());
    }
    update([GetXControllerBuilders.otherScreenController]);
  }

  /// Method use to get pending vehicles brands response.
  Future<void> getOthersVahanData() async {
    isLoading(true);
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    try {
      final response = await http.get(Uri.parse("${Apis.baseUrl}${Apis.getOtherCleanerUrl}${GetSfLocalStorage.getAuthToken()}&date=$formattedDate"));
      OtherSubscriptionModel otherVahanData = otherSubscriptionModelFromJson(response.body);
      if (response.statusCode == 200) {
        if (otherVahanData.status ?? false) {
          othersVahans = otherVahanData.vahans;
          for (OthersVahan vahan in othersVahans ?? []) {
            filterOthersVahans.add(vahan);
          }
          imageBaseUrl = otherVahanData.baseurl ?? "";
          othersStats = otherVahanData.stats;
          balance = othersStats?.balance ?? 0;
          todaysEarning = othersStats?.todaysEarning ?? 0;
          printApiResponse(url: (Uri.parse("${Apis.baseUrl}${Apis.getOtherCleanerUrl}${GetSfLocalStorage.getAuthToken()}&date=$formattedDate").toString()), response: response.body, statusCode: response.statusCode.toString());
        }
      } else {
        printApiResponse(url: (Uri.parse("${Apis.baseUrl}${Apis.getOtherCleanerUrl}${GetSfLocalStorage.getAuthToken()}&date=$formattedDate").toString()), response: response.body, statusCode: response.statusCode.toString());
        setSnackBar("Failed to load data. Status code: ${response.statusCode}", Get.context, otherVahanData.status ?? false);
      }
    } catch (e) {
      printCatchError(url: (Uri.parse("${Apis.baseUrl}${Apis.getOtherCleanerUrl}${GetSfLocalStorage.getAuthToken()}&date=$formattedDate").toString()), error: e.toString());
    }
    isLoading(false);
    update([GetXControllerBuilders.otherScreenController]);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    searchController.clear();
    super.dispose();
  }
}