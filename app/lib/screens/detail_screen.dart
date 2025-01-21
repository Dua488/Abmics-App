import 'package:amlportal/controllers/detail_controller.dart';
import 'package:amlportal/customs/v_sizes.dart';
import 'package:amlportal/models/episode_model.dart';
import 'package:amlportal/widgets/detail_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.episode});

  final EpisodeModel episode;

  @override
  Widget build(BuildContext context) {
    final refreshController = RefreshController(initialRefresh: true);
    final detailController = Get.put(DetailController());

    return SmartRefresher(
        controller: refreshController,
        enablePullDown: true,
        onRefresh: () async{
          await detailController.getDetailByEpisodeId(episode.episode_id);
          refreshController.refreshCompleted();
        },
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),
            backgroundColor: Colors.green,
            title: Text(episode.episode_title, style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .apply(color: Colors.white),),
          ),
          body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(VSizes.xs),
                child: Column(
                  children: [
                    Obx((){
                      if (detailController.detail.value.images.isEmpty){
                        return const SizedBox(height: 0.0,);
                      }
                      else{
                        return ListView.builder(
                            itemCount: detailController.detail.value.images.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (_, index) {
                              return Padding(
                                padding:
                                const EdgeInsets.only(right: VSizes.xs),
                                child: DetailCard(strImg: detailController.detail.value.images[index],),
                              );
                            });
                      }
                    }),
                  ],
                )
            ),
          ),
        )
    );
  }
}


