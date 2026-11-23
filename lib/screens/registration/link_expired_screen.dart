import 'package:material_ui/material_ui.dart';

import 'package:brilliant_rocket/config/app_routes.dart';
import 'package:brilliant_rocket/theme/app_colors.dart';
import 'package:brilliant_rocket/widgets/buttons/app_text_button.dart';
import 'package:brilliant_rocket/widgets/status/status_page.dart';

class LinkExpiredScreen extends StatelessWidget {
  const LinkExpiredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StatusPage(
      backgroundColor: AppColors.background,
      icon: Icons.access_time,
      iconSize: 37,
      title: 'This link has expired',
      description:
          'Request a fresh email to continue.\n'
          'For your account, use the latest link.',
      primaryButtonText: 'Send a new link',
      onPrimaryPressed: () {
        // TODO: Send a new email link.
      },
      secondaryAction: Center(
        child: AppTextButton(
          text: 'Use a different email',
          onPressed: () {
            // TODO: Navigate to the different email screen.
          },
        ),
      ),
      footerAtBottom: true,
      footer: Center(
        child: AppTextButton(
          text: 'Back to log in',
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.login,
              (route) => false,
            );
          },
        ),
      ),
    );
  }
}
