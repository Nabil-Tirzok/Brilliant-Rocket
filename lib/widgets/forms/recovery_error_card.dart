import 'package:material_ui/material_ui.dart';

import 'package:brilliant_rocket/theme/app_colors.dart';
import 'package:brilliant_rocket/theme/app_dimensions.dart';
import 'app_info_card.dart';

class RecoveryCard extends StatelessWidget {
  final String header;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onPressed;

  const RecoveryCard({
    super.key,
    required this.header,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppInfoCard(
      height: 274,
      padding: const EdgeInsets.all(18),
      backgroundColor: AppColors.surface,
      showBorder: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            header,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(height: 23),

          // Error title
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 15),

          // Error description
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              height: 1.6,
              color: AppColors.textSecondary,
            ),
          ),

          const SizedBox(height: AppDimensions.spaceXXXL),

          // Action button
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.lightBlue,
                foregroundColor: AppColors.primary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppDimensions.borderRadius,
                  ),
                ),
              ),
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}