import 'package:amlportal/customs/v_data_service.dart';
import 'package:amlportal/customs/v_shimmer.dart';
import 'package:amlportal/customs/v_sizes.dart';
import 'package:amlportal/models/comic_model.dart';
import 'package:amlportal/screens/episode_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComicVerticalCard extends StatelessWidget {
  const ComicVerticalCard({super.key, required this.comic});

  final ComicModel comic;

  @override
  Widget build(BuildContext context) {
    final dataService = VDataService.instance;

    return Padding(
      padding: const EdgeInsets.all(VSizes.xs),
      child: InkWell(
        onTap: () {
          Get.to(() => EpisodeScreen(comic: comic));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            Expanded(
              flex: 3,
              child: SizedBox(
                height: 200,
                child: comic.thumbnail.isEmpty
                    ? Image.asset(
                  'assets/icon.png',
                  fit: BoxFit.cover,
                )
                    : CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: comic.thumbnail,
                  progressIndicatorBuilder:
                      (context, url, downloadProgress) =>
                      VShimmerEffect(width: double.infinity, height: 200),
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Details section
            Expanded(
              flex: 5,
              child: Container(
                color: Colors.black87,
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title with green circle
                    Row(
                      children: [
                        Container(
                          child: Center(child:Text("FREE",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 7),),),
                          width: 25,
                          height: 25,
                          decoration: const BoxDecoration(

                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            dataService.isEnglish.value
                                ? comic.title_en
                                : comic.title_ar,
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
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
                    const SizedBox(height: 8),
                    // Favorite icon and count
                    Row(
                      children: [
                        const Icon(Icons.favorite, color: Colors.green, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          "1.5M",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Description
                    Text(
                      comic.content,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
