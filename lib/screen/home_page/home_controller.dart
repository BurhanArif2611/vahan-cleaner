import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../get_controller_builder.dart';
import '../../models/view_subscription_response.dart';
import '../../shared_preferences/local_data.dart';
import '../../utils/apis.dart';
import '../../utils/snackbar.dart';

class HomePageController extends GetxController {

  var isLoading = false.obs;
  DateTime now = DateTime.now();

  List<Vahan>? vahans;
  String? imageBaseUrl;
  Stats? stats;
  int? balance;
  int? todaysEarning;
  File? pickedImage;

  @override
  void onInit() {
    getVahanData();
    super.onInit();
  }

  /// Refresh page.
  Future<void> pullRefresh() async {
    await getVahanData();
  }

  /// Method use to get vehicles brands response.
  Future<void> getVahanData() async {
    isLoading(true);
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    try {
      final response = await http.get(Uri.parse("${Apis.baseUrl}${Apis.getCleaner}${GetSfLocalStorage.getAuthToken()}&date=$formattedDate"));
      ViewSubscriptionResponse vahansLIst = viewSubscriptionResponseFromJson(response.body);
      if (response.statusCode == 200) {
        if (vahansLIst.status ?? false) {
          vahans = vahansLIst.vahans;
          imageBaseUrl = vahansLIst.baseurl ?? "";
          stats = vahansLIst.stats;
          balance = stats?.balance;
          todaysEarning = stats?.todaysEarning;
          printApiResponse(url: (Uri.parse("${Apis.baseUrl}${Apis.getCleaner}${GetSfLocalStorage.getAuthToken()}&date=$formattedDate").toString()), response: response.body, statusCode: response.statusCode.toString());
        }
      } else {
        printApiResponse(url: (Uri.parse("${Apis.baseUrl}${Apis.getCleaner}${GetSfLocalStorage.getAuthToken()}&date=$formattedDate").toString()), response: response.body, statusCode: response.statusCode.toString());
        setSnackBar("Failed to load data. Status code: ${response.statusCode}", Get.context, vahansLIst.status ?? false);
      }
    } catch (e) {
      printCatchError(url: (Uri.parse("${Apis.baseUrl}${Apis.getCleaner}${GetSfLocalStorage.getAuthToken()}&date=$formattedDate").toString()), error: e.toString());
    }
    isLoading(false);
    update([GetXControllerBuilders.homePageController]);
  }
}