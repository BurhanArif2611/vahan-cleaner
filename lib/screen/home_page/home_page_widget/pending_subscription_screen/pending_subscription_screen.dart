import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vahan_cleaner/utils/loading.dart';
import '../../../../app_routes/app_routes.dart';
import '../../../../get_controller_builder.dart';
import '../../../../models/view_pending_subscription_response.dart';
import '../../../../shared_preferences/local_data.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/font_family.dart';
import 'pending_subscription_controller.dart';

class PendingSubscriptionScreen extends StatefulWidget {
  const PendingSubscriptionScreen({super.key});

  @override
  State<PendingSubscriptionScreen> createState() =>
      _PendingSubscriptionScreenState();
}

class _PendingSubscriptionScreenState extends State<PendingSubscriptionScreen> {
  PendingSubscriptionController homePageController = Get.put(PendingSubscriptionController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PendingSubscriptionController>(
        id: GetXControllerBuilders.pendingScreenController,
        init: homePageController,
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: controller.pullRefresh,
            child: Stack(
              children: [
                SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: controller.searchController,
                          onChanged: (value) {
                            if (controller.searchController.text.isEmpty) {
                              controller.filteredList =
                                  controller.pendingVahans ?? [];
                              controller.update([
                                GetXControllerBuilders.pendingScreenController
                              ]);
                            } else {
                              controller.filterList(value);
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Search among ${controller.pendingVahans?.length ?? 0} vehicles',
                            contentPadding: EdgeInsets.zero,
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
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
                                  border: Border.all(color: AppColor.orange_100),
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
                                            errorBuilder: (context, error, stackTrace) {
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
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColor.neutral_100,
                                  border: Border.all(color: AppColor.orange_100),
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
                                      "Today's earning",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontFamily.fontFamily),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 22,
                                          height: 22,
                                          child: Image.asset(
                                            "Assets/Images/coin.png",
                                            errorBuilder: (context, error, stackTrace) {
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
                        ListView.builder(
                            itemCount: controller.filteredList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              Vahan? vahanData = controller.filteredList[index];
                              return GestureDetector(
                                onTap: () {
                                  if (GetSfLocalStorage.getClockOutTime().isEmpty) {
                                    Get.toNamed(AppRoutes.addVahan, arguments: {
                                      "vahanData": vahanData,
                                      "baseUrl": controller.imageBaseUrl,
                                      "isOther": false,
                                      "locationName" : "${vahanData.flatInfo ?? ""}, ${vahanData.locationName ?? ""}"
                                    });
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: AppColor.neutral_100,
                                      border: Border.all(
                                          color: AppColor.orange_100),
                                      boxShadow: [
                                        BoxShadow(
                                            color: AppColor.neutral_300
                                                .withOpacity(0.6),
                                            offset: const Offset(0, 3),
                                            spreadRadius: 4,
                                            blurRadius: 4)
                                      ]),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            vahanData.regNumber ?? "",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                fontFamily:
                                                    FontFamily.fontFamily),
                                          ),
                                          Text(
                                            " ${vahanData.brand ?? ""} ${vahanData.model ?? ""}",
                                            style: TextStyle(
                                                fontFamily:
                                                    FontFamily.fontFamily,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15),
                                          ),
                                          Row(
                                            children: [
                                              const Icon(Icons.person,
                                                  color: AppColor.orange,
                                                  size: 18),
                                              SizedBox(
                                                width: 198,
                                                child: Text(
                                                  " ${vahanData.name ?? ""}",
                                                  style: TextStyle(
                                                      fontFamily:
                                                          FontFamily.fontFamily,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 70,
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom: 10),
                                                child: Text(
                                                  "+${vahanData.points}",
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: FontFamily.fontFamily,
                                                      color: AppColor.successGreen
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Icon(
                                                  Icons.watch_later_outlined,
                                                  color: AppColor.neutral_500,
                                                  size: 14),
                                              Text(
                                                " ${vahanData.readyTime}",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontFamily.fontFamily),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Icon(Icons.location_on,
                                                  color: AppColor.neutral_500,
                                                  size: 14),
                                              Text(
                                                (vahanData.parkingLocation ??
                                                    ""),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontFamily.fontFamily),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                ),
                Obx(() =>
                    Utility.loaderWidget(homePageController.isLoading.value)),
              ],
            ),
          );
        });
  }
}
