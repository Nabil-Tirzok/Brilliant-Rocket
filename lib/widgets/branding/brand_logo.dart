import 'package:material_ui/material_ui.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class BrandLogo extends StatelessWidget {
  final String imageAsset;
  final double width;
  final double height;

  const BrandLogo({
    super.key,
    required this.imageAsset,
    this.width = 180,
    this.height = 70,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imageAsset,
      width: width,
      height: height,
      fit: BoxFit.contain,
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return SvgPicture.asset(
  //     imageAsset,
  //     width: width,
  //     height: height,
  //     fit: BoxFit.contain,
  //   );
  // }
}