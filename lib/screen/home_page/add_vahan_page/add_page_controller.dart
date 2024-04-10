import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../get_controller_builder.dart';
import '../../../models/add_vahan_response.dart';
import '../../../models/get_cleaner_model.dart';
import '../../../models/view_pending_subscription_response.dart';
import '../../../shared_preferences/local_data.dart';
import '../../../utils/apis.dart';
import '../../../utils/snackbar.dart';
import 'add_vahan_page.dart';
import '../home_page_widget/pending_subscription_screen/pending_subscription_controller.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class AddPageController extends GetxController {

  CarModeValue? selectedOption;
  var isLoading = false.obs;
  DateTime now = DateTime.now();
  var args = Get.arguments;

  var vahans;
  String? imageBaseUrl;
  bool? isOther;
  String? address;
  File? pickedImage;
  String serviceType = "";
  List<Cleaner> cleaners = [Cleaner(id: '', name: '')];
  String? selectedValue;
  String? selectedCleanerId;

  @override
  void onInit() async {
    vahans = args["vahanData"];
    imageBaseUrl = args['baseUrl'];
    isOther = args['isOther'];
    address = args['locationName'];
    serviceType = vahans.mode ?? "";
    await getCleaner();
    if(serviceType.toLowerCase() != "out") {
      selectedOption = CarModeValue.External;
    } else {
      selectedOption = CarModeValue.Internal;
    }
    printDoneService(serviceType: serviceType);
    super.onInit();
  }

  selectCleaner(value) {
    selectedValue = value;
    update([GetXControllerBuilders.addVehicleController]);
  }

  /// Method use to select the Mode.
  selectCarMode(CarModeValue? value) {
    selectedOption = value;
    update([GetXControllerBuilders.addVehicleController]);
  }

  ///Image Picked
  pickImage(ImageSource imageType, BuildContext context) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      pickedImage = await compressImage(XFile(photo.path));
      // ignore: use_build_context_synchronously
      addCleaning(context);
      Get.back();
    } catch (error) {
      printImageError(error: error.toString());
    }
    update([GetXControllerBuilders.addVehicleController]);
  }

  /// Compress image function
  Future<File?> compressImage(XFile imageFile) async {
    int quality = 85;
    String filePath = imageFile.path;
    String extension = filePath.split('.').last;
    String compressedPath = filePath.replaceAll('.$extension', '_compressed.$extension');
    var result = await FlutterImageCompress.compressAndGetFile(
      filePath,
      compressedPath,
      quality: quality,
    );

    /// Convert XFile to File
    if (result != null) {
      return File(result.path);
    } else {
      return null;
    }
  }

  /// Method use to get cleaner data.
  getCleaner() async {
    isLoading(true);
    Uri url = Uri.parse("${Apis.baseUrl}${Apis.getCleanerUrl}");
    try {
      final response = await http.get(url);
      GetCleanerModel cleanerList = getCleanerModelFromJson(response.body);
      if (response.statusCode == 200) {
        if (cleanerList.status ?? false) {
          cleaners = cleanerList.cleaners ?? [];
          printApiResponse(url: (url.toString()), response: response.body, statusCode: response.statusCode.toString());
        }
      } else {
        printApiResponse(url: (url.toString()), response: response.body, statusCode: response.statusCode.toString());
        setSnackBar("Failed to load data. Status code: ${response.statusCode}", Get.context, cleanerList.status ?? false);
      }
    } catch (e) {
      printCatchError(url: (url.toString()), error: e.toString());
    }
    isLoading(false);
    update([GetXControllerBuilders.addVehicleController]);
  }

  /// Login api function with password.
  addCleaning(BuildContext context) async {
    isLoading(true);
    var request = http.MultipartRequest('POST', Uri.parse(Apis.baseUrl + Apis.addCleanerUrl + GetSfLocalStorage.getAuthToken()));
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    request.fields['date'] = formattedDate;
    request.fields['mode'] = selectedOption == CarModeValue.Internal ? "in" : selectedOption == CarModeValue.External ? "out" : "na";
    request.fields['subscription_id'] = vahans?.subscriptionId ?? "";
    request.fields['cleaner_id'] = ((selectedCleanerId ?? "").isNotEmpty && selectedCleanerId != null) ? (selectedCleanerId ?? "") : GetSfLocalStorage.getCleanerId();
    request.files.add(http.MultipartFile('image', pickedImage!.readAsBytes().asStream(), pickedImage!.lengthSync(), filename: 'image.jpg'));
    printApiBody(body: request.fields.toString());

    try {
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      AddVahanResponse loginResponse = addVahanResponseFromJson(responseBody.body);
      if (response.statusCode == 200) {
        if(loginResponse.status ?? false) {
          printApiResponse(url: (Uri.parse(Apis.baseUrl + Apis.addCleanerUrl + GetSfLocalStorage.getAuthToken()).toString()), response: responseBody.body, statusCode: response.statusCode.toString());
          PendingSubscriptionController homePageController = Get.put(PendingSubscriptionController());
          homePageController.getPendingVahanData();
          Get.back();
          // ignore: use_build_context_synchronously
          setSnackBar(loginResponse.message ?? "", context, loginResponse.status ?? false);
        } else {
          printApiResponse(url: (Uri.parse(Apis.baseUrl + Apis.addCleanerUrl + GetSfLocalStorage.getAuthToken()).toString()), response: responseBody.body, statusCode: response.statusCode.toString());
          // ignore: use_build_context_synchronously
          setSnackBar(loginResponse.message ?? "", context, loginResponse.status ?? false);
        }
      } else {
        printApiResponse(url: (Uri.parse(Apis.baseUrl + Apis.addCleanerUrl + GetSfLocalStorage.getAuthToken()).toString()), response: responseBody.body, statusCode: response.statusCode.toString());
        // ignore: use_build_context_synchronously
        setSnackBar(loginResponse.message ?? "", context, loginResponse.status ?? false);
      }
    } catch (e) {
      printCatchError(url: (Uri.parse(Apis.baseUrl + Apis.addCleanerUrl + GetSfLocalStorage.getAuthToken()).toString()), error: e.toString());
    }
    isLoading(false);
    update([GetXControllerBuilders.pendingScreenController]);
  }
}