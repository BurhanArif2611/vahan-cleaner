import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../get_controller_builder.dart';
import '../../../models/get_attendance_model.dart';
import '../../../shared_preferences/local_data.dart';
import '../../../utils/apis.dart';
import '../../../utils/snackbar.dart';


class GetAttendanceController extends GetxController {
  var isLoading = false.obs;
  List<Attendance>? attendance;
  String? workingHour;
  String? inTime;
  String? outTime;
  String? vDate;

  /// Initial function.
  @override
  onInit() async {
    super.onInit();
    await getAttendance();
  }

  /// Method use to refresh the home screen.
  pullDownRefresh() async {
    await getAttendance();
  }

  /// Method use to check get all attendance.
  getAttendance() async {
    Uri url = Uri.parse("${Apis.baseUrl}${Apis.getAttendanceUrl}${GetSfLocalStorage.getAuthToken()}");
    try {
      isLoading(true);
      final getAttendanceResponse = await http.get(url);
      GetAttendanceModel attendanceData = getAttendanceModelFromJson(getAttendanceResponse.body);
      if (getAttendanceResponse.statusCode == 200) {
        if (attendanceData.status ?? false) {
          attendance = attendanceData.attendance ?? [];
          printApiResponse(url: url.toString(), response: getAttendanceResponse.body, statusCode: getAttendanceResponse.statusCode.toString());
        } else {
          printApiResponse(url: url.toString(), response: getAttendanceResponse.body, statusCode: getAttendanceResponse.statusCode.toString());
        }
      } else {
        printApiResponse(url: url.toString(), response: getAttendanceResponse.body, statusCode: getAttendanceResponse.statusCode.toString());
        setSnackBar("Failed to load data. Status code: ${getAttendanceResponse.statusCode}", Get.context, attendanceData.status ?? false);
      }
    } catch (e) {
      printCatchError(url: url.toString(), error: e.toString());
    }
    isLoading(false);
    update([GetXControllerBuilders.getAttendanceController]);
  }
}
