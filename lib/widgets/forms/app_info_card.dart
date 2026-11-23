import 'package:material_ui/material_ui.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../theme/app_text_styles.dart';

class AppInfoCard extends StatelessWidget {
  final String? title;
  final String? description;
  final Widget? child;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;
  final bool showBorder;
  final double? height;

  const AppInfoCard({
    super.key,
    this.title,
    this.description,
    this.child,
    this.backgroundColor = AppColors.lightBlue,
    this.padding = const EdgeInsets.all(AppDimensions.cardPadding),
    this.showBorder = false,
    this.height,
  }) : assert(title != null || description != null || child != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
        border: showBorder ? Border.all(color: AppColors.border) : null,
      ),
      child: child ??
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title != null)
                Text(
                  title!,
                  style: AppTextStyles.label,
                ),
              if (title != null && description != null)
                const SizedBox(height: AppDimensions.spaceXS + 1),
              if (description != null)
                Text(
                  description!,
                  style: AppTextStyles.bodySmall,
                ),
            ],
          ),
    );
  }
}
