import 'package:flutter/material.dart';
import '../../../app_routes/app_routes.dart';
import '../../../shared_preferences/local_data.dart';
import 'package:get/get.dart';
import '../../../utils/colors.dart';

class SplashFirst extends StatefulWidget {
  const SplashFirst({Key? key}) : super(key: key);

  @override
  State<SplashFirst> createState() => _SplashFirstState();
}

class _SplashFirstState extends State<SplashFirst> {

  @override
  void initState() {
    redirect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: lightColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Center(
              child: SizedBox(
                height: 40,
                child: Image.asset(
                  'Assets/Images/vahanlogo1.png',
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  ///Method use to call splash timer.
  redirect() {
    if(GetSfLocalStorage.getAuthToken() != "") {
      Future.delayed(
        const Duration(seconds: 4), () => Get.offAllNamed(AppRoutes.homePage)
      );
    } else {
      Future.delayed(
        const Duration(seconds: 4), () => Get.offAllNamed(AppRoutes.loginPage)
      );
    }
  }
}
