import 'package:amlportal/controllers/weekly_controller.dart';
import 'package:amlportal/customs/v_sizes.dart';
import 'package:amlportal/widgets/comic_card.dart';
import 'package:amlportal/widgets/comic_vertical_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class WeeklyScreen extends StatelessWidget {
  const WeeklyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final refreshController = RefreshController(initialRefresh: true);
    final weeklyController = Get.put(WeeklyController());

    return SmartRefresher(
      controller: refreshController,
      enablePullDown: true,
      enablePullUp: true,
      onRefresh: () async{
        await weeklyController.getAbmicComic(false);
        refreshController.refreshCompleted();
      },
      onLoading: () async{
        await weeklyController.getAbmicComic(true);
        refreshController.loadComplete();
      },
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(VSizes.xs),
            child: Column(
              children: [
                Obx((){
                  if (weeklyController.comicList.isEmpty){
                    //return const SizedBox(height: 0.0,);
                    return Center(child: Image.asset('assets/bg.png', opacity: const AlwaysStoppedAnimation(.1)));
                  }
                  else{
                    return ListView.builder(
                        itemCount: weeklyController.comicList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (_, index) {
                          return Padding(
                            padding:
                            const EdgeInsets.only(right: VSizes.xs),
                            child: ComicVerticalCard(comic: weeklyController.comicList[index],),
                          );
                        });
                  }
                }),
              ],
            )
        ),
      ),
    );
  }
}
