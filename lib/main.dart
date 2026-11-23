import 'package:material_ui/material_ui.dart';

import 'package:brilliant_rocket/config/app_routes.dart';
import 'package:brilliant_rocket/screens/launch/launch_screen.dart';
import 'package:brilliant_rocket/screens/login/login_screen.dart';
import 'package:brilliant_rocket/screens/login/forgot_password_screen.dart';
import 'package:brilliant_rocket/screens/login/set_new_password_screen.dart';
import 'package:brilliant_rocket/screens/registration/registration_screen.dart';
import 'package:brilliant_rocket/screens/registration/verify_email_screen.dart';
import 'package:brilliant_rocket/screens/login/password_updated_screen.dart';
import 'package:brilliant_rocket/screens/registration/email_verified_screen.dart';
import 'package:brilliant_rocket/screens/registration/link_expired_screen.dart';
import 'package:brilliant_rocket/screens/login/finish_signing_screen.dart';
import 'package:brilliant_rocket/screens/product_details.dart';
import 'package:brilliant_rocket/theme/app_theme.dart';

void main() {
  runApp(const BrilliantRocketApp());
}

class BrilliantRocketApp extends StatelessWidget {
  const BrilliantRocketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brilliant Rocket',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,

      initialRoute: AppRoutes.launch,

      routes: {
        AppRoutes.launch: (context) => const LaunchScreen(),
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.register: (context) => const RegisterScreen(),
        AppRoutes.forgotPassword: (context) => const ForgotPasswordScreen(),
        AppRoutes.verifyEmail: (context) => const VerifyEmailScreen(),
        AppRoutes.setNewPassword: (context) => const SetNewPasswordScreen(),
        AppRoutes.passwordUpdated: (context) => const PasswordUpdatedScreen(),
        AppRoutes.emailVerified: (context) => const EmailVerifiedScreen(),
        AppRoutes.linkExpired: (context) => const LinkExpiredScreen(),
        AppRoutes.finishSigning: (context) => const FinishSigningScreen(),
        AppRoutes.product: (context) => const ProductPage(),
      },
    );
  }
}