// import 'package:flutter/material.dart';
// import 'package:fuelio/app_routes/app_routes.dart';
// import 'package:fuelio/screen/car_wash_management/car_intro_screen.dart';
// import 'package:fuelio/screen/know_your_vahan_management/intro_screen.dart';
// import 'package:fuelio/utils/colors.dart';
// import '../../shared_preferences/local_data.dart';
// import '../fuel_management/fuel_log_page/fuel_log_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_svg/svg.dart';
// import '../vehicle/add_vehicles_pages/add_vehicle_screen.dart';
// import '../vehicle/add_vehicles_pages/all_brand_view.dart';
// import '../vehicle/all_vehicles_list_page/all_vehiceles_screen.dart';
// import 'package:get/get.dart';
//
// class DrawerFuel extends StatefulWidget {
//   const DrawerFuel({Key? key}) : super(key: key);
//
//   @override
//   State<DrawerFuel> createState() => _DrawerFuelState();
// }
//
// class _DrawerFuelState extends State<DrawerFuel> {
//   final auth = FirebaseAuth.instance;
//   final _googleSignIn = GoogleSignIn();
//
//   signOut() async {
//     await auth.signOut();
//     await _googleSignIn.signOut();
//   }
//
//   Future<void> logout() async {
//     await GoogleSignIn().disconnect();
//     FirebaseAuth.instance.signOut();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: ClipRRect(
//       borderRadius: const BorderRadius.only(
//         topRight: Radius.circular(30),
//         bottomRight: Radius.circular(30),
//       ),
//       child: Drawer(
//         child: ListView(children: [
//           DrawerHeader(
//               padding: EdgeInsets.all(
//                 60,
//               ),
//               child: Image.asset(
//                 'Assets/Images/vahanlogo1.png',
//                 width: 10,
//               )),
//           ListTile(
//             leading: Icon(
//               Icons.home,
//               size: 28,
//               color: primaryColor,
//             ),
//             onTap: () {
//               Get.back();
//               Get.offAllNamed(AppRoutes.homePageScreen);
//             },
//             title: Text("Home",
//                 style: TextStyle(
//                     color: const Color(0xff000000).withOpacity(0.6),
//                     fontSize: 15,
//                     fontFamily: 'Inter')),
//             trailing: Icon(
//               Icons.keyboard_arrow_right,
//               size: 28,
//               color: primaryColor,
//             ),
//           ),
//           Divider(),
//           ListTile(
//             leading: SvgPicture.asset(
//               'Assets/Images/Promotion.svg',
//               width: 40,
//               height: 40,
//             ),
//             trailing: const Icon(
//               Icons.keyboard_arrow_right,
//               size: 28,
//               color: primaryColor,
//             ),
//             onTap: () {
//               setState(() {
//                 // vehiclesCon.Getvehicle ();
//               });
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const FuelLogScreen()));
//             },
//             title: Text('Fuel Management',
//                 style: TextStyle(
//                     color: const Color(0xff000000).withOpacity(0.6),
//                     fontSize: 15,
//                     fontFamily: 'Inter')),
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.car_repair_sharp,
//               size: 28,
//               color: primaryColor,
//             ),
//             trailing: const Icon(
//               Icons.keyboard_arrow_right,
//               size: 28,
//               color: primaryColor,
//             ),
//             onTap: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => AllVahanBrandScreen()));
//             },
//             title: Text('Add Vehicles',
//                 style: TextStyle(
//                     color: const Color(0xff000000).withOpacity(0.6),
//                     fontFamily: 'Inter',
//                     fontSize: 15)),
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.heat_pump_outlined,
//               size: 28,
//               color: primaryColor,
//             ),
//             trailing: const Icon(
//               Icons.keyboard_arrow_right,
//               size: 28,
//               color: primaryColor,
//             ),
//             onTap: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => AllVehiclesScreen()));
//             },
//             title: Text('All Vehicles',
//                 style: TextStyle(
//                     color: const Color(0xff000000).withOpacity(0.6),
//                     fontSize: 15,
//                     fontFamily: 'Inter')),
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.car_repair_sharp,
//               size: 28,
//               color: primaryColor,
//             ),
//             trailing: const Icon(
//               Icons.keyboard_arrow_right,
//               size: 28,
//               color: primaryColor,
//             ),
//             onTap: () {
//               Get.back();
//               Get.toNamed(AppRoutes.viewSubscriptionDetails);
//             },
//             title: Text('View Subscription',
//                 style: TextStyle(
//                     color: const Color(0xff000000).withOpacity(0.6),
//                     fontFamily: 'Inter',
//                     fontSize: 15)),
//           ),
//           Divider(),
//           // Car Wash
//           ListTile(
//             leading: SvgPicture.asset(
//               'Assets/Images/Promotion1.svg',
//               width: 40,
//               height: 40,
//             ),
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => CarWashIntroScreen()));
//             },
//             title: Text("Car Wash",
//                 style: TextStyle(
//                     color: const Color(0xff000000).withOpacity(0.6),
//                     fontFamily: 'Inter',
//                     fontSize: 15)),
//             trailing: Icon(
//               Icons.keyboard_arrow_right,
//               size: 28,
//               color: primaryColor,
//             ),
//           ),
//           Divider(),
//           // Know your vahan
//           ListTile(
//             leading: SvgPicture.asset(
//               'Assets/Images/Promotion2.svg',
//               width: 40,
//               height: 40,
//             ),
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => KnowYourVahanIntroScreen()));
//             },
//             title: Text("Know Your Vahan",
//                 style: TextStyle(
//                     color: const Color(0xff000000).withOpacity(0.6),
//                     fontFamily: 'Inter',
//                     fontSize: 15)),
//             trailing: Icon(
//               Icons.keyboard_arrow_right,
//               size: 28,
//               color: primaryColor,
//             ),
//           ),
//
//           const SizedBox(height: 20),
//           InkWell(
//             onTap: () async {
//               GetSfLocalStorage.clear();
//               Get.offAllNamed(AppRoutes.loginPage);
//             },
//             child: Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 20),
//                 alignment: Alignment.center,
//                 height: 50,
//                 width: 250,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   color: buttoncolor,
//                 ),
//                 child: const Text(
//                   'Log Out',
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20,
//                       fontFamily: 'Inter'),
//                 )
//                 // color: primaryColor,
//                 ),
//           ),
//           SizedBox(
//             height: 30,
//           )
//         ]),
//       ),
//     ));
//   }
// }
