import 'package:flutter/material.dart';
import '../customs/v_sizes.dart';
import '../models/comic_model.dart';
import 'comic_card.dart';

class ComicHorizontalListWithSection extends StatelessWidget {
  const ComicHorizontalListWithSection({super.key, required this.title, required this.comicList});

  final String title;
  final List<ComicModel> comicList;

  @override
  Widget build(BuildContext context) {

    return  Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0.0),
      ),
      //color: Colors.blueGrey.withOpacity(0.2),
      width: double.infinity,
      height: 260,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(VSizes.sm),
            child: Container(
              width: double.infinity,
              height: 25,
              child: Text(title, style: Theme.of(context).textTheme.titleLarge!.apply(fontWeightDelta: 10, color: Colors.white)),
            ),
          ),

          Expanded(
            child: Container(
              child: ListView.builder(
                  itemCount: comicList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding:
                      const EdgeInsets.only(right: VSizes.xs),
                      child: ComicCard(comic: comicList[index], horizontal: true,),
                      //child: ComicStory(comic: comicList[index], title: title),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}