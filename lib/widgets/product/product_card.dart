import 'package:material_ui/material_ui.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../theme/app_text_styles.dart';

class ProductCard extends StatefulWidget {
  final String name;
  final String price;
  final String rating;
  final String reviewCount;
  final String stockText;
  final VoidCallback? onPressed;
  final ValueChanged<bool>? onFavoriteChanged;

  const ProductCard({
    super.key,
    this.name = 'Classic Bifold',
    this.price = '৳1,490',
    this.rating = '4.8',
    this.reviewCount = '124',
    this.stockText = 'In stock',
    this.onPressed,
    this.onFavoriteChanged,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });

    widget.onFavoriteChanged?.call(isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 168,
      padding: const EdgeInsets.all(AppDimensions.spaceSM + 1),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // PRODUCT IMAGE
          Stack(
            children: [
              Container(
                height: 133,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFF4EBDD),
                  borderRadius: BorderRadius.circular(
                    AppDimensions.borderRadius - 1,
                  ),
                ),
                child: CustomPaint(
                  painter: WalletPainter(),
                ),
              ),

              // FAVORITE BUTTON
              Positioned(
                top: 6,
                right: 6,
                child: GestureDetector(
                  onTap: toggleFavorite,
                  child: Container(
                    height: 43,
                    width: 43,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Icon(
                      isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: isFavorite
                          ? AppColors.error
                          : AppColors.darkBlue,
                      size: 22,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppDimensions.spaceMD),

          // PRODUCT NAME
          Text(
            widget.name,
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: AppDimensions.spaceXL),

          // PRICE
          Text(
            widget.price,
            style: AppTextStyles.bodyEmphasis,
          ),

          const SizedBox(height: AppDimensions.spaceSM),

          // RATING AND STOCK
          Row(
            children: [
              const Icon(
                Icons.star,
                size: 12,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 2),
              Expanded(
                child: Text(
                  '${widget.rating} (${widget.reviewCount}) · ${widget.stockText}',
                  style: AppTextStyles.helper.copyWith(
                    fontSize: 10,
                    height: 1.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppDimensions.spaceSM),

          // VIEW OPTIONS BUTTON
          SizedBox(
            width: double.infinity,
            height: AppDimensions.compactButtonHeight,
            child: OutlinedButton(
              onPressed: widget.onPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.textPrimary,
                side: const BorderSide(
                  color: AppColors.border,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppDimensions.borderRadius,
                  ),
                ),
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
              ),
              child: Text(
                'View options',
                style: AppTextStyles.buttonSmall.copyWith(
                  fontSize: 12,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// WALLET ILLUSTRATION
class WalletPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final walletPaint = Paint()
      ..color = const Color(0xFF814326)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = const Color(0xFF482A1C)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final stitchPaint = Paint()
      ..color = const Color(0xFFC18B5D)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.12)
      ..style = PaintingStyle.fill;

    // WALLET SHADOW
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height * 0.79),
        width: size.width * 0.68,
        height: 13,
      ),
      shadowPaint,
    );

    // WALLET BODY
    final walletRect = Rect.fromCenter(
      center: Offset(size.width * 0.5, size.height * 0.46),
      width: size.width * 0.68,
      height: size.height * 0.43,
    );

    final walletPath = Path()
      ..moveTo(walletRect.left + 9, walletRect.top)
      ..lineTo(walletRect.right - 9, walletRect.top)
      ..quadraticBezierTo(
        walletRect.right,
        walletRect.top,
        walletRect.right,
        walletRect.top + 10,
      )
      ..lineTo(walletRect.right + 3, walletRect.bottom - 9)
      ..quadraticBezierTo(
        walletRect.right + 3,
        walletRect.bottom,
        walletRect.right - 10,
        walletRect.bottom,
      )
      ..lineTo(walletRect.left + 9, walletRect.bottom + 2)
      ..quadraticBezierTo(
        walletRect.left,
        walletRect.bottom + 2,
        walletRect.left,
        walletRect.bottom - 9,
      )
      ..lineTo(walletRect.left - 2, walletRect.top + 11)
      ..quadraticBezierTo(
        walletRect.left - 2,
        walletRect.top,
        walletRect.left + 9,
        walletRect.top,
      )
      ..close();

    canvas.drawPath(walletPath, walletPaint);
    canvas.drawPath(walletPath, borderPaint);

    // INNER STITCHING
    final innerPath = Path()
      ..moveTo(walletRect.left + 9, walletRect.top + 9)
      ..lineTo(walletRect.right - 9, walletRect.top + 9)
      ..lineTo(walletRect.right - 3, walletRect.bottom - 9)
      ..lineTo(walletRect.left + 7, walletRect.bottom - 7);

    canvas.drawPath(innerPath, stitchPaint);

    // BRAND TEXT
    final textPainter = TextPainter(
      text: const TextSpan(
        text: 'TANNIX',
        style: TextStyle(
          color: Color(0xFFD9B68F),
          fontSize: 7,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    textPainter.paint(
      canvas,
      Offset(
        size.width / 2 - textPainter.width / 2,
        size.height * 0.55,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant WalletPainter oldDelegate) {
    return false;
  }
}