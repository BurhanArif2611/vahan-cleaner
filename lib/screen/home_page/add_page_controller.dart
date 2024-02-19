import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../get_controller_builder.dart';
import '../../models/add_vahan_response.dart';
import '../../models/view_subscription_response.dart';
import '../../shared_preferences/local_data.dart';
import '../../utils/apis.dart';
import '../../utils/snackbar.dart';
import 'home_controller.dart';

class AddPageController extends GetxController {

  var isLoading = false.obs;
  DateTime now = DateTime.now();
  var args = Get.arguments;

  Vahan? vahans;
  File? pickedImage;

  @override
  void onInit() {
    vahans = args["vahanData"];
    super.onInit();
  }

  //Image Picked
  pickImage(ImageSource imageType, BuildContext context) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      pickedImage = File(photo.path);
      addCleaning(context);
      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
    update([GetXControllerBuilders.addVehicleController]);
  }

  /// Login api function with password.
  addCleaning(BuildContext context) async {
    isLoading(true);
    var request = http.MultipartRequest('POST', Uri.parse(Apis.baseUrl + Apis.addCleaner + GetSfLocalStorage.getAuthToken()));
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    // Add form data to the request
    request.fields['date'] = formattedDate;
    request.fields['subscription_id'] = vahans?.subscriptionId ?? "";
    request.files.add(http.MultipartFile('image', pickedImage!.readAsBytes().asStream(), pickedImage!.lengthSync(), filename: 'image.jpg',),
    );
    try {
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      AddVahanResponse loginResponse = addVahanResponseFromJson(responseBody.body);
      if (response.statusCode == 200) {
        if(loginResponse.status ?? false) {
          HomePageController homePageController = Get.put(HomePageController());
          homePageController.getVahanData();
          Get.back();
          setSnackBar(loginResponse.message ?? "", context, loginResponse.status ?? false);
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
    update([GetXControllerBuilders.homePageController]);
  }
}