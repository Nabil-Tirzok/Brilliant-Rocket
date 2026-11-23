import 'package:material_ui/material_ui.dart';

import 'package:brilliant_rocket/theme/app_dimensions.dart';
import 'package:brilliant_rocket/theme/app_text_styles.dart';
import 'package:brilliant_rocket/widgets/buttons/app_text_button.dart';
import 'package:brilliant_rocket/widgets/buttons/back_button.dart';
import 'package:brilliant_rocket/widgets/buttons/primary_button.dart';
import 'package:brilliant_rocket/widgets/buttons/secondary_button.dart';
import 'package:brilliant_rocket/widgets/forms/app_info_card.dart';
import 'package:brilliant_rocket/widgets/layout/app_page.dart';
import 'package:brilliant_rocket/widgets/status/app_status_icon.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppDimensions.spaceXS),
          const AppBackButton(),
          const SizedBox(height: AppDimensions.spaceXXXL),
          const AppStatusIcon(
            icon: Icons.mail_outline,
            iconSize: 36,
          ),
          const SizedBox(height: AppDimensions.spaceMD),
          Text(
            'Verify your email',
            style: AppTextStyles.heading.copyWith(
              fontSize: 28,
              height: 1.2,
            ),
          ),
          const SizedBox(height: AppDimensions.spaceSM),
          Text(
            'We sent a verification link to',
            style: AppTextStyles.bodySmall.copyWith(fontSize: 14),
          ),
          const SizedBox(height: AppDimensions.spaceXS),
          Text(
            's•••••@example.com',
            style: AppTextStyles.bodyEmphasis.copyWith(fontSize: 16),
          ),
          const SizedBox(height: AppDimensions.spaceMD),
          Center(
            child: AppTextButton(
              text: 'Use a different email',
              onPressed: () {
                // Navigate to change email screen.
              },
            ),
          ),
          const SizedBox(height: AppDimensions.spaceXXL),
          const AppInfoCard(
            title: 'Open the link in your email',
            description: 'Check your spam or junk folder.',
          ),
          const SizedBox(height: AppDimensions.spaceXXL),
          PrimaryButton(
            text: 'I have verified my email',
            onPressed: () {
              // Verify email action.
            },
          ),
          const SizedBox(height: AppDimensions.spaceMD),
          SecondaryButton(
            text: 'Send another email',
            onPressed: () {
              // Resend verification email action.
            },
          ),
          const SizedBox(height: AppDimensions.spaceXXL),
          Text(
            'Verification keeps your account ready\n'
            'for order updates and recovery.',
            style: AppTextStyles.bodySmall.copyWith(height: 1.8),
          ),
          const SizedBox(height: AppDimensions.spaceXXL),
          Center(
            child: AppTextButton(
              text: 'Back to log in',
              onPressed: () {
                // Navigate to login screen.
              },
            ),
          ),
          const SizedBox(height: AppDimensions.spaceLG),
        ],
      ),
    );
  }
}
