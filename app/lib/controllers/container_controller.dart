import 'package:amlportal/customs/v_data_service.dart';
import 'package:amlportal/customs/v_toast.dart';
import 'package:amlportal/screens/genre_screen.dart';
import 'package:amlportal/screens/library_screen.dart';
import 'package:amlportal/screens/home_screen.dart';
import 'package:amlportal/screens/sign_in_screen.dart';
import 'package:amlportal/screens/sign_up_screen.dart';
import 'package:amlportal/screens/upcoming_screen.dart';
import 'package:amlportal/screens/weekly_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../customs/v_sizes.dart';

class ContainerController extends GetxController {
  static ContainerController get instance => Get.find();
  final dataService = VDataService.instance;
  RxInt selectedIndex = 0.obs;
  List<Widget> viewList = [];
  //
  /*
  final KEY_CURRENT_LANGUAGE = 'CURRENT_LANGUAGE';
  Rx<Locale> currentLocal = Locale('en','US').obs;
  Locale enLocal = Locale('en','US');
  Locale arLocal = Locale('ar','AE');
  RxBool isEnglish = true.obs;
  */
  //

  @override
  void onInit() {
    super.onInit();
    viewList = [
      const HomeScreen(),
      const WeeklyScreen(),
      const GenreScreen(),
      const UpcomingScreen(),
      const LibraryScreen(),

    ];
  }

  showLoginAndSignUp(bool isLibrary) {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(VSizes.md),
      title: dataService.isEnglish.value ? "Account" : 'حساب',
      middleText: dataService.isEnglish.value ? 'Would you like to Sign in or Sign Up?' : 'هل ترغب في تسجيل الدخول أو التسجيل؟',
      confirm: ElevatedButton(
        onPressed: () async {
          Navigator.of(Get.overlayContext!).pop();
          Get.to(() => const SignUpScreen())!.then((value){
            if(isLibrary){
              final homeController = ContainerController.instance;
              homeController.selectedIndex.value = 3;
            }
          });
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            side: const BorderSide(color: Colors.white)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: VSizes.lg),
          child: Text(
            dataService.isEnglish.value ? 'Sign up' : 'اشتراك',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      cancel: ElevatedButton(
        onPressed: () async {
          Navigator.of(Get.overlayContext!).pop();
          Get.to(() => const SignInScreen())!.then((value){
            if(isLibrary){
              final homeController = ContainerController.instance;
              homeController.selectedIndex.value = 3;
            }
          });
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            side: const BorderSide(color: Colors.white)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: VSizes.lg),
          child: Text(
            dataService.isEnglish.value ? 'Sign in' : 'تسجيل الدخول',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }



  showLogOut(bool isLibrary) {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(VSizes.md),
      title: dataService.isEnglish.value ? "Account" : 'حساب',
      middleText: dataService.isEnglish.value ? 'Would you like to logout?' : 'هل ترغب في تسجيل الخروج؟',
      confirm: ElevatedButton(
        onPressed: () async {
          //dataService.user.value = UserModel.empty();
          dataService.deleteUser();
          Navigator.of(Get.overlayContext!).pop();
          VToast.showToastBar(title: dataService.isEnglish.value ? 'Sign out' : 'تسجيل الخروج', message: dataService.isEnglish.value ? 'Successfully' : 'بنجاح');
          final homeController = ContainerController.instance;
          homeController.selectedIndex.value = 0;
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            side: const BorderSide(color: Colors.white)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: VSizes.lg),
          child: Text(
            dataService.isEnglish.value ? 'Sign out' : 'تسجيل الخروج',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      cancel: ElevatedButton(
        onPressed: () async {
          Navigator.of(Get.overlayContext!).pop();
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            side: const BorderSide(color: Colors.white)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: VSizes.lg),
          child: Text(
            dataService.isEnglish.value ? 'Cancel' : 'يلغي',
            style: const TextStyle(color: Colors.green),
          ),
        ),
      ),
    );
  }

}
