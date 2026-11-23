import 'package:material_ui/material_ui.dart';

import 'package:brilliant_rocket/config/app_routes.dart';
import 'package:brilliant_rocket/theme/app_colors.dart';
import 'package:brilliant_rocket/widgets/forms/app_info_card.dart';
import 'package:brilliant_rocket/widgets/status/status_page.dart';

class PasswordUpdatedScreen extends StatelessWidget {
  const PasswordUpdatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StatusPage(
      backgroundColor: AppColors.surface,
      icon: Icons.check,
      iconSize: 43,
      title: 'Password updated',
      description: 'Your new password is ready.\n'
          'Log in to continue shopping.',
      primaryButtonText: 'Back to log in',
      onPrimaryPressed: () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.login,
          (route) => false,
        );
      },
      infoCard: const AppInfoCard(
        title: 'Using Google or Facebook?',
        description: 'Your provider password stays separate.',
      ),
    );
  }
}
