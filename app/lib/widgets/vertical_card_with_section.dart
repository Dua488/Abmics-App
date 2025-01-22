import 'package:flutter/material.dart';
import '../customs/v_sizes.dart';
import '../models/comic_model.dart';
import 'comic_card.dart';

class ComicVerticalGridWithSection extends StatelessWidget {
  const ComicVerticalGridWithSection({
    super.key,
    required this.title,
    required this.comicList,
  });

  final String title;
  final List<ComicModel> comicList;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0.0),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: VSizes.sm, horizontal: VSizes.sm),
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .apply(fontWeightDelta: 10, color: Colors.white),
            ),
          ),
          // Grid View
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: comicList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Number of items in a row
              childAspectRatio: 0.65, // Adjust for comic card height
              crossAxisSpacing: 8.0, // Horizontal spacing
              mainAxisSpacing: 8.0, // Vertical spacing
            ),
            itemBuilder: (_, index) {
              return ComicCard(
                comic: comicList[index],
                horizontal: false, // Adjust for vertical layout
              );
            },
          ),
        ],
      ),
    );
  }
}
