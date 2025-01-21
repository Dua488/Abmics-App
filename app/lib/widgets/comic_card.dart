import 'dart:ffi';

import 'package:amlportal/customs/v_data_service.dart';
import 'package:amlportal/customs/v_shimmer.dart';
import 'package:amlportal/customs/v_sizes.dart';
import 'package:amlportal/models/comic_model.dart';
import 'package:amlportal/screens/episode_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComicCard extends StatelessWidget {
  const ComicCard({super.key, required this.comic, required this.horizontal});

  final ComicModel comic;
  final bool horizontal;

  @override
  Widget build(BuildContext context) {
    final dataService = VDataService.instance;
    return Card(
      color: Colors.black12.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.all(VSizes.xs),
        child: InkWell(
          onTap: (){
            Get.to(()=> EpisodeScreen(comic: comic));
          },
          child: SizedBox(
            width: horizontal ? 150 : double.infinity,
            height: 220,
            child: Stack(
              children: [
                Container(
                  width: horizontal ? 150 : double.infinity,
                  height: 220,
                  child: comic.thumbnail.isEmpty ? Image.asset('assets/icon.png'): CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: comic.thumbnail ,
                    //imageUrl: 'https://fintech.fsa.gov.kh/img/logo_fsaV1.png',
                    progressIndicatorBuilder: (context, url, downloadProgress) => VShimmerEffect(width: horizontal ? 150 : double.infinity, height: 220),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5.0),
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        Colors.black.withAlpha(0),
                        Colors.black26,
                        Colors.black87
                      ],
                    ),
                  ),
                  child: Text(
                    maxLines: 3,
                    dataService.isEnglish.value ? comic.title_en : comic.title_ar,
                    style: Theme.of(context).textTheme.titleSmall!.apply(fontWeightDelta: 10, color: Colors.green),
                  ),
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      child: Center(
                        child: Text(comic.status, style: Theme.of(context).textTheme.titleSmall!.apply(fontWeightDelta: 10, color: Colors.white),),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.deepOrangeAccent,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      width: 70,
                      height: 25,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}


