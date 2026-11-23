import 'package:material_ui/material_ui.dart';

import '../../theme/app_dimensions.dart';
import '../../theme/app_text_styles.dart';

class AppPageHeader extends StatelessWidget {
  final String title;
  final String description;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;
  final double spacing;

  const AppPageHeader({
    super.key,
    required this.title,
    required this.description,
    this.titleStyle,
    this.descriptionStyle,
    this.spacing = AppDimensions.spaceSM,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: titleStyle ?? AppTextStyles.heading,
        ),
        SizedBox(height: spacing),
        Text(
          description,
          style: descriptionStyle ?? AppTextStyles.body,
        ),
      ],
    );
  }
}
