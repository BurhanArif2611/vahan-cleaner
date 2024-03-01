import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_routes/app_routes.dart';
import '../../get_controller_builder.dart';
import '../../models/view_pending_subscription_response.dart';
import '../../utils/colors.dart';
import '../../utils/font_family.dart';
import '../../widget/common_app_bar.dart';
import 'home_controller.dart';
import 'home_page_widget/complete_screen.dart';
import 'home_page_widget/pending_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  /// List of screens for each bottom navigation bar item
  static const List<Widget> screens = [
    /// Add your pending screen here
    PendingScreen(),
    /// Add your completed screen here
    CompleteScreen(),
  ];

  /// Function to handle bottom navigation bar item tap
  void _onItemTapped(int index) {
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.pending_actions),
            label: 'Pending',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Completed',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      body: screens[selectedIndex],
    );
  }
}
