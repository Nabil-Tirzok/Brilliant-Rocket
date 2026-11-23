import 'package:material_ui/material_ui.dart';
import '../../config/app_config.dart';
import '../../theme/app_colors.dart';

class BrandName extends StatelessWidget {
  final TextStyle? style;
  final TextAlign textAlign;

  const BrandName({
    super.key,
    this.style,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      AppConfig.brandName,
      style: style ??
          const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w800,
            color: AppColors.darkBlue,
          ),
      textAlign: textAlign,
    );
  }
}