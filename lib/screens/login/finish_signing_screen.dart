import 'package:material_ui/material_ui.dart';

import 'package:brilliant_rocket/config/app_routes.dart';
import 'package:brilliant_rocket/theme/app_colors.dart';
import 'package:brilliant_rocket/theme/app_dimensions.dart';
import 'package:brilliant_rocket/widgets/buttons/app_text_button.dart';
import 'package:brilliant_rocket/widgets/buttons/secondary_button.dart';
import 'package:brilliant_rocket/widgets/forms/app_info_card.dart';
import 'package:brilliant_rocket/widgets/status/status_page.dart';

class FinishSigningScreen extends StatelessWidget {
  const FinishSigningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StatusPage(
      backgroundColor: AppColors.background,
      icon: Icons.lock_outline,
      iconSize: 34,
      title: 'Finish signing in',
      description: 'Google could not finish signing you in.\n'
          'Try again or use your account email.',
      primaryButtonText: 'Try Google again',
      onPrimaryPressed: () {
        // TODO: Retry Google sign-in.
      },
      secondaryAction: Column(
        children: [
          SecondaryButton(
            text: 'Log in with email',
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.login);
            },
          ),
          const SizedBox(height: AppDimensions.spaceXXL),
          AppTextButton(
            text: 'Use another sign-in method',
            onPressed: () {
              // TODO: Show other sign-in methods.
            },
          ),
        ],
      ),
      infoCard: const AppInfoCard(
        description: 'Your cart is saved while you retry.\n'
            'We will return you to your shopping.',
      ),
    );
  }
}
