import 'package:flutter/material.dart';
import '../customs/v_sizes.dart';
import '../models/comic_model.dart';
import 'comic_card.dart';

class ComicVerticalSliderWithTitle extends StatelessWidget {
  const ComicVerticalSliderWithTitle({
    super.key,
    required this.title,
    required this.imageUrls, // Pass a list of image URLs
  });

  final String title;
  final List<ComicModel> imageUrls; // List of image URLs for the slider

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // To make sure the slider takes up full width
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Section
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: VSizes.md,
              vertical: VSizes.sm,
            ),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.deepOrangeAccent,
              ),
            ),
          ),
          const Divider(color: Colors.green, thickness: 1),

          // Image Slider Section (Vertical)
          Expanded(
            child: PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imageUrls[index] as String,
                    fit: BoxFit.cover,
                    width: double.infinity, // Full width
                    height: double.infinity, // Full height
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
