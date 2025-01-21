import 'package:amlportal/controllers/library_controller.dart';
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
      onRefresh: () async{
        await libraryController.getLibraryComic(false);
        refreshController.refreshCompleted();
      },
      onLoading: () async{
        await libraryController.getLibraryComic(true);
        refreshController.loadComplete();
      },
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(VSizes.xs),
            child: Column(
              children: [
                Obx((){
                  if (libraryController.comicList.isEmpty){
                    //return const SizedBox(height: 0.0,);
                    return Center(child: Image.asset('assets/bg.png', opacity: const AlwaysStoppedAnimation(.1)));
                    // return Center(child: IconButton(onPressed: () async {
                    //   await refreshController.requestRefresh();
                    // },
                    //     icon: Icon(
                    //       Icons.refresh, color: Colors.deepOrangeAccent.withOpacity(0.3), size: 100,)));
                  }
                  else{
                    return ListView.builder(
                        itemCount: libraryController.comicList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (_, index) {
                          return Padding(
                            padding:
                            const EdgeInsets.only(right: VSizes.xs),
                            child: ComicCard(comic: libraryController.comicList[index], horizontal: false,),
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
