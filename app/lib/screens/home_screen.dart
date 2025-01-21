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
                  Obx((){
                    if(homeController.carouselList.isEmpty){
                      //return const SizedBox(height: 0.0);
                      return Center(child: Image.asset('assets/bg.png', opacity: const AlwaysStoppedAnimation(.1)));
                    }
                    else{
                      return SizedBox(
                        width: double.infinity,
                        height: 250,
                        child: Column(
                          children: [
                            Expanded(
                                child: CarouselSlider(
                                  carouselController: carouselController,
                                  options: CarouselOptions(
                                      onPageChanged: (index, reason){
                                        homeController.carouselIndex.value = index;
                                      },
                                      viewportFraction: 1.0,
                                      height: 200.0,
                                      autoPlay: true,
                                      enableInfiniteScroll: true,
                                      autoPlayInterval: const Duration(seconds: 3)
                                  ),
                                  items: homeController.carouselList.map((i) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return InkWell(
                                          onTap: (){
                                            Get.to(()=> EpisodeScreen(comic: i));
                                          },
                                          child: Stack(
                                            children:[
                                              Container(
                                                width: MediaQuery.of(context).size.width,
                                                decoration: BoxDecoration(color: Colors.grey.withOpacity(0.3)),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.fitWidth,
                                                  //imageUrl: "https://abmics.com/wp_image.php?url=https%3A%2F%2Fabmics.com%2Fwp-content%2Fuploads%2Fepisodes%2F128974%2F%D8%A7%D9%84%D9%81%D8%B5%D9%84-2-%D9%82%D8%B5%D8%A9-%D8%AC%D8%A7%D9%86%D8%A8%D9%8A%D8%A9-2-%D9%85%D9%86-%D9%85%D8%A7%D9%86%D8%AC%D8%A7-Kimetsu-No-Yaiba-Tomioka-Giyuu-Ga-1.png&w=600&h=300",//i.thumbnail,
                                                  imageUrl: i.thumbnail,
                                                  progressIndicatorBuilder:
                                                      (context, url, downloadProgress) =>
                                                  const VShimmerEffect(
                                                      width: double.infinity, height: 200),
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(5.0),
                                                alignment: Alignment.bottomCenter,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: <Color>[
                                                      Colors.black.withAlpha(0),
                                                      Colors.black12,
                                                      Colors.black87
                                                    ],
                                                  ),
                                                ),
                                                child: Text(
                                                  textAlign: TextAlign.left,
                                                  homeController.dataService.isEnglish.value ? i.title_en: i.title_ar,
                                                  style: const TextStyle(color: Colors.white, fontSize: 20.0),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  }).toList(),
                                )),
                            const SizedBox(height: VSizes.spaceBtwItems,),
                            homeController.carouselList.length > 1 ? Center(
                              child: AnimatedSmoothIndicator(
                                onDotClicked: (index){
                                  // _controller.jumpToPage(index);
                                },
                                activeIndex: homeController.carouselIndex.value,
                                count: homeController.carouselList.length,
                                effect: const ExpandingDotsEffect(activeDotColor: Colors.green, dotHeight: 6),
                              ),
                            ) : const SizedBox(width: 0,),
                            const Divider(),
                            const SizedBox(height: VSizes.spaceBtwItems,),
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
                      return ComicHorizontalListWithSection(title: homeController.dataService.isEnglish.value ? "Popular Comics" : "كاريكاتير شعبية", comicList: homeController.popularComicList);
                    }

                  }),
                ],
              )
          ),
        ),

    );
  }
}


