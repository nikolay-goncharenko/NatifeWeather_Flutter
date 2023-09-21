import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:natife_weather/gen/colors.gen.dart';

class PlaneImageButton extends StatelessWidget {
  final double size;
  final String assetImage;
  final VoidCallback onPressedCallback;

  const PlaneImageButton(
      {Key? key,
      required this.size,
      required this.assetImage,
      required this.onPressedCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: size, height: size),
      child: IconButton(
        splashRadius: 20,
        padding: EdgeInsets.zero,
        onPressed: onPressedCallback,
        icon: SvgPicture.asset(
          assetImage,
          // ignore: deprecated_member_use
          color: ColorName.light,
          width: 20, height: 20,
        ),
      ),
    );
  }
}
