import 'package:amlportal/controllers/search_comic_controller.dart';
import 'package:amlportal/widgets/comic_vertical_card.dart';
import 'package:amlportal/widgets/verticalstraightCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/container_controller.dart';
import '../customs/v_data_service.dart';
import '../customs/v_sizes.dart';
import '../customs/v_toast.dart';
import '../models/comic_model.dart';
import '../widgets/comic_card.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final dataService = VDataService.instance;
    final refreshController = RefreshController(initialRefresh: true);
    final searchComicController = Get.put(SearchComicController());

    final homeController = Get.put(ContainerController());
    GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

    _handleDrawer() async {
      _key.currentState!.openEndDrawer();
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar:  AppBar(
        automaticallyImplyLeading: false,
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
      body: SmartRefresher(
        controller: refreshController,
        enablePullDown: true,
        onRefresh: () async{
          await searchComicController.searchComic();
          refreshController.refreshCompleted();
        },
        child: SingleChildScrollView(
          child: Column(

            children: [
              const Divider(),

              SizedBox(height: 10,),

            // Search Bar
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                        // Update search query in the controller
                        searchComicController.searchQuery.value = value;
                        searchComicController.filterComics();
                      },
                      style: const TextStyle(color: Colors.white), // White text color
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black, // Background color set to black
                        hintText: 'Search abmic/author',
                        hintStyle: const TextStyle(color: Colors.white54), // Hint text style
                        suffixIcon: const Icon(Icons.search, color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0), // Circular border
                          borderSide: const BorderSide(color: Colors.white, width: 1.5), // White border
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: Colors.white, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: Colors.white, width: 2.0),
                        ),
                      ),
                    ),
                  ),
                  Obx(() {
                    // Dynamically update the result count
                    final resultsCount = searchComicController.filteredComics.length;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Results Found: $resultsCount',
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    );
                  }),
                ],
              ),


              SizedBox(height: 5,),
              
              Text("Top Abmic Searched", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),



              Padding(
                padding: const EdgeInsets.all(VSizes.sm),
                child: Obx(() {
                  if (searchComicController.filteredComics.isEmpty) {
                    return const SizedBox(height: 0.0);
                  } else {
                    return ListView.builder(
                        itemCount: searchComicController.filteredComics.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: VSizes.xs),
                            child: ComicVerticalCard(
                              comic: searchComicController.filteredComics[index],
                            ),
                          );
                        });
                  }
                }),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class MyColor extends WidgetStateColor {
  const MyColor() : super(_defaultColor);

  static const int _defaultColor = 0xcafefeed;
  static const int _pressedColor = 0xdeadbeef;

  @override
  Color resolve(Set<WidgetState> states) {
    if (states.contains(WidgetState.pressed)) {
      return const Color(_pressedColor);
    }
    return const Color(_defaultColor);
  }
}