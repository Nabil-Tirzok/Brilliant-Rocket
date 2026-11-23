import 'package:material_ui/material_ui.dart';

import 'package:brilliant_rocket/config/app_routes.dart';
import 'package:brilliant_rocket/theme/app_colors.dart';
import 'package:brilliant_rocket/theme/app_dimensions.dart';
import 'package:brilliant_rocket/theme/app_text_styles.dart';

import 'package:brilliant_rocket/widgets/buttons/primary_button.dart';
import 'package:brilliant_rocket/widgets/inputs/app_text_field.dart';
import 'package:brilliant_rocket/widgets/inputs/password_field.dart';
import 'package:brilliant_rocket/widgets/forms/recovery_error_card.dart';
import 'package:brilliant_rocket/widgets/buttons/back_button.dart';
import 'package:brilliant_rocket/widgets/buttons/social_button.dart';
import 'package:brilliant_rocket/widgets/common/or_divider.dart';
import 'package:brilliant_rocket/widgets/layout/app_page.dart';
import 'package:brilliant_rocket/widgets/layout/app_page_header.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool showRegistrationError = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      backgroundColor: AppColors.surface,
      child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppDimensions.spaceMD - 1),

                // Back Button
                const AppBackButton(),

                const SizedBox(height: AppDimensions.spaceXS - 1),

                // Heading and subtitle
                AppPageHeader(
                  title: 'Create an account',
                  description: 'Save your details and track orders.',
                  titleStyle: AppTextStyles.heading.copyWith(
                    fontSize: 32,
                    height: 1.2,
                  ),
                  descriptionStyle: AppTextStyles.body.copyWith(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                  ),
                  spacing: AppDimensions.spaceXS + 1,
                ),

                const SizedBox(height: AppDimensions.spaceMD - 3),

                // Full Name
                AppTextField(
                  labelText: 'Full name',
                  hintText: 'Your full name',
                  controller: nameController,
                  textInputAction: TextInputAction.next,
                ),

                const SizedBox(height: AppDimensions.spaceXS + 2),

                // Email
                AppTextField(
                  labelText: 'Email address',
                  hintText: 'you@example.com',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),

                const SizedBox(height: AppDimensions.spaceXS + 2),

                PasswordField(
                  labelText: 'Password',
                  controller: passwordController,
                  hintText: 'Create a password',
                  textInputAction: TextInputAction.next,
                ),

                const SizedBox(height: AppDimensions.spaceXS + 2),

                PasswordField(
                  labelText: 'Confirm password',
                  controller: confirmPasswordController,
                  hintText: 'Re-enter your password',
                  textInputAction: TextInputAction.done,
                ),

                // Registration Error Card
                if (showRegistrationError) ...[
                  RecoveryCard(
                    header: 'Login · Too many attempts',
                    title: 'Too many login attempts.',
                    description: 'Please try again in 5 minutes.',
                    buttonText: 'Try again',
                    onPressed: () {
                      setState(() {
                        showRegistrationError = false;
                      });
                    },
                  ),
                ],

                const SizedBox(height: AppDimensions.spaceXL),

                // Terms Text
                Text(
                  'By continuing, you agree to the',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: AppDimensions.spaceXS + 3),

                // Terms and Privacy Policy
                Wrap(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigate to Terms of Service.
                      },
                      child: const Text(
                        'Terms of Service',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Text(
                      ' and ',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to Privacy Policy.
                      },
                      child: const Text(
                        'Privacy Policy',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppDimensions.spaceLG + 5),

                // Create Account Button
                PrimaryButton(
                  text: 'Create account',
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.verifyEmail);
                  },
                ),

                const SizedBox(height: AppDimensions.spaceSM + 7),

                // OR Divider
                const OrDivider(),

                const SizedBox(height: AppDimensions.spaceMD + 1),

                // Google Sign Up
                SocialButton(
                  text: 'Sign up with Google',
                  onPressed: () {
                    // Google authentication.
                  },
                ),

                const SizedBox(height: AppDimensions.spaceSM + 3),

                // Facebook Sign Up
                SocialButton(
                  text: 'Sign up with Facebook',
                  onPressed: () {
                    // Facebook authentication.
                  },
                ),

                const SizedBox(height: AppDimensions.spaceSM),

                // Already Have Account
                Center(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: RichText(
                      text: TextSpan(
                        style: AppTextStyles.body.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                        children: const [
                          TextSpan(
                            text: 'Already have an account? ',
                          ),
                          TextSpan(
                            text: 'Log in',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppDimensions.spaceXS + 1),
              ],
      ),
    );
  }
}