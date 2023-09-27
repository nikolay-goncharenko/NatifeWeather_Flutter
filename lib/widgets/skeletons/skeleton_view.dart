import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class SkeletonView extends StatelessWidget {
  final double width;
  final double height;
  final double? radius;
  const SkeletonView(
      {Key? key, required this.width, required this.height, this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius ?? 0),
        ),
        width: width,
        height: height,
      ),
    );
  }
}
