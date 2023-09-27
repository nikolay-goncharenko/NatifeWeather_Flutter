import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgImage extends StatelessWidget {
  final String asset;
  final Color color;
  final double size;

  const SvgImage(
      {super.key,
      required this.asset,
      required this.color,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(asset,
        // ignore: deprecated_member_use
        color: color,
        width: size,
        height: size);
  }
}
