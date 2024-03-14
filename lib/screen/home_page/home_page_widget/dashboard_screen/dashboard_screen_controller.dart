import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../get_controller_builder.dart';
import '../../../../models/get_dashBoard_data_model.dart';
import '../../../../models/mark_attendance_model.dart';
import '../../../../shared_preferences/local_data.dart';
import '../../../../utils/apis.dart';
import 'package:http/http.dart' as http;
import '../../../../utils/snackbar.dart';

class DashBoardScreenController extends GetxController{
  var isLoading = false.obs;
  Position? currentPosition;
  String latitude = "";
  String longitude = "";
  String clockInTime = "";
  String clockOutTime = "";
  String workingHr = "";
  String acheived = "";
  String inTime = "";
  int balance = 0;
  int todaysEarning = 0;
  int thismonthEarning = 0;
  int target = 0;
  double achivePrecentage = 0.0;

  /// Initial method.
  @override
  onInit() async {
    super.onInit();
    sendLocation();
    getDashBoardData();
  }

  /// method use to refresh the page.
  pullRefresh() async {
    await getDashBoardData();
  }

  /// Check location permission.
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    /// Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  /// Get address from lat long.
  Future<void> getAddressFromLatLong(Position position) async {
    latitude = (position.latitude).toString();
    longitude = (position.longitude).toString();
    update([GetXControllerBuilders.dashBoardScreenController]);
  }

  /// Get Location initially.
  Future sendLocation() {
    return Future.delayed(const Duration(seconds: 0), () async {
      Position position = await determinePosition();
      getAddressFromLatLong(position);
    });
  }

  String getCurrentTime() {
    DateTime now = DateTime.now();
    var formatter = DateFormat('HH:mm:ss');
    return formatter.format(now);
  }

  /// Method use to get the dashboard data.
  Future<void> getDashBoardData() async {
    isLoading(true);
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    Uri url = Uri.parse("${Apis.baseUrl}${Apis.dashBoardUrl}${GetSfLocalStorage.getAuthToken()}&date=$formattedDate");
    try {
      final response = await http.get(url);
      DashBoardDataModel dashBoardData = dashBoardDataModelFromJson(response.body);
      if (response.statusCode == 200) {
        if (dashBoardData.status ?? false) {
          balance = dashBoardData.data?.stats?.balance ?? 0;
          todaysEarning = dashBoardData.data?.stats?.todaysEarning ?? 0;
          thismonthEarning = dashBoardData.data?.stats?.thismonthEarning ?? 0;
          target = dashBoardData.data?.stats?.target ?? 0;
          acheived = dashBoardData.data?.stats?.acheived ?? "";
          double onePercentage = (target/100);
          achivePrecentage = (double.parse(acheived)) / onePercentage;
          clockInTime = dashBoardData.data?.attendance?.inTime ?? "";
          clockOutTime = dashBoardData.data?.attendance?.outTime ?? "";
          if(clockOutTime.isNotEmpty) {
            DateTime inTime =
                DateTime.parse(DateTime.now().toString() + clockInTime);
            DateTime outTime =
                DateTime.parse(DateTime.now().toString() + clockOutTime);
            Duration difference = outTime.difference(inTime);

            /// Extract hours, minutes, and seconds
            int hours = difference.inHours;
            int minutes = difference.inMinutes % 60;
            int seconds = difference.inSeconds % 60;
            workingHr = "$hours:$minutes:$seconds";
          }
          printApiResponse(url: url.toString(), response: response.body, statusCode: response.statusCode.toString());
        }
      } else {
        printApiResponse(url: url.toString(), response: response.body, statusCode: response.statusCode.toString());
        setSnackBar("Failed to load data. Status code: ${response.statusCode}", Get.context, dashBoardData.status ?? false);
      }
    } catch (e) {
      printCatchError(url: (url.toString()), error: e.toString());
    }
    isLoading(false);
    update([GetXControllerBuilders.dashBoardScreenController]);
  }


    /// Method use to clock IN and OUT.
  clockINOut(BuildContext context) async {
    isLoading(true);
    inTime = getCurrentTime();
    Uri url = Uri.parse("${Apis.baseUrl}${Apis.markAttendanceUrl}${GetSfLocalStorage.getAuthToken()}");
    var request = http.MultipartRequest('POST', url);

    request.fields['type'] = clockInTime.isNotEmpty ? "OUT" : "IN";
    request.fields['time'] = inTime;
    request.fields['latitude'] = latitude;
    request.fields['longitude'] = longitude;
    printApiBody(body: request.fields.toString());

    try {
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      MarkAttendanceModel markAttendanceData = markAttendanceModelFromJson(responseBody.body);
      if (response.statusCode == 200) {
        if(markAttendanceData.status ?? false) {
          printApiResponse(url: (url.toString()), statusCode: response.statusCode.toString(), response: responseBody.body );
          // ignore: use_build_context_synchronously
          setSnackBar(markAttendanceData.message ?? "", context, markAttendanceData.status ?? false);
        } else {
          printApiResponse(url: (url.toString()), statusCode: response.statusCode.toString(), response: responseBody.body );
          // ignore: use_build_context_synchronously
          setSnackBar(markAttendanceData.message ?? "", context, markAttendanceData.status ?? false);
        }
      } else {
        printApiResponse(url: (url.toString()), statusCode: response.statusCode.toString(), response: responseBody.body );
        // ignore: use_build_context_synchronously
        setSnackBar(markAttendanceData.message ?? "", context, markAttendanceData.status ?? false);
      }
    } catch (e) {
      printCatchError(url: (url.toString()), error: e.toString());
    }
    isLoading(false);
    update([GetXControllerBuilders.dashBoardScreenController]);
  }
}