import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../get_controller_builder.dart';
import '../../../utils/font_family.dart';
import '../../../utils/loading.dart';
import '../../../widget/common_app_bar.dart';
import '../../utils/colors.dart';
import 'add_page_controller.dart';

class AddVehicleScreen extends StatefulWidget {
  AddVehicleScreen({Key? key}) : super(key: key);
  @override
  State<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {

  AddPageController addVehicleController = Get.put(AddPageController());

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('hh : mm a').format(DateTime.now());
    return Stack(
      children: [
        GetBuilder<AddPageController>(
            id: GetXControllerBuilders.addVehicleController,
            init: addVehicleController,
            builder: (controller) {
              return Scaffold(
                backgroundColor: AppColor.neutral_200,
                appBar: PreferredSize(
                    preferredSize: Size.fromHeight(70.0),
                    child: CustomAppBar(isBack: true,)
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Add Your Vahan For The Cleaning",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            fontFamily: FontFamily.fontFamily,),
                        ),
                        Container(
                          width: 300,
                          child: Text(
                            "Add your Vahan details for personalized care.",
                            maxLines: 2,
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              fontFamily: FontFamily.fontFamily,),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: MediaQuery.of(context).size.width - 40,
                          padding: EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                              color: AppColor.neutral_100,
                              border:
                              Border.all(width: 0.7, color: AppColor.neutral_400),
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(Icons.watch_later_outlined, color: AppColor.orange_200,),
                                  Center(
                                    child: Text(DateFormat('d MMM y').format(now),
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: FontFamily.fontFamily)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColor.neutral_100,
                              border: Border.all(color: AppColor.orange_100),
                              boxShadow: [
                                BoxShadow(
                                    color: AppColor.neutral_300.withOpacity(0.6),
                                    offset: Offset(0, 3),
                                    spreadRadius: 4,
                                    blurRadius: 4
                                )
                              ]
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(controller.vahans?.regNumber ?? "", style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold,
                                      fontFamily: FontFamily.fontFamily
                                  ),),
                                  Text(" ${controller.vahans?.brand ?? ""} ${controller.vahans?.model ?? ""}", style: TextStyle(fontFamily: FontFamily.fontFamily, fontWeight: FontWeight.w500, fontSize: 15),),
                                  Row(
                                    children: [
                                      Icon(Icons.person, color: AppColor.orange, size: 18),
                                      Text(" ${controller.vahans?.name ?? ""}", style: TextStyle(fontFamily: FontFamily.fontFamily, fontWeight: FontWeight.w500, fontSize: 15),),

                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.location_on, color: AppColor.neutral_500, size: 14),
                                  Text((controller.vahans?.parkingLocation ?? ""), style: TextStyle(
                                      fontSize: 12, fontWeight: FontWeight.bold,
                                      fontFamily: FontFamily.fontFamily
                                  ),),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.neutral_100,
                            border: Border.all(color:buttoncolor, width: 0.7),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            child: controller.pickedImage != null
                                ? Image.file(
                              controller.pickedImage!,
                              width: MediaQuery.of(context).size.width - 40,
                              height: 220,
                              fit: BoxFit.cover,
                            )
                                : Container(
                              width: MediaQuery.of(context).size.width - 40,
                              height: 220,
                                    child: Image.asset(
                                      "Assets/Images/sport-car.png",
                                      scale: 5,
                                      color: AppColor.neutral_400,
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(height: 8),
                        GestureDetector(
                          onTap: () {
                            imagePickerOption(controller, context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ("Add Car Image").toUpperCase(),
                                style: TextStyle(
                                    color: buttoncolor,
                                    fontFamily: FontFamily.fontFamily,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
        ),
        Obx(
              () => Utility.loaderWidget(addVehicleController.isLoading.value),
        )
      ],
    );
  }

  // bottom sheet image picked
  void imagePickerOption(AddPageController controller, BuildContext context) {
    Get.bottomSheet(
      SingleChildScrollView(
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: Container(
            color: Colors.white,
            height: 250,
            child: Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Pic Image From",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: FontFamily.fontFamily,),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      controller.pickImage(ImageSource.camera, context);
                    },
                    icon: const Icon(Icons.camera, color: AppColor.neutral_100,),
                    label: Text(
                      "CAMERA",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: AppColor.neutral_100, fontFamily: FontFamily.fontFamily,),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(primaryColor),
                      shadowColor: MaterialStateProperty.all(Colors.grey),
                      elevation: MaterialStateProperty.all(8),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      controller.pickImage(ImageSource.gallery, context);
                    },
                    icon: const Icon(Icons.image, color: AppColor.neutral_100),
                    label: Text("GALLERY", style: TextStyle(color: AppColor.neutral_100, fontFamily: FontFamily.fontFamily,)),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(primaryColor),
                      shadowColor: MaterialStateProperty.all(Colors.grey),
                      elevation: MaterialStateProperty.all(8),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.close, color: AppColor.neutral_100),
                    label: Text("CANCEL", style: TextStyle(color: AppColor.neutral_100, fontFamily: FontFamily.fontFamily,)),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(primaryColor),
                      shadowColor: MaterialStateProperty.all(Colors.grey),
                      elevation: MaterialStateProperty.all(8),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Method use for text field decoration.
  InputDecoration commonDecoration({required String hintText, Widget? suffixIcon}) {
    return InputDecoration(
      fillColor: AppColor.neutral_100,
      filled: true,
      hintText: hintText,
      hintStyle: TextStyle(
        color: AppColor.neutral_500,
        fontWeight: FontWeight.normal,
        fontSize: 14,
        fontFamily: FontFamily.fontFamily,
      ),
      suffixIcon: suffixIcon,
      contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      border: OutlineInputBorder(
        borderSide: const BorderSide(width: 0.7, color: AppColor.neutral_400),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 0.7, color: AppColor.neutral_400),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 0.7, color: AppColor.orange_400),
        borderRadius: BorderRadius.circular(8),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 0.7, color: AppColor.red),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 0.7, color: AppColor.red),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  /// Common text label
  Widget commonTextLabel({required String label}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 10),
      child: Row(
        children: [
          Text(label, textAlign: TextAlign.start, style: TextStyle(
            color: AppColor.neutral_700,
            fontWeight: FontWeight.w600,
            fontFamily: FontFamily.fontFamily,
          ),),
        ],
      ),
    );
  }
}
