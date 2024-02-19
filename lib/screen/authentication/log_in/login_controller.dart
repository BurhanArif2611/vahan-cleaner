import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../app_routes/app_routes.dart';
import '../../../get_controller_builder.dart';
import '../../../models/login_response.dart';
import '../../../shared_preferences/local_data.dart';
import '../../../utils/apis.dart';
import '../../../utils/snackbar.dart';

class LoginController extends GetxController {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var isLoading = false.obs;
  bool isVisibility = true;
  bool isFill = false;


  isPasswordVisible() {
    isVisibility = !isVisibility;
    update([GetXControllerBuilders.loginController]);
  }

  /// Login api function with password.
  loginApiWithPassword(BuildContext context) async {
    isLoading(true);
    var request = http.MultipartRequest('POST', Uri.parse(Apis.baseUrl + Apis.loginWithPassword));

    // Add form data to the request
    request.fields['mobile'] = emailController.text;
    request.fields['lastlogin_ip'] = '103.208.68.31';
    request.fields['password'] = passwordController.text;
    try {
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      LoginResponse loginResponse = loginResponseFromJson(responseBody.body);
      if (response.statusCode == 200) {
        if(loginResponse.status ?? false) {
          setSnackBar(loginResponse.message ?? "", context, loginResponse.status ?? false);
          GetSfLocalStorage.setAuthToken(loginResponse.cleanerdata?.token ?? "");
          Get.offAllNamed(AppRoutes.homePage);
        } else {
          setSnackBar(loginResponse.message ?? "", context, loginResponse.status ?? false);
        }
        print('Response: ${await http.Response.fromStream(response)}');
      } else {
        print('Request failed with status: ${response.statusCode}');
        setSnackBar(loginResponse.message ?? "", context, loginResponse.status ?? false);
      }
    } catch (e) {
      print('Error: $e');
    }
    isLoading(false);
  }
}
