import 'package:material_ui/material_ui.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';

class AppStatusIcon extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final double containerSize;
  final Color backgroundColor;
  final Color foregroundColor;

  const AppStatusIcon({
    super.key,
    required this.icon,
    this.iconSize = 36,
    this.containerSize = AppDimensions.statusIconSize,
    this.backgroundColor = AppColors.lightBlue,
    this.foregroundColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerSize,
      width: containerSize,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
      ),
      child: Icon(
        icon,
        color: foregroundColor,
        size: iconSize,
      ),
    );
  }
}
