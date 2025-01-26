import 'package:amlportal/controllers/upcoming_controller.dart';
import 'package:amlportal/controllers/weekly_controller.dart';
import 'package:amlportal/customs/v_sizes.dart';
import 'package:amlportal/widgets/comic_card.dart';
import 'package:amlportal/widgets/comic_vertical_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UpcomingScreen extends StatelessWidget { // Changed to UpcomingScreen
  const UpcomingScreen({super.key}); // Updated constructor name

  @override
  Widget build(BuildContext context) {
    final refreshController = RefreshController(initialRefresh: true);
    final upcomingController = Get.put(UpcomingController());

    return SmartRefresher(
      controller: refreshController,
      enablePullDown: true,
      enablePullUp: true,
      onRefresh: () async {
        await upcomingController.getAbmicComic(false);
        refreshController.refreshCompleted();
      },
      onLoading: () async {
        await upcomingController.getAbmicComic(true);
        refreshController.loadComplete();
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(VSizes.xs),
          child: Column(
            children: [
              Obx(() {
                if (upcomingController.comicList.isEmpty) {
                  return Center(
                      child: Image.asset('assets/bg.png',
                          opacity: const AlwaysStoppedAnimation(.1)));
                } else {
                  return ListView.builder(
                      itemCount: upcomingController.comicList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (_, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: VSizes.xs),
                          child: ComicVerticalCard(
                            comic: upcomingController.comicList[index],
                          ),
                        );
                      });
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
