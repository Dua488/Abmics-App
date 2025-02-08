import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/container_controller.dart';
import '../controllers/episode_controller.dart';
import '../customs/v_sizes.dart';
import '../customs/v_toast.dart';
import '../models/comic_model.dart';
import '../screens/search_screen.dart';
import '../widgets/episode_card.dart';
import 'container_screen.dart';

class EpisodeScreen extends StatelessWidget {
  const EpisodeScreen({super.key, required this.comic});

  final ComicModel comic;

  @override
  Widget build(BuildContext context) {
    final refreshController = RefreshController(initialRefresh: true);
    final episodeController = Get.put(EpisodeController());
    final homeController = Get.put(ContainerController());
    GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

    _handleDrawer() async {
      _key.currentState!.openEndDrawer();
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black, // Header color set to black

        title: SizedBox(
          height: 120,
          child: IconButton(
            onPressed: () async {
              Get.offAll(() => const ContainerScreen());  // Replace with your main page widget
            },
            icon: Image.asset(
              'assets/abmics_logo.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        centerTitle: true,


        actions: [
          Obx(
                () => TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  side: BorderSide(
                    color: homeController.dataService.isFamilySafe.value
                        ? Colors.green // Default to green if family safe is active
                        : Colors.white, // Change to white if family safe is inactive
                    width: 2,
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
                  style: Theme.of(context).textTheme.titleSmall!.apply(
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
                          _key.currentState?.closeEndDrawer();
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
        onRefresh: () async {
          await episodeController.getEpisodeByComicId(comic.comic_id);
          refreshController.refreshCompleted();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10), // Space between AppBar and Image

              // Display Comic Image (Only if it's valid)
              ComicImageWidget(imageUrl: comic.thumbnail),

              const SizedBox(height: 10), // Space between Image and Episodes

              // Display List of Episodes
              Obx(() {
                if (episodeController.episodeList.isEmpty) {
                  return const SizedBox(height: 0.0);
                } else {
                  return ListView.builder(
                    itemCount: episodeController.episodeList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: VSizes.xs),
                        child: EpisodeCart(
                          episode: episodeController.episodeList[index],
                        ),
                      );
                    },
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget to Handle Image Errors Without Placeholder
class ComicImageWidget extends StatefulWidget {
  final String imageUrl;
  const ComicImageWidget({super.key, required this.imageUrl});

  @override
  _ComicImageWidgetState createState() => _ComicImageWidgetState();
}

class _ComicImageWidgetState extends State<ComicImageWidget> {
  bool _imageError = false;

  @override
  void initState() {
    super.initState();
    // Preload image to check if it's valid
    Image.network(widget.imageUrl).image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener(
            (ImageInfo image, bool synchronousCall) {
          if (mounted) {
            setState(() {
              _imageError = false; // Image loaded successfully
            });
          }
        },
        onError: (dynamic exception, StackTrace? stackTrace) {
          if (mounted) {
            setState(() {
              _imageError = true; // Image failed to load
            });
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_imageError || widget.imageUrl.isEmpty) {
      return const SizedBox.shrink(); // Hide image if it fails
    }

    String encodedUrl = Uri.encodeFull(widget.imageUrl);
    String secureUrl = encodedUrl.replaceFirst('http://', 'http://');

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 250,
      child: Image.network(
        secureUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const SizedBox.shrink(); // Hide the image if it fails
        },
      ),
    );
  }
}
