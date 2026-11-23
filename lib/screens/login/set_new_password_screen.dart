import 'package:material_ui/material_ui.dart';

import 'package:brilliant_rocket/config/app_config.dart';
import 'package:brilliant_rocket/theme/app_colors.dart';
import 'package:brilliant_rocket/theme/app_dimensions.dart';
import 'package:brilliant_rocket/theme/app_text_styles.dart';
import 'package:brilliant_rocket/utils/app_feedback.dart';
import 'package:brilliant_rocket/utils/app_validators.dart';
import 'package:brilliant_rocket/widgets/buttons/app_text_button.dart';
import 'package:brilliant_rocket/widgets/buttons/back_button.dart';
import 'package:brilliant_rocket/widgets/buttons/primary_button.dart';
import 'package:brilliant_rocket/widgets/inputs/password_field.dart';
import 'package:brilliant_rocket/widgets/layout/app_page.dart';
import 'package:brilliant_rocket/widgets/layout/app_page_header.dart';
import 'package:brilliant_rocket/widgets/status/app_status_icon.dart';

class SetNewPasswordScreen extends StatefulWidget {
  const SetNewPasswordScreen({super.key});

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _savePassword() {
    if (passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      AppFeedback.showMessage(context, 'Please enter your password.');
      return;
    }

    final mismatch = AppValidators.passwordsMatch(
      passwordController.text,
      confirmPasswordController.text,
    );
    if (mismatch != null) {
      AppFeedback.showMessage(context, mismatch);
      return;
    }

    AppFeedback.showMessage(context, 'Password saved successfully!');
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      backgroundColor: AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppDimensions.spaceMD),
          const AppBackButton(),
          const SizedBox(height: AppDimensions.spaceLG),
          const AppStatusIcon(
            icon: Icons.lock_outline,
            iconSize: 33,
          ),
          const SizedBox(height: AppDimensions.spaceLG),
          AppPageHeader(
            title: 'Set a new password',
            description: 'Choose a unique password for your\n'
                '${AppConfig.brandName} account.',
            titleStyle: AppTextStyles.heading.copyWith(
              fontSize: 26,
              fontWeight: FontWeight.w800,
            ),
            descriptionStyle: AppTextStyles.bodySmall.copyWith(fontSize: 14),
          ),
          const SizedBox(height: AppDimensions.spaceXXXL - 10),
          PasswordField(
            labelText: 'New password',
            hintText: 'Enter your new password',
            controller: passwordController,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: AppDimensions.spaceXS + 2),
          Text(
            'Use a strong password you have not\n'
            'used on other accounts.',
            style: AppTextStyles.bodySmall.copyWith(fontSize: 12, height: 1.7),
          ),
          const SizedBox(height: AppDimensions.spaceXXL),
          PasswordField(
            labelText: 'Confirm new password',
            hintText: 'Re-enter your new password',
            controller: confirmPasswordController,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(height: AppDimensions.spaceXXXL - 7),
          PrimaryButton(
            text: 'Save new password',
            onPressed: _savePassword,
          ),
          const SizedBox(height: AppDimensions.spaceLG),
          Center(
            child: AppTextButton(
              text: 'Back to log in',
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const SizedBox(height: AppDimensions.spaceLG),
        ],
      ),
    );
  }
}
