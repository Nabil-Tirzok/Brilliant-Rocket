import 'package:material_ui/material_ui.dart';

import 'package:brilliant_rocket/config/app_config.dart';
import 'package:brilliant_rocket/config/app_routes.dart';
import 'package:brilliant_rocket/theme/app_colors.dart';
import 'package:brilliant_rocket/theme/app_text_styles.dart';

import 'package:brilliant_rocket/widgets/inputs/app_text_field.dart';
import 'package:brilliant_rocket/widgets/inputs/password_field.dart';
import 'package:brilliant_rocket/widgets/buttons/primary_button.dart';
import 'package:brilliant_rocket/widgets/forms/recovery_error_card.dart';
import 'package:brilliant_rocket/widgets/buttons/back_button.dart';
import 'package:brilliant_rocket/widgets/buttons/app_text_button.dart';
import 'package:brilliant_rocket/widgets/buttons/social_button.dart';
import 'package:brilliant_rocket/widgets/common/or_divider.dart';
import 'package:brilliant_rocket/widgets/layout/app_page.dart';
import 'package:brilliant_rocket/widgets/layout/app_page_header.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool showLoginError = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      backgroundColor: AppColors.surface,
      child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),

                // Back Button
                const AppBackButton(),

                const SizedBox(height: 16),

                // Title and subtitle
                const AppPageHeader(
                  title: 'Welcome back',
                  description: 'Log in to manage your orders.',
                  spacing: 5,
                ),

                const SizedBox(height: 46),

                // Email Field
                AppTextField(
                  labelText: 'Email address',
                  hintText: 'you@example.com',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),

                const SizedBox(height: 16),

                // Password Field
                PasswordField(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  controller: passwordController,
                  textInputAction: TextInputAction.done,
                ),

                const SizedBox(height: 14),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: AppTextButton(
                    text: 'Forgot password?',
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.forgotPassword);
                    },
                    textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Login Button
                PrimaryButton(
                  text: 'Log in',
                  onPressed: () {
                    setState(() {
                      showLoginError = true;
                    });
                  },
                ),

                // Login Recovery State
                if (showLoginError) ...[
                  const SizedBox(height: 20),

                  RecoveryCard(
                    header: 'Login · Too many attempts',
                    title: 'Too many login attempts.',
                    description: 'Please try again in 5 minutes.',
                    buttonText: 'Try again',
                    onPressed: () {
                      setState(() {
                        showLoginError = false;
                      });
                    },
                  ),
                ],

                const SizedBox(height: 20),

                // OR Divider
                const OrDivider(),

                const SizedBox(height: 14),

                // Google Button
                SocialButton(
                  text: 'Continue with Google',
                  onPressed: () {
                    // Google sign-in functionality.
                  },
                ),

                const SizedBox(height: 11),

                // Facebook Button
                SocialButton(
                  text: 'Continue with Facebook',
                  onPressed: () {
                    // Facebook sign-in functionality.
                  },
                ),

                const SizedBox(height: 45),

                // Create Account Section
                Center(
                  child: Column(
                    children: [
                      Text(
                        'New to ${AppConfig.brandName}?',
                        style: AppTextStyles.body,
                      ),

                      const SizedBox(height: 12),

                      AppTextButton(
                        text: 'Create an account',
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.register);
                        },
                        textStyle: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),
              ],
      ),
    );
  }
}