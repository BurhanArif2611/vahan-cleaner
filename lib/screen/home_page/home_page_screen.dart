import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_routes/app_routes.dart';
import '../../get_controller_builder.dart';
import '../../models/view_pending_subscription_response.dart';
import '../../utils/colors.dart';
import '../../utils/colors.dart';
import '../../utils/font_family.dart';
import '../../utils/snackbar.dart';
import '../../widget/common_app_bar.dart';
import 'home_page_widget/dashboard_screen/dashboard_screen.dart';
import 'home_page_widget/dashboard_screen/dashboard_screen_controller.dart';
import 'home_page_widget/other_subscription_screen/other_subscription_screen.dart';
import 'home_page_widget/pending_subscription_screen/pending_subscription_controller.dart';
import 'home_page_widget/complete_subscription_screen/complete_subscription_screen.dart';
import 'home_page_widget/pending_subscription_screen/pending_subscription_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DashBoardScreenController dashBoardScreenController = Get.put(DashBoardScreenController());
  int selectedIndex = 0;

  /// List of screens for each bottom navigation bar item
  static const List<Widget> screens = [
    /// Add your dashboard screen here
    DashBoardScreen(),
    /// Add your pending screen here
    PendingSubscriptionScreen(),
    /// Add your completed screen here
    CompleteSubscriptionScreen(),
    /// Add your other screen here
    OtherSubscriptionScreen(),
  ];

  /// Function to handle bottom navigation bar item tap
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.neutral_200,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: CustomAppBar(isBack: false)),
      bottomNavigationBar: GetBuilder(
          init: dashBoardScreenController,
          id: GetXControllerBuilders.dashBoardScreenController,
          builder: (controller) {
          return BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.pending_actions),
                label: 'My Pending',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.check_circle),
                label: 'My Completed',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.other_houses_outlined),
                label: 'Others',
              ),
            ],
            currentIndex: selectedIndex,
            showUnselectedLabels: true,
            selectedLabelStyle: const TextStyle(
              color: AppColor.neutral_500,
            ),
            unselectedLabelStyle: const TextStyle(
              color: AppColor.neutral_500,
            ),
            selectedItemColor:  buttoncolor,
            unselectedItemColor:  AppColor.neutral_500,
            backgroundColor: AppColor.orange_300,
            onTap: (index) {
              if(controller.clockInTime.isNotEmpty) {
                  onItemTapped(index);
                } else {
                setSnackBar("Clock in first to proceed.", context, false);
              }
              },
          );
        }
      ),
      body: screens[selectedIndex],
    );
  }
}