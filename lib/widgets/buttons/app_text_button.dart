import 'package:material_ui/material_ui.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class AppTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry padding;
  final bool compact;

  const AppTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textStyle,
    this.padding = EdgeInsets.zero,
    this.compact = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: padding,
        minimumSize: compact ? Size.zero : null,
        tapTargetSize: compact
            ? MaterialTapTargetSize.shrinkWrap
            : MaterialTapTargetSize.padded,
      ),
      child: Text(text, style: textStyle ?? AppTextStyles.link),
    );
  }
}
