import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vahan_cleaner/models/view_completed_subscription_response.dart';
import '../../../../get_controller_builder.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/font_family.dart';
import '../../../../utils/loading.dart';
import 'complete_screen_controller.dart';

class CompleteSubscriptionScreen extends StatefulWidget {
  const CompleteSubscriptionScreen({super.key});

  @override
  State<CompleteSubscriptionScreen> createState() => _CompleteSubscriptionScreenState();
}

class _CompleteSubscriptionScreenState extends State<CompleteSubscriptionScreen> {
  CompleteSubscriptionController completeScreenController = Get.put(CompleteSubscriptionController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CompleteSubscriptionController>(
        id: GetXControllerBuilders.completedScreenController,
        init: completeScreenController,
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: controller.pullRefresh,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: controller.searchController,
                          onChanged: (value) {
                            if (controller.searchController.text.isEmpty) {
                              controller.filteredCompleteVahans = controller.completeVahans ?? [];
                              controller.update([GetXControllerBuilders.completedScreenController]);
                            } else {
                              controller.filterCompleteVahanList(value);
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Search',
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
                                          fontFamily:
                                          FontFamily.fontFamily),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 22,
                                          height: 22,
                                          child: Image.asset("Assets/Images/coin.png", errorBuilder: (context, error, stackTrace) {
                                            return const Icon(Icons.error_outline_outlined, size: 10, color: AppColor.red);
                                          },),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(controller.balance.toString(),
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
                                          fontFamily:
                                          FontFamily.fontFamily),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 22,
                                          height: 22,
                                          child: Image.asset("Assets/Images/coin.png", errorBuilder: (context, error, stackTrace) {
                                            return const Icon(Icons.error_outline_outlined, size: 10, color: AppColor.red);
                                          },),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(controller.todaysEarning.toString(),
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
                            itemCount: controller.filteredCompleteVahans.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              CompleteVahan? completeVahanData = controller.filteredCompleteVahans[index];
                              return Container(
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          completeVahanData?.regNumber ?? "",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontFamily.fontFamily),
                                        ),
                                        Text(
                                          " ${completeVahanData?.brand ?? ""} ${completeVahanData?.model ?? ""}",
                                          style: TextStyle(
                                              fontFamily: FontFamily.fontFamily,
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
                                                " ${completeVahanData?.name ?? ""} (${completeVahanData?.flatInfo ?? ""})",
                                                style: TextStyle(
                                                    fontFamily: FontFamily.fontFamily,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                       Container(
                                         width: 35,
                                         height: 35,
                                         decoration: BoxDecoration(
                                           borderRadius: BorderRadius.circular(20),
                                           color: AppColor.green
                                         ),
                                         child: const Center(
                                           child: Icon(Icons.check, color: AppColor.neutral_100, size: 20),
                                         ),
                                       )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                ),
                Obx(() => Utility.loaderWidget(completeScreenController.isLoading.value)),
              ],
            ),
          );
        }
    );
  }
}
