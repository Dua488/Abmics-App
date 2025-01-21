import 'package:amlportal/controllers/library_controller.dart';
import 'package:amlportal/widgets/verticalstraightCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../customs/v_sizes.dart';
import '../widgets/comic_card.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final refreshController = RefreshController(initialRefresh: true);
    final libraryController = Get.put(LibraryController());

    return SmartRefresher(
      controller: refreshController,
      enablePullDown: true,
      enablePullUp: true,
      onRefresh: () async {
        await libraryController.getLibraryComic(false);
        refreshController.refreshCompleted();
      },
      onLoading: () async {
        await libraryController.getLibraryComic(true);
        refreshController.loadComplete();
      },
      child: Padding(
        padding: const EdgeInsets.all(VSizes.xs),
        child: ListView(
          children: [
            Divider(color: Colors.white,),
            Center(child: Text("My Library",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),

            Obx(() {
              if (libraryController.comicList.isEmpty) {
                return Center(
                  child: Image.asset(
                    'assets/bg.png',
                    opacity: const AlwaysStoppedAnimation(.1),
                  ),
                );
              } else {
                return GridView.builder(
                  itemCount: libraryController.comicList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Number of columns in the grid
                    // Spacing between columns
                    childAspectRatio: 0.6, // Width to height ratio of each grid item
                  ),
                  itemBuilder: (_, index) {
                    return ComicVerticalStraightCard(
                      comic: libraryController.comicList[index],

                    );
                  },
                );
              }
            }),
          ]
        ),
      ),
    );
  }
}
