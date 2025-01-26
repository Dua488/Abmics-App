import 'package:amlportal/controllers/container_controller.dart';
import 'package:amlportal/customs/v_toast.dart';
import 'package:amlportal/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../customs/v_sizes.dart';

class ContainerScreen extends StatelessWidget {
  const ContainerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(ContainerController());
    GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

    _handleDrawer() async {
      _key.currentState!.openEndDrawer();
    }

    return Scaffold(
      backgroundColor: Colors.black,
      key: _key,
      endDrawerEnableOpenDragGesture: false,
      appBar: AppBar(
        backgroundColor: Colors.black, // Header color set to black

        title: SizedBox(
          
          height: 90, // Adjust the height
          child: IconButton(
            onPressed: () async {
              final url = Uri.parse("https://abmics.com/");
              await launchUrl(url);
            },
            icon: Image.asset(
              'assets/abmics_logo.png',
              fit: BoxFit.contain, // Ensures the logo scales properly
            ),
          ),
        ),
        centerTitle: true, // Center the logo in the AppBar
      
        actions: [
          Obx(
                () => TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  side: BorderSide(
                    color: homeController.dataService.isFamilySafe.value
                        ? Colors.green // Default to green if family safe is active
                        : Colors.white, // Change to white if family safe is inactive
                    width: 3,
                  ),
                ),
              ),
              onPressed: () async {
                // Toggle family safe value
                bool newFamilySafeValue = !homeController.dataService.isFamilySafe.value;
                homeController.dataService.setFamilySafe(newFamilySafeValue);

                // Send request to the API
                int familySafeValue = newFamilySafeValue ? 1 : 0;
                await homeController.dataService.isFamilySafe();
              },
              child: Obx(
                    () => Text(
                  '• ' +
                      (homeController.dataService.isEnglish.value
                          ? 'Family Safe'
                          : 'عائلة آمنة'),
                  style: Theme.of(context).textTheme.titleMedium!.apply(
                    color: homeController.dataService.isFamilySafe.value
                        ? Colors.green // Default text color for active state
                        : Colors.white, // Text color for inactive state
                  ),
                ),
              ),
            ),
          ),


          IconButton(
            onPressed: () {
             //
            },
            icon: const Icon(Icons.wallet_giftcard_outlined, color: Colors.white),
          ),


          IconButton(
            onPressed: () {
              Get.to(() => const SearchScreen());
            },
            icon: const Icon(Icons.search, color: Colors.white),
          ),
          IconButton(
            onPressed: () async {
              await _handleDrawer();
            },
            icon: const Icon(Icons.menu, color: Colors.white),
          ),
        ],
      ),
      endDrawer: Drawer(
        backgroundColor: Colors.black.withOpacity(0.7), // Drawer color retained
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(VSizes.xs),
            child: Column(
              children: [
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          _key.currentState!.closeEndDrawer();
                        },
                        icon: const Icon(Icons.close, color: Colors.white))
                  ],
                ),
                const SizedBox(height: VSizes.spaceBtwItems),
                const Divider(),
                const SizedBox(height: VSizes.spaceBtwItems),
                Obx(() {
                  var str = '';
                  var bgColor = Colors.green;
                  if (homeController.dataService.user.value.display_name
                      .isEmpty) {
                    str = homeController.dataService.isEnglish.value
                        ? 'Sign in'
                        : 'تسجيل الدخول';
                  } else {
                    str = homeController.dataService.isEnglish.value
                        ? 'Sign out'
                        : 'تسجيل الخروج';
                    bgColor = Colors.red;
                  }
                  return ElevatedButton(
                    onPressed: () async {
                      if (homeController.dataService.user.value.display_name
                          .isEmpty) {
                        await homeController.showLoginAndSignUp(false);
                      } else {
                        await homeController.showLogOut(
                            homeController.selectedIndex.value == 3);
                      }
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: bgColor),
                    child: Text(
                      str,
                      style: Theme.of(context).textTheme.titleMedium!.apply(
                        color: Colors.white,
                      ),
                    ),
                  );
                }),
                const SizedBox(height: VSizes.spaceBtwItems),
                const Divider(),
                Container(
                  height: 70,
                  width: double.infinity,
                  child: InkWell(
                    onTap: () {
                      homeController.dataService.isEnglish.value =
                      !homeController.dataService.isEnglish.value;
                      VToast.showToastBar(
                        title: homeController.dataService.isEnglish.value
                            ? 'Application Language'
                            : 'لغة التطبيق',
                        message: homeController.dataService.isEnglish.value
                            ? 'Language is changed to English'
                            : 'تم تغيير اللغة إلى العربية',
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(VSizes.xs),
                      child: Row(
                        children: [
                          const Icon(Icons.language,
                              size: 30, color: Colors.white),
                          const SizedBox(width: VSizes.md),
                          Expanded(
                            child: Obx(
                                  () => Text(
                                homeController.dataService.isEnglish.value
                                    ? 'Application Language'
                                    : 'لغة التطبيق',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .apply(color: Colors.white),
                              ),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios_sharp,
                              color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
      body: Obx(() {
        return homeController.viewList[homeController.selectedIndex.value];
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: const Icon(Icons.home, color: Colors.white),
              label: homeController.dataService.isEnglish.value ? 'Home' : 'بيت',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: const Icon(Icons.layers_outlined, color: Colors.white),
              label:
              homeController.dataService.isEnglish.value ? 'Genres' : 'الأنواع',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: const Icon(Icons.calendar_month, color: Colors.white),
              label:
              homeController.dataService.isEnglish.value ? 'Weekly' : 'أسبوعي',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: const Icon(Icons.timer, color: Colors.white),
              label:
              homeController.dataService.isEnglish.value ? 'Upcoming' : 'قادم',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: const Icon(Icons.menu_book_outlined, color: Colors.white),
              label: homeController.dataService.isEnglish.value
                  ? 'Library'
                  : 'مكتبة',
            ),
          ],
          currentIndex: homeController.selectedIndex.value,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.6),
          backgroundColor: Colors.black,
          onTap: (index) async {
            if (index >= 0 && index < homeController.viewList.length) {
              if (index == 5) { // "Library" tab is index 4
                final loggedIn = homeController.dataService.user.value.display_name.isNotEmpty;
                if (!loggedIn) {
                  await homeController.showLoginAndSignUp(true);
                } else {
                  homeController.selectedIndex.value = index;
                }
              } else {
                homeController.selectedIndex.value = index;
              }
            } else {
              print('Invalid index tapped: $index');
            }
          },
        );
      }),
    );
  }
}
