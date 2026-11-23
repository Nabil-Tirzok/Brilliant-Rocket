import 'package:material_ui/material_ui.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../theme/app_text_styles.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: AppColors.border,
            thickness: AppDimensions.borderWidth,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spaceLG,
          ),
          child: Text(
            'or',
            style: AppTextStyles.bodySmall,
          ),
        ),
        const Expanded(
          child: Divider(
            color: AppColors.border,
            thickness: AppDimensions.borderWidth,
          ),
        ),
      ],
    );
  }
}
