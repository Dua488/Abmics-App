import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amlportal/models/episode_model.dart';
import 'package:amlportal/screens/detail_screen.dart';

class EpisodeCart extends StatelessWidget {
  const EpisodeCart({super.key, required this.episode});
  final EpisodeModel episode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.to(() => DetailScreen(episode: episode));
          },
          child: Container(
            color: Colors.black, // Black background
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Title
                Expanded(
                  child: Text(
                    episode.episode_title, // Title
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .apply(color: Colors.white),
                  ),
                ),
                // Number
                Text(
                  '#${episode.points}', // Number
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .apply(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        // Divider
        Divider(
          color: Colors.white, // White line between rows
          thickness: 1.0,
          height: 1.0,
        ),
      ],
    );
  }
}
