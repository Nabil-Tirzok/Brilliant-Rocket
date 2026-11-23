import 'package:material_ui/material_ui.dart';

import 'package:brilliant_rocket/config/app_config.dart';
import 'package:brilliant_rocket/theme/app_colors.dart';
import 'package:brilliant_rocket/widgets/buttons/app_text_button.dart';
import 'package:brilliant_rocket/widgets/status/status_page.dart';

class EmailVerifiedScreen extends StatelessWidget {
  const EmailVerifiedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StatusPage(
      backgroundColor: AppColors.background,
      icon: Icons.check,
      iconSize: 43,
      title: 'Email verified',
      description: 'Your ${AppConfig.brandName} account is ready.\n'
          'Continue to browse products.',
      primaryButtonText: 'Continue shopping',
      onPrimaryPressed: () {
        // TODO: Navigate to shopping screen.
      },
      secondaryAction: Center(
        child: AppTextButton(
          text: 'Go to my account',
          onPressed: () {
            // TODO: Navigate to account screen.
          },
        ),
      ),
    );
  }
}
