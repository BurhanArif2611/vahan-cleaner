import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../get_controller_builder.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../../../utils/colors.dart';
import '../../../utils/font_family.dart';
import '../../../utils/loading.dart';
import 'login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            GetBuilder<LoginController>(
                id: GetXControllerBuilders.loginController,
                init: loginController,
                builder: (controller) {
                return Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: SizedBox(
                          height: 25,
                          child: Image.asset(
                            'Assets/Images/vahanlogo1.png',
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                          child: Text(
                            "Welcome Cleaner,",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold, fontFamily: FontFamily.fontFamily),
                          ),),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 22),
                        child: Center(
                          child: Text(
                            "Its time to unlock earning opportunity with Vahan Plus.",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontFamily: FontFamily.fontFamily),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: commonTextLabel(label: "Mobile Number"),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: controller.emailController,
                          keyboardType: TextInputType.number,
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Please enter your mobile number."),
                          ]),
                         decoration: commonDecoration(hintText: "Enter mobile number")
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: commonTextLabel(label: "Password"),
                      ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: controller.passwordController,
                            keyboardType: TextInputType.number,
                            validator: MultiValidator([
                                RequiredValidator(
                                    errorText: "Please enter your password"),
                              ]),
                              obscureText: controller.isVisibility ? true : false,
                              decoration: commonDecoration(
                                hintText: "Enter password",
                                suffixIcon: IconButton(
                                  icon: controller.isVisibility
                                      ? const Icon(Icons.visibility_off_outlined,
                                          color: AppColor.orange)
                                      : const Icon(Icons.visibility_outlined,
                                          color: AppColor.orange),
                                  onPressed: controller.isPasswordVisible,
                                ),
                              ),
                          ),
                        ),
                        const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: GestureDetector(
                          onTap: () {
                            if(controller.formKey.currentState?.validate() ?? false) {
                              controller.loginApiWithPassword(context);
                            }
                          },
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            width: double.infinity,
                            height: 50,
                            decoration: const BoxDecoration(
                              color: AppColor.orange,
                              borderRadius:
                              BorderRadius.all(Radius.circular(12)),
                            ),
                            child: Center(
                              child: Text(
                                'LOGIN',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    fontFamily: FontFamily.fontFamily,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 29),
                    ],
                  ),
                );
              }
            ),
            Obx(
                  () => Utility.loaderWidget(loginController.isLoading.value),
            )
          ],
        ),
      ),
    );
  }

  /// Method use for text field decoration.
  InputDecoration commonDecoration({required String hintText, Widget? suffixIcon}) {
    return InputDecoration(
      fillColor: AppColor.neutral_300.withOpacity(0.5),
      filled: true,
      hintText: hintText,
      hintStyle: const TextStyle(
          color: AppColor.neutral_500,
          fontWeight: FontWeight.normal,
          fontSize: 14
      ),
      suffixIcon: suffixIcon,
      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      border: OutlineInputBorder(
        borderSide: const BorderSide(width: 0.7, color: AppColor.neutral_400),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 0.7, color: AppColor.neutral_400),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 0.7, color: AppColor.orange_400),
        borderRadius: BorderRadius.circular(8),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 0.7, color: AppColor.red),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 0.7, color: AppColor.red),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  /// Common text label
  Widget commonTextLabel({required String label}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0, top: 10),
      child: Row(
        children: [
          Text(label, textAlign: TextAlign.start, style: TextStyle(
              color: AppColor.neutral_700,
              fontWeight: FontWeight.w600,
              fontFamily: FontFamily.fontFamily
          ),),
        ],
      ),
    );
  }
}
