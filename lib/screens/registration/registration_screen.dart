import 'dart:async';
import 'dart:convert';

import 'package:material_ui/material_ui.dart';
import 'package:http/http.dart' as http;

import 'package:brilliant_rocket/config/app_routes.dart';
import 'package:brilliant_rocket/theme/app_colors.dart';
import 'package:brilliant_rocket/theme/app_dimensions.dart';
import 'package:brilliant_rocket/theme/app_text_styles.dart';

import 'package:brilliant_rocket/widgets/buttons/primary_button.dart';
import 'package:brilliant_rocket/widgets/inputs/app_text_field.dart';
import 'package:brilliant_rocket/widgets/inputs/password_field.dart';
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

  bool isSubmitting = false;

  static const String registerUrl =
      'http://10.0.2.2:8019/api/v1/auth/register';

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
      ),
    );
  }

  // NAVIGATE TO EMAIL VERIFICATION
  void navigateToVerification({
    required String email,
    required String statusToken,
    String? name,
    bool isPending = false,
  }) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.verifyEmail,
      (route) => false,
      arguments: {
        'email': email,
        'status_token': statusToken,
        'is_pending': isPending,
        'name': ?name,
      },
    );
  }

  // REGISTER
  Future<void> register() async {
    if (isSubmitting) return;

    final String name = nameController.text.trim();
    final String email = emailController.text.trim();
    final String password = passwordController.text;
    final String confirmPassword = confirmPasswordController.text;

    // VALIDATION
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      showMessage('Please complete all required fields.');
      return;
    }

    if (!RegExp(
      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
    ).hasMatch(email)) {
      showMessage('Please enter a valid email address.');
      return;
    }

    if (password != confirmPassword) {
      showMessage('Passwords do not match.');
      return;
    }

    setState(() {
      isSubmitting = true;
    });

    try {
      final response = await http
          .post(
            Uri.parse(registerUrl),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode({
              'name': name,
              'email': email,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 20));

      dynamic decodedResponse;

      try {
        decodedResponse = jsonDecode(response.body);
      } catch (_) {
        decodedResponse = null;
      }

      final Map<String, dynamic> responseData =
          decodedResponse is Map
              ? Map<String, dynamic>.from(decodedResponse)
              : {};

      final Map<String, dynamic> responseDetails =
          responseData['data'] is Map
              ? Map<String, dynamic>.from(responseData['data'])
              : {};

      if (!mounted) return;

      // CASE 1: EXISTING PENDING REGISTRATION
      final bool verificationPending =
          responseDetails['verification_pending'] == true;

      if (verificationPending) {
        final String existingEmail =
            responseDetails['email']?.toString() ?? '';

        final String existingStatusToken =
            responseDetails['status_token']?.toString() ?? '';

        if (existingEmail.isEmpty || existingStatusToken.isEmpty) {
          showMessage(
            'Pending registration information is incomplete.',
          );
          debugPrint('Registration response: ${response.body}');
          return;
        }

        // Continue with the PREVIOUS registration.
        // Do not pass the newly entered name or password.
        navigateToVerification(
          email: existingEmail,
          statusToken: existingStatusToken,
          isPending: true,
        );

        return;
      }

      // CASE 2: NEW REGISTRATION
      final bool success =
          response.statusCode >= 200 &&
          response.statusCode < 300 &&
          responseData['success'] == true;

      if (success) {
        final String returnedEmail =
            responseDetails['email']?.toString() ?? '';

        final String returnedStatusToken =
            responseDetails['status_token']?.toString() ?? '';

        if (returnedEmail.isEmpty || returnedStatusToken.isEmpty) {
          showMessage(
            'Registration response is missing verification information.',
          );

          debugPrint('Registration response: ${response.body}');
          return;
        }

        navigateToVerification(
          email: returnedEmail,
          statusToken: returnedStatusToken,
          name: name,
        );

        return;
      }

      // CASE 3: ALREADY VERIFIED OR OTHER REGISTRATION ERROR
      final String message =
          responseData['message']?.toString() ??
              'Registration failed. Please try again.';

      showMessage(message);
    } on TimeoutException {
      if (mounted) {
        showMessage('The request timed out. Please try again.');
      }
    } on http.ClientException {
      if (mounted) {
        showMessage('Could not connect to the server.');
      }
    } catch (e) {
      if (mounted) {
        showMessage('Something went wrong. Please try again.');
      }

      debugPrint('Registration error: $e');
    } finally {
      if (mounted) {
        setState(() {
          isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      backgroundColor: AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppDimensions.spaceMD - 1),

          // BACK BUTTON
          const AppBackButton(),

          const SizedBox(height: AppDimensions.spaceXS - 1),

          // HEADING AND SUBTITLE
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

          // FULL NAME
          AppTextField(
            labelText: 'Full name',
            hintText: 'Your full name',
            controller: nameController,
            textInputAction: TextInputAction.next,
          ),

          const SizedBox(height: AppDimensions.spaceXS + 2),

          // EMAIL
          AppTextField(
            labelText: 'Email address',
            hintText: 'you@example.com',
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),

          const SizedBox(height: AppDimensions.spaceXS + 2),

          // PASSWORD
          PasswordField(
            labelText: 'Password',
            controller: passwordController,
            hintText: 'Create a password',
            textInputAction: TextInputAction.next,
          ),

          const SizedBox(height: AppDimensions.spaceXS + 2),

          // CONFIRM PASSWORD
          PasswordField(
            labelText: 'Confirm password',
            controller: confirmPasswordController,
            hintText: 'Re-enter your password',
            textInputAction: TextInputAction.done,
          ),

          const SizedBox(height: AppDimensions.spaceXL),

          // TERMS TEXT
          Text(
            'By continuing, you agree to the',
            style: AppTextStyles.body.copyWith(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: AppDimensions.spaceXS + 3),

          // TERMS AND PRIVACY POLICY
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

          // CREATE ACCOUNT BUTTON
          PrimaryButton(
            text: isSubmitting ? 'Creating account...' : 'Create account',
            onPressed: register,
          ),

          const SizedBox(height: AppDimensions.spaceSM + 7),

          // OR DIVIDER
          const OrDivider(),

          const SizedBox(height: AppDimensions.spaceMD + 1),

          // GOOGLE SIGN UP
          SocialButton(
            text: 'Sign up with Google',
            onPressed: () {
              // Google authentication.
            },
          ),

          const SizedBox(height: AppDimensions.spaceSM + 3),

          // FACEBOOK SIGN UP
          SocialButton(
            text: 'Sign up with Facebook',
            onPressed: () {
              // Facebook authentication.
            },
          ),

          const SizedBox(height: AppDimensions.spaceSM),

          // ALREADY HAVE ACCOUNT
          Center(
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, AppRoutes.login),
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