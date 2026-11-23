import 'package:material_ui/material_ui.dart';
import 'package:brilliant_rocket/config/app_routes.dart';
import 'package:brilliant_rocket/config/app_config.dart';
import 'package:brilliant_rocket/theme/app_text_styles.dart';
import 'package:brilliant_rocket/theme/app_dimensions.dart';
import 'package:brilliant_rocket/theme/app_colors.dart';

import 'package:brilliant_rocket/widgets/branding/brand_logo.dart';
import 'package:brilliant_rocket/widgets/buttons/primary_button.dart';
import 'package:brilliant_rocket/widgets/buttons/secondary_button.dart';

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.screenPadding,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),

                      // Brand logo
                      const Center(
                        child: BrandLogo(
                          imageAsset: 'assets/images/branding/logo1.png',
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Shopping illustration
                      const ShoppingIllustration(),

                      const SizedBox(height: 20),

                      // Heading
                      Text(
                        'Shop with\n${AppConfig.brandName}',
                        style: AppTextStyles.heading,
                      ),

                      const SizedBox(height: 14),

                      // Description
                      const Text(
                        'Browse products and track your orders\n'
                        'from your phone.',
                        style: AppTextStyles.body,
                      ),

                      const SizedBox(height: 46),

                      // Login button
                      PrimaryButton(
                        text: 'Log in',
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.login);
                        },
                      ),

                      const SizedBox(height: 12),

                      // Create account button
                      SecondaryButton(
                        text: 'Create an account',
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.register);
                        },
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// SHOPPING ILLUSTRATION
class ShoppingIllustration extends StatelessWidget {
  const ShoppingIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 266,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background circle
          Container(
            width: 200,
            height: 200,
            decoration: const BoxDecoration(
              color: AppColors.lightBlue,
              shape: BoxShape.circle,
            ),
          ),

          // Shopping bag
          Transform.rotate(
            angle: -0.15,
            child: Container(
              width: 145,
              height: 165,
              margin: const EdgeInsets.only(top: 35),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.darkBlue,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Center(
                child: Icon(
                  Icons.check,
                  color: AppColors.surface,
                  size: 76,
                  weight: 3,
                ),
              ),
            ),
          ),

          // Shopping bag handle
          Positioned(
            top: 22,
            child: CustomPaint(
              size: const Size(75, 60),
              painter: BagHandlePainter(),
            ),
          ),

          // Plus icon
          Positioned(
            right: 58,
            top: 32,
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: AppColors.lightBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add,
                size: 31,
                color: AppColors.primary,
              ),
            ),
          ),

          // Small decorative dot
          Positioned(
            left: 70,
            bottom: 83,
            child: Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                color: AppColors.accentBlue,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// BAG HANDLE

class BagHandlePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.accentBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(10, 48)
      ..cubicTo(0, -10, 75, -10, 65, 48);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}