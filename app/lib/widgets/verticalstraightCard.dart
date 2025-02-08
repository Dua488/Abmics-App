import 'package:amlportal/customs/v_data_service.dart';
import 'package:amlportal/customs/v_shimmer.dart';
import 'package:amlportal/customs/v_sizes.dart';
import 'package:amlportal/models/comic_model.dart';
import 'package:amlportal/screens/episode_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ComicVerticalStraightCard extends StatelessWidget {
  const ComicVerticalStraightCard({super.key, required this.comic});

  final ComicModel comic;

  @override
  Widget build(BuildContext context) {
    final dataService = VDataService.instance;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(VSizes.xs),
        child: InkWell(
          onTap: () {
            Get.to(() => EpisodeScreen(comic: comic));
          },
          child: SafeArea(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image section: 75% of the height
                Expanded(
                  flex: 6,
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,  // 75% of the screen height
                    child: comic.thumbnail.isEmpty
                        ? Image.asset(
                      'assets/icon.png',
                      fit: BoxFit.cover,
                    )
                        : CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: comic.thumbnail,
                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                          VShimmerEffect(width: double.infinity, height: 200),
                    ),
                  ),
                ),

                // Details section: 25% of the height
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.black87,
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title with green circle
                            Row(
                              children: [
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    dataService.isEnglish.value
                                        ? comic.title_en
                                        : comic.title_ar,
                                    maxLines: 1,
                                    //overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2,),
                            // Favorite icon and count
                            Row(
                              children: [
                                const Icon(Icons.favorite, color: Colors.green, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  comic.views.toString(),

                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: Colors.white),


                                ),
                              ],
                            ),
      
                            // Description (You can add this later if needed)
                          ],
                        ),
                      ],
      
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
