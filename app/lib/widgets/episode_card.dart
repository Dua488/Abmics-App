
import 'package:amlportal/customs/v_sizes.dart';
import 'package:amlportal/models/episode_model.dart';
import 'package:amlportal/screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpisodeCart extends StatelessWidget {
  const EpisodeCart({super.key, required this.episode});
  final EpisodeModel episode;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black12.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(VSizes.xs),
        child: InkWell(
          onTap: (){
            Get.to(()=> DetailScreen(episode: episode,));
          },
          child: Container(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.only(left: VSizes.md, right: VSizes.md),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(maxLines: 2, overflow: TextOverflow.ellipsis,episode.episode_title, style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .apply(color: Colors.black),),
                  ),
                  Text(episode.points, style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .apply(color: Colors.white),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
