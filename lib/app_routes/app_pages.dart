import 'package:get/get.dart';
import '../screen/authentication/log_in/login_screen.dart';
import '../screen/home_page/add_vahan_page.dart';
import '../screen/home_page/home_page_screen.dart';
import 'app_routes.dart';

class AppPages {
  static const Duration duration = Duration(milliseconds: 500);
  static const Transition transition = Transition.cupertino;

  static getPages() {
    var pages = [
      GetPage(
        transitionDuration: duration,
        transition: transition,
        popGesture: false,
        name: AppRoutes.loginPage,
        page: () => const LoginScreen(),
      ),
      GetPage(
        transitionDuration: duration,
        transition: transition,
        popGesture: false,
        name: AppRoutes.homePage,
        page: () => const HomeScreen(),
      ),
      GetPage(
        transitionDuration: duration,
        transition: transition,
        popGesture: false,
        name: AppRoutes.addVahan,
        page: () => AddVehicleScreen(),
      ),
    ];
    return pages;
  }
}
