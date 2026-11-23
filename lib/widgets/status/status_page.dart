import 'package:material_ui/material_ui.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../theme/app_text_styles.dart';
import '../buttons/back_button.dart';
import '../buttons/primary_button.dart';
import '../layout/app_page_header.dart';
import 'app_status_icon.dart';

class StatusPage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String primaryButtonText;
  final VoidCallback onPrimaryPressed;
  final Color backgroundColor;
  final double iconSize;
  final Widget? secondaryAction;
  final Widget? infoCard;
  final Widget? footer;
  final bool footerAtBottom;
  final bool showBackButton;

  const StatusPage({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.primaryButtonText,
    required this.onPrimaryPressed,
    this.backgroundColor = AppColors.surface,
    this.iconSize = 36,
    this.secondaryAction,
    this.infoCard,
    this.footer,
    this.footerAtBottom = false,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.screenPadding,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppDimensions.screenTopPadding),
                      if (showBackButton) const AppBackButton(),
                      const SizedBox(height: AppDimensions.spaceXXXL),
                      AppStatusIcon(
                        icon: icon,
                        iconSize: iconSize,
                      ),
                      const SizedBox(height: AppDimensions.spaceLG),
                      AppPageHeader(
                        title: title,
                        description: description,
                        titleStyle: AppTextStyles.heading.copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                        descriptionStyle: AppTextStyles.bodySmall.copyWith(
                          fontSize: 14,
                        ),
                        spacing: AppDimensions.spaceSM,
                      ),
                      const SizedBox(height: AppDimensions.spaceXXXL),
                      PrimaryButton(
                        text: primaryButtonText,
                        onPressed: onPrimaryPressed,
                      ),
                      if (secondaryAction != null) ...[
                        const SizedBox(height: AppDimensions.spaceSM),
                        secondaryAction!,
                      ],
                      if (infoCard != null) ...[
                        const SizedBox(height: AppDimensions.spaceXXL),
                        infoCard!,
                      ],
                      if (footerAtBottom) const Spacer(),
                      if (footer != null) ...[
                        SizedBox(
                          height: footerAtBottom
                              ? AppDimensions.spaceSM
                              : AppDimensions.spaceXXL,
                        ),
                        footer!,
                      ],
                      const SizedBox(height: AppDimensions.spaceLG),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
