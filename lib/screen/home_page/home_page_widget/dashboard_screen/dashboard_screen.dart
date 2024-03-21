import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vahan_cleaner/screen/home_page/home_page_widget/dashboard_screen/dashboard_screen_controller.dart';
import '../../../../get_controller_builder.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/font_family.dart';
import '../../../../utils/loading.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  DashBoardScreenController dashBoardScreenController = Get.put(DashBoardScreenController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: dashBoardScreenController,
      id: GetXControllerBuilders.dashBoardScreenController,
      builder: (controller) {
        return RefreshIndicator(
          onRefresh: () {
            return controller.pullRefresh();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Welcome Back, ${controller.userName}",
                          style: TextStyle(
                              color: AppColor.neutral_700,
                              fontFamily: FontFamily.fontFamily,
                              fontSize: 20,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.40,
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColor.neutral_100,
                                  border:
                                  Border.all(color: AppColor.orange_100),
                                  boxShadow: [
                                    BoxShadow(
                                        color: AppColor.neutral_300.withOpacity(0.6),
                                        offset: const Offset(0, 3),
                                        spreadRadius: 4,
                                        blurRadius: 4)
                                  ]),
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(
                                      "Total balance",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontFamily.fontFamily),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 22,
                                          height: 22,
                                          child: Image.asset(
                                            "Assets/Images/coin.png",
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return const Icon(
                                                  Icons.error_outline_outlined,
                                                  size: 10,
                                                  color: AppColor.red);
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          controller.balance.toString(),
                                          style: TextStyle(
                                              fontFamily: FontFamily.fontFamily,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColor.neutral_100,
                                  border:
                                  Border.all(color: AppColor.orange_100),
                                  boxShadow: [
                                    BoxShadow(
                                        color: AppColor.neutral_300
                                            .withOpacity(0.6),
                                        offset: const Offset(0, 3),
                                        spreadRadius: 4,
                                        blurRadius: 4)
                                  ]),
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(
                                      "Today's earning",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontFamily.fontFamily),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 22,
                                          height: 22,
                                          child: Image.asset(
                                            "Assets/Images/coin.png",
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return const Icon(
                                                  Icons.error_outline_outlined,
                                                  size: 10,
                                                  color: AppColor.red);
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          controller.todaysEarning.toString(),
                                          style: TextStyle(
                                              fontFamily: FontFamily.fontFamily,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.888,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColor.neutral_100,
                              border:
                              Border.all(color: AppColor.orange_100),
                              boxShadow: [
                                BoxShadow(
                                    color: AppColor.neutral_300.withOpacity(0.6),
                                    offset: const Offset(0, 3),
                                    spreadRadius: 4,
                                    blurRadius: 4)
                              ]),
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  "This month earning",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: FontFamily.fontFamily),
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 22,
                                      height: 22,
                                      child: Image.asset(
                                        "Assets/Images/coin.png",
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Icon(
                                              Icons.error_outline_outlined,
                                              size: 10,
                                              color: AppColor.red);
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      controller.thismonthEarning.toString(),
                                      style: TextStyle(
                                          fontFamily: FontFamily.fontFamily,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularPercentIndicator(
                              radius: 65.0,
                              lineWidth: 10.0,
                              animation: true,
                              percent: (controller.achivePrecentage/100),
                              center: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${controller.achivePrecentage.toStringAsFixed(2)} %",
                                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
                                  ),
                                  Text(
                                    "${controller.acheived} / ${controller.target}",
                                    style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 13.0),
                                  ),
                                ],
                              ),
                              circularStrokeCap: CircularStrokeCap.round,
                              progressColor: primaryColor,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.workingHr.isNotEmpty && controller.clockOutTime.isNotEmpty
                                ? {}
                                : controller.clockINOut(context);
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.888,
                                height: MediaQuery.of(context).size.height * 0.08,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: controller.workingHr.isNotEmpty
                                      ? AppColor.neutral_500
                                      : controller.clockInTime.isEmpty
                                      ? primaryColor
                                      : buttoncolor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColor.neutral_700.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 3,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("Assets/Images/click.png",
                                      height: 40,
                                      width: 32,
                                      color: AppColor.neutral_100,
                                      errorBuilder: (context, error, stackTrace) {
                                        return const Center(child: Icon(Icons.error_outline, color: AppColor.red, size: 25));
                                      },
                                    ),
                                    const SizedBox(width: 10),
                                    Text(controller.workingHr.isNotEmpty ? "CLOCK" : controller.clockInTime.isEmpty ?"CLOCK IN" : "CLOCK OUT",
                                    style: TextStyle(
                                      color: AppColor.neutral_100,
                                      fontFamily: FontFamily.fontFamily,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500
                                    ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Image.asset("Assets/Images/clockIn.png",
                                  height: 35,
                                  width: 35,
                                  color: AppColor.neutral_500,
                                ),
                                Text(controller.clockInTime.isNotEmpty ? controller.clockInTime : "__:__:__",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: AppColor.neutral_600,
                                      fontFamily: FontFamily.fontFamily),
                                ),
                                Text("Clock In",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.neutral_600,
                                      fontFamily: FontFamily.fontFamily),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset("Assets/Images/clockOut.png",
                                  height: 35,
                                  width: 35,
                                  color: AppColor.neutral_500,
                                ),
                                Text(controller.clockOutTime.isNotEmpty ? controller.clockOutTime : "__:__:__",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: AppColor.neutral_600,
                                      fontFamily: FontFamily.fontFamily),
                                ),
                                Text("Clock Out",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.neutral_600,
                                      fontFamily: FontFamily.fontFamily),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 35,
                                  width: 35,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset("Assets/Images/clockPause.png",
                                        height: 28,
                                        width: 28,
                                        color: AppColor.neutral_500,
                                      ),
                                    ],
                                  ),
                                ),
                                Text(controller.workingHr.isNotEmpty ? controller.workingHr : "__:__:__",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: AppColor.neutral_600,
                                      fontFamily: FontFamily.fontFamily),
                                ),
                                Text("Working Hours",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.neutral_600,
                                      fontFamily: FontFamily.fontFamily),
                                ),

                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Obx(() => Utility.loaderWidget(dashBoardScreenController.isLoading.value)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
