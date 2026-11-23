import 'package:material_ui/material_ui.dart';

import 'package:brilliant_rocket/config/app_config.dart';
import 'package:brilliant_rocket/theme/app_colors.dart';
import 'package:brilliant_rocket/theme/app_dimensions.dart';
import 'package:brilliant_rocket/theme/app_text_styles.dart';
import 'package:brilliant_rocket/utils/app_validators.dart';
import 'package:brilliant_rocket/widgets/buttons/app_text_button.dart';
import 'package:brilliant_rocket/widgets/buttons/back_button.dart';
import 'package:brilliant_rocket/widgets/buttons/primary_button.dart';
import 'package:brilliant_rocket/widgets/forms/app_info_card.dart';
import 'package:brilliant_rocket/widgets/inputs/app_text_field.dart';
import 'package:brilliant_rocket/widgets/layout/app_page.dart';
import 'package:brilliant_rocket/widgets/layout/app_page_header.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool resetLinkSent = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void _sendResetLink() {
    if (formKey.currentState!.validate()) {
      setState(() {
        resetLinkSent = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      backgroundColor: AppColors.surface,
      padding: EdgeInsets.zero,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.screenPadding,
        ),
        decoration: BoxDecoration(
          border: Border.symmetric(
            vertical: BorderSide(
              color: AppColors.border,
              width: AppDimensions.borderWidth,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppDimensions.spaceXXXL + 1),
            const AppBackButton(),
            const SizedBox(height: AppDimensions.spaceLG),
            if (!resetLinkSent) ...[
              AppPageHeader(
                title: 'Forgot password?',
                description:
                    'Enter the email address linked to\n'
                    'your ${AppConfig.brandName} account.',
                titleStyle: AppTextStyles.heading.copyWith(
                  fontSize: 30,
                  height: 1.2,
                ),
                descriptionStyle: AppTextStyles.body.copyWith(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 28),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextField(
                      labelText: 'Email address',
                      hintText: 'you@example.com',
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      validator: AppValidators.email,
                    ),
                    const SizedBox(height: 26),
                    PrimaryButton(
                      text: 'Send reset link',
                      onPressed: _sendResetLink,
                    ),
                    const SizedBox(height: AppDimensions.spaceXL),
                    Center(
                      child: AppTextButton(
                        text: 'Back to log in',
                        onPressed: () => Navigator.pop(context),
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              AppPageHeader(
                title: 'Check your email',
                description:
                    'If an account is linked to that email,\n'
                    'we\'ll send a password reset link.',
                titleStyle: AppTextStyles.heading.copyWith(
                  fontSize: 30,
                  height: 1.2,
                ),
                descriptionStyle: AppTextStyles.body.copyWith(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 28),
              const AppInfoCard(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                title: 'Can’t find the email?',
                description: 'Check your spam or junk folder.',
              ),
              const SizedBox(height: AppDimensions.spaceXL),
              PrimaryButton(
                text: 'Back to log in',
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(height: AppDimensions.spaceXL),
              Center(
                child: AppTextButton(
                  text: 'Use a different email',
                  onPressed: () {
                    setState(() {
                      resetLinkSent = false;
                      emailController.clear();
                    });
                  },
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
