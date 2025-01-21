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
    print('stri img : ${strImg}');
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(VSizes.xs),
        child: InkWell(
          onTap: (){

          },
          child: Container(
            width: VFunctionHelper.screenWidth() - VSizes.xs,
            height: VFunctionHelper.screenHeight() - 200,
            child: Padding(
              padding: const EdgeInsets.only(top: VSizes.xs),
              child: Container(
                width: VFunctionHelper.screenWidth() - VSizes.xs,
                height: VFunctionHelper.screenHeight() - 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.green, spreadRadius: 3),
                  ],
                ),
                // child: strImg.isEmpty ? Image.asset('assets/icon.png'): CachedNetworkImage(
                //   fit: BoxFit.contain,
                //   imageUrl: strImg ,
                //   progressIndicatorBuilder: (context, url, downloadProgress) => VShimmerEffect(width: VFunctionHelper.screenWidth() - VSizes.xs, height: VFunctionHelper.screenHeight() - 200),
                // ),
                child: PhotoViewGallery.builder(
                  backgroundDecoration: BoxDecoration(
                    color: Colors.green[200],
                  ),
                  scrollPhysics: const BouncingScrollPhysics(),
                  builder: (BuildContext context, int index) {
                    return PhotoViewGalleryPageOptions(
                      imageProvider: NetworkImage(strImg),
                      //initialScale: PhotoViewComputedScale.contained * 1.5,
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