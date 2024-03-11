import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vahan_cleaner/screen/authentication/splash/splash_first.dart';
import 'app_routes/app_pages.dart';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 600),
      builder: (context, child) {
        return GetMaterialApp(
          home: const SplashFirst(),
          debugShowCheckedModeBanner: false,
          getPages: AppPages.getPages(),
        );
      },
    );
  }
}

