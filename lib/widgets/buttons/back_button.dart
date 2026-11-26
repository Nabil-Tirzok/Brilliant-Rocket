import 'package:material_ui/material_ui.dart';

import 'package:brilliant_rocket/theme/app_colors.dart';
import 'package:brilliant_rocket/theme/app_dimensions.dart';

class AppBackButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const AppBackButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ?? () => Navigator.canPop(context) ? Navigator.pop(context) : null,
      borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
      child: Container(
        height: AppDimensions.iconButtonSize,
        width: AppDimensions.iconButtonSize,
        decoration: BoxDecoration(
          color: AppColors.lightBlue,
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
        ),
        child: const Icon(
          Icons.arrow_back,
          color: AppColors.textPrimary,
          size: 24,
        ),
      ),
    );
  }
}
