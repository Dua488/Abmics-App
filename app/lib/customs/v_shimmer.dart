import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class VShimmerEffect extends StatelessWidget {
  const VShimmerEffect(
      {super.key,
      required this.width,
      required this.height,
      this.radius = 15});

  final double width, height, radius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(radius))),
      );
  }
}
