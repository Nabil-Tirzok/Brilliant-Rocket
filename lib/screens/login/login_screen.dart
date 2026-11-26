import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:material_ui/material_ui.dart';

import 'package:brilliant_rocket/config/app_config.dart';
import 'package:brilliant_rocket/config/app_routes.dart';
import 'package:brilliant_rocket/theme/app_colors.dart';
import 'package:brilliant_rocket/theme/app_text_styles.dart';

import 'package:brilliant_rocket/widgets/inputs/app_text_field.dart';
import 'package:brilliant_rocket/widgets/inputs/password_field.dart';
import 'package:brilliant_rocket/widgets/buttons/primary_button.dart';
import 'package:brilliant_rocket/widgets/buttons/back_button.dart';
import 'package:brilliant_rocket/widgets/buttons/app_text_button.dart';
import 'package:brilliant_rocket/widgets/buttons/social_button.dart';
import 'package:brilliant_rocket/widgets/common/or_divider.dart';
import 'package:brilliant_rocket/widgets/layout/app_page.dart';
import 'package:brilliant_rocket/widgets/layout/app_page_header.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  // Odoo session cookie captured after successful login.
  // Subsequent authenticated API requests must send this cookie.
  static String? sessionCookie;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isSubmitting = false;

  String? loginErrorMessage;

  static const String loginUrl =
      'http://10.0.2.2:8019/api/v1/auth/login';

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // --------------------------------------------------
  // LOGIN
  // --------------------------------------------------

  Future<void> login() async {
    final email = emailController.text.trim().toLowerCase();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        loginErrorMessage = 'Please enter your email and password.';
      });
      return;
    }

    if (!RegExp(
      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
    ).hasMatch(email)) {
      setState(() {
        loginErrorMessage = 'Please enter a valid email address.';
      });
      return;
    }

    setState(() {
      isSubmitting = true;
      loginErrorMessage = null;
    });

    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'login': email,
          'password': password,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (responseData is! Map<String, dynamic>) {
        throw Exception('Invalid server response.');
      }

      final bool success = response.statusCode >= 200 &&
          response.statusCode < 300 &&
          responseData['success'] == true;

      if (!success) {
        setState(() {
          loginErrorMessage =
              responseData['message']?.toString() ??
                  'Unable to log in. Please try again.';
        });
        return;
      }

      // --------------------------------------------------
      // CAPTURE ODOO SESSION COOKIE
      // --------------------------------------------------

      final setCookie = response.headers['set-cookie'];

      if (setCookie != null && setCookie.isNotEmpty) {
        LoginScreen.sessionCookie = setCookie
            .split(';')
            .first;
      }

      final user = responseData['data']?['user'];

      if (user == null) {
        setState(() {
          loginErrorMessage =
              'Login succeeded, but user information was not returned.';
        });
        return;
      }

      debugPrint('Login successful.');
      debugPrint('User: $user');

      if (!mounted) return;

      Navigator.of(context).pushNamedAndRemoveUntil(
         AppRoutes.productDetails,
         (route) => false
      );
    } catch (error) {
      debugPrint('Login error: $error');

      if (!mounted) return;

      setState(() {
        loginErrorMessage =
            'Unable to connect to the server. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() {
          isSubmitting = false;
        });
      }
    }
  }

  // --------------------------------------------------
  // UI
  // --------------------------------------------------

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
                Navigator.pushNamed(
                  context,
                  AppRoutes.forgotPassword,
                );
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
            text: isSubmitting ? 'Logging in...' : 'Log in',
            onPressed: isSubmitting ? () {} : login,
          ),

          // Login Error
          if (loginErrorMessage != null) ...[
            const SizedBox(height: 16),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.08),
                borderRadius: BorderRadius.circular(13),
                border: Border.all(
                  color: AppColors.error.withOpacity(0.3),
                ),
              ),
              child: Text(
                loginErrorMessage!,
                style: AppTextStyles.error,
              ),
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
                    Navigator.pushNamed(
                      context,
                      AppRoutes.register,
                    );
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