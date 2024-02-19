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
  File? pickedImage;

  @override
  void onInit() {
    getVahanData();
    super.onInit();
  }

  /// Refresh page.
  Future<void> pullRefresh() async {
    getVahanData();
  }

  /// Method use to get vehicles brands response.
  Future<void> getVahanData() async {
    isLoading(true);
    try {
      String formattedDate = DateFormat('yyyy-MM-dd').format(now);
      final response = await http.get(Uri.parse(Apis.baseUrl + Apis.getCleaner + GetSfLocalStorage.getAuthToken() + "&date=$formattedDate"));
      ViewSubscriptionResponse vahansLIst = viewSubscriptionResponseFromJson(response.body);
      if (response.statusCode == 200) {
        if (vahansLIst.status ?? false) {
          vahans = vahansLIst.vahans;
          imageBaseUrl = vahansLIst.baseurl ?? "";
          print('Data: ${response.body}');
        }
        print('Data: ${response.body}');
      } else {
        // Handle error response
        print('Failed to load data. Status code: ${response.statusCode}');
        setSnackBar("Failed to load data. Status code: ${response.statusCode}", Get.context, vahansLIst.status ?? false);
      }
    } catch (e) {
      print('Error: ${e}');
    }
    isLoading(false);
    update([GetXControllerBuilders.homePageController]);
  }
}