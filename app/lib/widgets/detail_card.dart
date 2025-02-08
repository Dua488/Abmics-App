import 'package:amlportal/customs/v_function_helper.dart';
import 'package:amlportal/customs/v_shimmer.dart';
import 'package:amlportal/customs/v_sizes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class DetailCard extends StatelessWidget {
  const DetailCard({super.key, required this.strImg});
  final String strImg;

  @override
  Widget build(BuildContext context) {
    print('stri img : $strImg');
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(VSizes.xs),
        child: InkWell(
          onTap: () {},
          child: Container(
            width: double.infinity, // Full screen width
            height: 400, // Manually set height (adjust as needed)
            child: Padding(
              padding: const EdgeInsets.only(),
              child: Container(
                width: double.infinity, // Full width
                height: 250, // Manually set height
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0.0),

                  boxShadow: [
                    //BoxShadow(color: Colors.green, spreadRadius: 3),
                  ],
                ),
                child: PhotoViewGallery.builder(
                  backgroundDecoration: const BoxDecoration(

                  ),
                  scrollPhysics: const BouncingScrollPhysics(),
                  builder: (BuildContext context, int index) {
                    return PhotoViewGalleryPageOptions(
                      imageProvider: NetworkImage(strImg),
                      initialScale: PhotoViewComputedScale.contained * 1,
                    );
                  },
                  itemCount: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
