import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../get_controller_builder.dart';
import '../../../utils/apis.dart';
import '../../../utils/colors.dart';
import '../../../utils/font_family.dart';
import '../../../utils/loading.dart';
import '../../../widget/common_app_bar.dart';
import 'get_attendance_controller.dart';

class GetAttendanceScreen extends StatefulWidget {
  const GetAttendanceScreen({super.key});

  @override
  State<GetAttendanceScreen> createState() => _GetAttendanceScreenState();
}

class _GetAttendanceScreenState extends State<GetAttendanceScreen> {
  GetAttendanceController getAttendanceController =
  Get.put(GetAttendanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.neutral_200,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: CustomAppBar(
            isBack: true,
            isCalender: true,
          )),
      body: GetBuilder(
        id: GetXControllerBuilders.getAttendanceController,
        init: getAttendanceController,
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: () => controller.pullDownRefresh(),
            child: Stack(
              children: [
                Container(
                  color: AppColor.neutral_200,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "My Attendance",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColor.neutral_600,
                              fontSize: 20,
                              fontFamily: FontFamily.fontFamily,
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: AppColor.neutral_600, thickness: 0.7),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15),
                        color: AppColor.orange_200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 40,
                              child: Text(
                                "Date",
                                style: TextStyle(
                                    fontFamily: FontFamily.fontFamily,
                                    fontSize: 12,
                                    color: AppColor.neutral_700,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            SizedBox(
                              width: 60,
                              child: Text("Clock In",
                                style: TextStyle(
                                    fontFamily: FontFamily.fontFamily,
                                    fontSize: 12,
                                    color: AppColor.neutral_700,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            SizedBox(
                              width: 60,
                              child: Text("Clock Out",
                                style: TextStyle(
                                    fontFamily: FontFamily.fontFamily,
                                    fontSize: 12,
                                    color: AppColor.neutral_700,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            const SizedBox(width: 30),
                            SizedBox(
                              width: 75,
                              child: Text("Working Hr's",
                                style: TextStyle(
                                    fontFamily: FontFamily.fontFamily,
                                    fontSize: 12,
                                    color: AppColor.neutral_700,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.attendance?.length ?? 0,
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {

                            controller.inTime = controller.attendance?[index].inTime ?? "";
                            controller.outTime = controller.attendance?[index].outTime ?? "";
                            controller.vDate = controller.attendance?[index].date ?? "";

                            if((controller.outTime ?? "").isNotEmpty) {
                              try {
                                DateFormat format = DateFormat("HH:mm:ss");
                                DateTime inTime = format.parse(controller.inTime ?? "");
                                DateTime outTime = format.parse(controller.outTime ?? "");
                                Duration difference = outTime.difference(inTime);

                                /// Extract hours, minutes, and seconds
                                int hours = difference.inHours;
                                int minutes = difference.inMinutes % 60;
                                int seconds = difference.inSeconds % 60;
                                controller.workingHour = "$hours:$minutes:$seconds";
                                printWorkingHr(workingHr: controller.workingHour ?? "");
                              } catch (e) {
                                printDifferenceCatchError(error: e.toString());
                              }
                            }

                            String formattedDate = "";
                            String formattedDay = "";
                            if((controller.vDate ?? "").isNotEmpty) {
                              /// Parsing the input date string
                              DateTime dateTime = DateFormat("yyyy-MM-dd").parse(controller.vDate ?? "");

                              /// Formatting the date and day separately
                              formattedDate = DateFormat("dd").format(dateTime);
                              formattedDay = DateFormat("E").format(dateTime);
                            }

                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: AppColor.neutral_600, // Choose the color of the border
                                        width: 1.0, // Choose the width of the border
                                      ),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(formattedDate,
                                            style: TextStyle(
                                                fontFamily: FontFamily.fontFamily,
                                                fontSize: 18,
                                                color: AppColor.neutral_700,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(formattedDay,
                                            style: TextStyle(
                                                fontFamily: FontFamily.fontFamily,
                                                fontSize: 10,
                                                color: AppColor.neutral_700,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 75,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.watch_later_outlined,
                                            color: AppColor.orange, size: 18),
                                        Text(controller.inTime ?? "__:__",
                                          style: TextStyle(
                                              fontFamily: FontFamily.fontFamily,
                                              fontSize: 12,
                                              color: AppColor.neutral_700,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 75,
                                    child: Row(
                                      children: [
                                        const Icon(Icons.watch_later_outlined,
                                            color: AppColor.orange, size: 18),
                                        Text(controller.outTime ?? "__:__",
                                          style: TextStyle(
                                              fontFamily: FontFamily.fontFamily,
                                              fontSize: 12,
                                              color: AppColor.neutral_700,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 40),
                                  SizedBox(
                                    width: 75,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            controller.workingHour ?? "__:__",
                                            style: TextStyle(
                                                fontFamily: FontFamily.fontFamily,
                                                fontSize: 12,
                                                color: AppColor.neutral_700,
                                                fontWeight: FontWeight.w400),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(() => Utility.loaderWidget(getAttendanceController.isLoading.value)),
              ],
            ),
          );
        },
      ),
    );
  }
}
