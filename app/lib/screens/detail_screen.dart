import 'package:amlportal/controllers/detail_controller.dart';
import 'package:amlportal/customs/v_sizes.dart';
import 'package:amlportal/models/episode_model.dart';
import 'package:amlportal/widgets/detail_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/episode_controller.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.episode});

  final EpisodeModel episode;


  @override
  Widget build(BuildContext context) {
    final refreshController = RefreshController(initialRefresh: true);
    final detailController = Get.put(DetailController());
    final episodeController = Get.put(EpisodeController());
    print("Episode List Length: ${episodeController.episodeList.length}");
    print("Current Episode ID: ${episode.episode_id}");
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // Icon color
        ),
        backgroundColor: Colors.black, // Changed from green to black
        title: Text(
          episode.episode_title,
          style: Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.white),
        ),
      ),
      body: SmartRefresher(
        controller: refreshController,
        enablePullDown: true,
        onRefresh: () async {
          await detailController.getDetailByEpisodeId(episode.episode_id);
          refreshController.refreshCompleted();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(VSizes.xs),
            child: Column(
              children: [
                Obx(() {
                  if (detailController.detail.value.images.isEmpty) {
                    return const SizedBox(height: 0.0);
                  } else {
                    return ListView.builder(
                      itemCount: detailController.detail.value.images.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (_, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: VSizes.xs),
                          child: DetailCard(strImg: detailController.detail.value.images[index]),
                        );
                      },
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        color: Colors.black, // Background color
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Previous Episode Button
            TextButton.icon(
              onPressed: () {
                var list = episodeController.episodeList;
                int currentIndex = list.indexWhere(
                        (e) => e.episode_id.toString() == episode.episode_id.toString());

                print("Current Index: $currentIndex");
                if (currentIndex > 0) {
                  var previousEpisode = list[currentIndex - 1];
                  print("Navigating to Previous Episode: ${previousEpisode.episode_id}");
                  Get.off(() => DetailScreen(episode: previousEpisode));
                }
              },
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              label: const Text("Prev", style: TextStyle(color: Colors.white)),
            ),

            // Home Button
            IconButton(
              onPressed: () {
                // Implement back to comic details
                Get.back();
              },
              icon: const Icon(Icons.menu, color: Colors.white, size: 28),
            ),

            // Next Episode Button
            TextButton.icon(
              onPressed: () {
                var list = episodeController.episodeList;
                int currentIndex = list.indexWhere(
                        (e) => e.episode_id.toString() == episode.episode_id.toString());

                print("Current Index: $currentIndex");
                if (currentIndex < list.length - 1) {
                  var nextEpisode = list[currentIndex + 1];
                  print("Navigating to Next Episode: ${nextEpisode.episode_id}");
                  Get.off(() => DetailScreen(episode: nextEpisode));
                }
              },
              icon: const Text("Next", style: TextStyle(color: Colors.white)),
              label: const Icon(Icons.arrow_forward, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
