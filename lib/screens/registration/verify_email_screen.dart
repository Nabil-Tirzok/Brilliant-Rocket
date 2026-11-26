import 'dart:convert';

import 'package:material_ui/material_ui.dart';
import 'package:http/http.dart' as http;

import 'package:brilliant_rocket/config/app_routes.dart';
import 'package:brilliant_rocket/theme/app_colors.dart';
import 'package:brilliant_rocket/theme/app_dimensions.dart';
import 'package:brilliant_rocket/theme/app_text_styles.dart';
import 'package:brilliant_rocket/widgets/buttons/back_button.dart';
import 'package:brilliant_rocket/widgets/buttons/primary_button.dart';
import 'package:brilliant_rocket/widgets/recovery/recovery_error_card.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  static const String verificationStatusUrl =
      'http://10.0.2.2:8019/api/v1/auth/verification-status';

  String email = '';
  String statusToken = '';

  bool isChecking = false;
  bool isPending = false;
  bool isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (isInitialized) return;

    final arguments = ModalRoute.of(context)?.settings.arguments;

    if (arguments is Map) {
      email = arguments['email']?.toString() ?? '';
      statusToken = arguments['status_token']?.toString() ?? '';
    }

    isInitialized = true;
  }

  String get maskedEmail {
    if (!email.contains('@')) return email;

    final parts = email.split('@');
    final username = parts[0];

    if (username.length <= 2) {
      return '${username[0]}***@${parts[1]}';
    }

    return '${username.substring(0, 2)}***@${parts[1]}';
  }

  Future<void> checkVerificationStatus() async {
    if (isChecking) return;

    if (email.isEmpty || statusToken.isEmpty) {
      showMessage('Verification information is missing.');
      return;
    }

    setState(() {
      isChecking = true;
    });

    try {
      final response = await http
          .post(
            Uri.parse(verificationStatusUrl),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode({
              'email': email,
              'status_token': statusToken,
            }),
          )
          .timeout(const Duration(seconds: 20));

      final Map<String, dynamic> responseData =
          jsonDecode(response.body) as Map<String, dynamic>;

      if (!mounted) return;

      if (response.statusCode >= 200 &&
          response.statusCode < 300 &&
          responseData['success'] == true) {
        final bool verified =
            responseData['verified'] == true ||
            responseData['is_verified'] == true;

        if (verified) {
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.emailVerified,
          );
          return;
        }

        setState(() {
          isPending = true;
        });

        return;
      }

      showMessage(
        responseData['message']?.toString() ??
            'Unable to check your verification status.',
      );
    } catch (error) {
      if (!mounted) return;

      showMessage(
        'Unable to connect. Please check your internet connection and try again.',
      );
    } finally {
      if (mounted) {
        setState(() {
          isChecking = false;
        });
      }
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppBackButton(),

              const SizedBox(height: AppDimensions.spaceXXL),

              if (isPending)
                RecoveryCard(
                  header: 'Verification · Still pending',
                  title: 'Your email is not verified yet.',
                  description:
                      'Open the latest link in your email.\n'
                      'Allow another status check after completion.',
                  buttonText: isChecking ? 'Checking...' : 'Check again',
                  onPressed: isChecking
                      ? () {}
                      : checkVerificationStatus,
                )
              else ...[
                const Icon(
                  Icons.mark_email_unread_outlined,
                  size: 58,
                  color: AppColors.primary,
                ),

                const SizedBox(height: AppDimensions.spaceXL),

                Text(
                  'Verify your email',
                  style: AppTextStyles.heading,
                ),

                const SizedBox(height: AppDimensions.spaceMD),

                Text(
                  'We have sent a verification link to your email address.',
                  style: AppTextStyles.body,
                ),

                const SizedBox(height: AppDimensions.spaceXL),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(
                    AppDimensions.cardPadding,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(
                      AppDimensions.cardRadius,
                    ),
                    border: Border.all(
                      color: AppColors.border,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Check your inbox',
                        style: AppTextStyles.bodyEmphasis,
                      ),

                      const SizedBox(height: AppDimensions.spaceSM),

                      Text(
                        maskedEmail,
                        style: AppTextStyles.bodySmall,
                      ),

                      const SizedBox(height: AppDimensions.spaceMD),

                      Text(
                        'Open the latest verification link in your email '
                        'to activate your account.',
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppDimensions.spaceXL),

                PrimaryButton(
                  text: isChecking
                      ? 'Checking...'
                      : 'I have verified my email',
                  onPressed: isChecking
                      ? () {}
                      : checkVerificationStatus,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}