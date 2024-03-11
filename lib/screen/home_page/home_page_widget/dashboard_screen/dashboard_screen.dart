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
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.40,
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
                                        "20",
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
                                        "20",
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
                                    "20",
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
                      CircularPercentIndicator(
                        radius: 65.0,
                        lineWidth: 10.0,
                        animation: true,
                        percent: 0.7,
                        center: const Text(
                          "70.0%",
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
                        ),
                        footer: const Text(
                          "Target completed",
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17.0),
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: AppColor.primary,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.clockIn();
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: controller.isMark
                                      ? [AppColor.green_400.withOpacity(0.5),
                                         AppColor.green_500]
                                      : [AppColor.red_400.withOpacity(0.5),
                                         AppColor.red_500],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColor.neutral_700.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(controller.isMark ? "CLOCK IN" : "CLOCK OUT",
                                style: TextStyle(
                                  color: AppColor.neutral_100,
                                  fontFamily: FontFamily.fontFamily,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500
                                ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Obx(() => Utility.loaderWidget(dashBoardScreenController.isLoading.value)),
            ],
          ),
        );
      },
    );
  }
}
