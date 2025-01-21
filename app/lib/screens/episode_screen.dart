import 'package:amlportal/controllers/episode_controller.dart';
import 'package:amlportal/customs/v_data_service.dart';
import 'package:amlportal/customs/v_sizes.dart';
import 'package:amlportal/models/comic_model.dart';
import 'package:amlportal/models/episode_model.dart';
import 'package:amlportal/widgets/episode_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class EpisodeScreen extends StatelessWidget {
  const EpisodeScreen({super.key, required this.comic});

  final ComicModel comic;

  @override
  Widget build(BuildContext context) {
    final refreshController = RefreshController(initialRefresh: true);
    final episodeController = Get.put(EpisodeController());
    final dataService = VDataService.instance;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Colors.green,
        title: Text(dataService.isEnglish.value ? comic.title_en : comic.title_ar, style: Theme.of(context)
            .textTheme
            .headlineMedium!
            .apply(color: Colors.white),),
      ),
      body: SmartRefresher(
        controller: refreshController,
        enablePullDown: true,
        onRefresh: () async{
          await episodeController.getEpisodeByComicId(comic.comic_id);
          refreshController.refreshCompleted();
        },
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(VSizes.xs),
              child: Column(
                children: [
                  Obx((){
                    if (episodeController.episodeList.isEmpty){
                      return const SizedBox(height: 0.0,);
                    }
                    else{
                      return ListView.builder(
                          itemCount: episodeController.episodeList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding:
                              const EdgeInsets.only(right: VSizes.xs),
                              child: EpisodeCart(episode: episodeController.episodeList[index],),
                            );
                          });
                    }
                  }),
                ],
              )
          ),
        ),
      ),
    );
  }
}

