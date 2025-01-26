import 'package:amlportal/controllers/genre_controller.dart';
import 'package:amlportal/customs/v_sizes.dart';
import 'package:amlportal/widgets/comic_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../customs/v_shimmer.dart';
import '../widgets/verticalstraightCard.dart';

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



                Divider(),

                Obx(() {
                  if (genreController.slugList.isEmpty) {
                    return const SizedBox(height: 0.0);
                  } else {
                    return SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(VSizes.xs),
                        child: ListView.builder(
                          itemCount: genreController.slugList.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: VSizes.sm, right: VSizes.sm),
                              child: GestureDetector(
                                onTap: () async {
                                  // Update the selected index and fetch data
                                  genreController.selectedIndex.value = index;
                                  await genreController.getComicBySlug(false);
                                },
                                child: Obx(() => Text(
                                  genreController.slugList[index].name,
                                  style: Theme.of(context).textTheme.titleSmall!.apply(
                                    color: genreController.selectedIndex.value == index
                                        ? Colors.green
                                        : Colors.white,
                                    fontWeightDelta: 20,
                                  ),
                                )),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
                }),


                const Divider(),
                Obx((){
                  if (genreController.comicList.isEmpty){
                    //return const SizedBox(height: 0.0,);
                    return Center(child: Image.asset('assets/bg.png', opacity: const AlwaysStoppedAnimation(.1)));
                  }
                  else{
                    return GridView.builder(
                        itemCount: genreController.comicList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // Number of columns in the grid
                          // Spacing between columns
                          childAspectRatio: 0.6, // Width to height ratio of each grid item
                        ),
                        itemBuilder: (_, index) {
                          return ComicVerticalStraightCard(
                            comic: genreController.comicList[index],

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
