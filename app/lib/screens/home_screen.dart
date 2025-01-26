import 'package:amlportal/controllers/home_controller.dart';
import 'package:amlportal/customs/v_data_service.dart';
import 'package:amlportal/customs/v_sizes.dart';
import 'package:amlportal/models/comic_model.dart';
import 'package:amlportal/screens/search_screen.dart';
import 'package:amlportal/widgets/comic_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../customs/v_shimmer.dart';
import '../widgets/comic_card_with_title.dart';
import '../widgets/vertical_card_with_section.dart';
import 'episode_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final refreshController = RefreshController(initialRefresh: true);
    final homeController = Get.put(HomeController());
    final CarouselSliderController carouselController = CarouselSliderController();

    return SmartRefresher(
      controller: refreshController,
      enablePullDown: true,
      onRefresh: () async{
        await homeController.refreshHome();
        refreshController.refreshCompleted();
      },
      child: SingleChildScrollView(

        child:  Padding(
              padding: const EdgeInsets.all(VSizes.xs),
              child: Column(
                children: [
                  Obx(() {
                    if (homeController.carouselList.isEmpty) {
                      return Center(
                          child: Image.asset('assets/bg.png',
                              opacity: const AlwaysStoppedAnimation(.1)));
                    } else {
                      return SizedBox(
                        width: double.infinity,
                        height: 300, // Adjust height for vertical card design
                        child: Column(
                          children: [
                            Expanded(
                              child: CarouselSlider(
                                carouselController: carouselController,
                                options: CarouselOptions(
                                    onPageChanged: (index, reason) {
                                      homeController.carouselIndex.value = index;
                                    },
                                    viewportFraction: 0.8, // Adjust to show partial next card
                                    height: 250.0,
                                    autoPlay: true,
                                    enableInfiniteScroll: true,
                                    autoPlayInterval: const Duration(seconds: 3)),
                                items: homeController.carouselList.map((i) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return InkWell(
                                        onTap: () {
                                          Get.to(() => EpisodeScreen(comic: i));
                                        },
                                        child: Card(
                                          elevation: 5,
                                          margin: const EdgeInsets.symmetric(horizontal: 10),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(0)),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              // Episode Image
                                              Expanded(
                                                flex: 3,
                                                child: ClipRRect(
                                                  borderRadius: const BorderRadius.vertical(
                                                      top: Radius.circular(0)),
                                                  child: CachedNetworkImage(
                                                    fit: BoxFit.cover,
                                                    imageUrl: i.thumbnail,
                                                    progressIndicatorBuilder:
                                                        (context, url, downloadProgress) =>
                                                    const VShimmerEffect(
                                                        width: double.infinity,
                                                        height: 150),
                                                  ),
                                                ),
                                              ),
                                              // Title of the Episode
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  padding: const EdgeInsets.all(10.0),
                                                  alignment: Alignment.centerLeft,
                                                  decoration: const BoxDecoration(
                                                    borderRadius: BorderRadius.vertical(
                                                        bottom: Radius.circular(0)),
                                                    color: Colors.black,
                                                  ),
                                                  child: Text(
                                                    homeController.dataService.isEnglish.value
                                                        ? i.title_en
                                                        : i.title_ar,
                                                    style: const TextStyle(
                                                        color: Colors.white, fontSize: 16.0),
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(
                              height: VSizes.spaceBtwItems,
                            ),
                            homeController.carouselList.length > 1
                                ? Center(
                              child: AnimatedSmoothIndicator(
                                onDotClicked: (index) {
                                  // _controller.jumpToPage(index);
                                },
                                activeIndex: homeController.carouselIndex.value,
                                count: homeController.carouselList.length,
                                effect: const ExpandingDotsEffect(
                                    activeDotColor: Colors.green, dotHeight: 6),
                              ),
                            )
                                : const SizedBox(width: 0),
                            const Divider(),
                            const SizedBox(
                              height: VSizes.spaceBtwItems,
                            ),
                          ],
                        ),
                      );
                    }
                  }),






                  Obx((){
                    if(homeController.recentComicList.isEmpty){
                      return const SizedBox(height: 0.0,);
                    }
                    else{
                      return ComicHorizontalListWithSection(title: homeController.dataService.isEnglish.value ? "New Comics" : "كاريكاتير جديد", comicList: homeController.recentComicList);
                    }
                  }),
                  const SizedBox(height: VSizes.spaceBtwItems,),
                  Obx((){
                    if(homeController.popularComicList.isEmpty){
                      return const SizedBox(height: 0.0,);
                    }
                    else{
                      return ComicVerticalGridWithSection(title: homeController.dataService.isEnglish.value ? "Popular Comics" : "كاريكاتير شعبية", comicList: homeController.popularComicList);

                    }

                  }),
                ],
              )
          ),
        ),

    );
  }
}


