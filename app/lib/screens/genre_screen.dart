import 'package:amlportal/controllers/genre_controller.dart';
import 'package:amlportal/customs/v_sizes.dart';
import 'package:amlportal/widgets/comic_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../customs/v_shimmer.dart';

class GenreScreen extends StatelessWidget {
  const GenreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final refreshController = RefreshController(initialRefresh: true);
    final genreController = Get.put(GenreController());

    return SmartRefresher(
      controller: refreshController,
      enablePullDown: true,
      enablePullUp: true,
      onRefresh: () async{
        await genreController.getGenre();
        refreshController.refreshCompleted();
      },
      onLoading: () async{
        await genreController.getComicBySlug(true);
        refreshController.loadComplete();
      },
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(VSizes.xs),
            child: Column(
              children: [
                Obx((){
                  if (genreController.slugList.isEmpty){
                    return const SizedBox(height: 0.0,);
                  }
                  else{
                    return SizedBox(
                      // color: Colors.red,
                      height: 50,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(VSizes.xs),
                        child: Obx(() => ListView.builder(
                            itemCount: genreController.slugList.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              return Obx(() => Padding(
                                  padding: const EdgeInsets.only(
                                      left: VSizes.sm, right: VSizes.sm),
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        genreController.selectedIndex.value = index;
                                        await genreController.getComicBySlug(false);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: index == genreController.selectedIndex.value
                                              ? Colors.green
                                              : Colors.grey
                                      ),
                                      child: Text(
                                        genreController.slugList[index].name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .apply(
                                            color: Colors.white,
                                            fontWeightDelta: 20
                                        ),
                                      ))));
                            }),
                        ),
                      ),
                    );
                  }
                }),
                const Divider(color: Colors.deepOrangeAccent,),
                Obx((){
                  if (genreController.comicList.isEmpty){
                    //return const SizedBox(height: 0.0,);
                    return Center(child: Image.asset('assets/bg.png', opacity: const AlwaysStoppedAnimation(.1)));
                  }
                  else{
                    return ListView.builder(
                        itemCount: genreController.comicList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (_, index) {
                          return Padding(
                            padding:
                            const EdgeInsets.only(right: VSizes.xs),
                            child: ComicCard(comic: genreController.comicList[index], horizontal: false,),
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
