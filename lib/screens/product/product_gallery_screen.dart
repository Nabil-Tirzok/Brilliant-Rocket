import 'package:material_ui/material_ui.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/buttons/back_button.dart';

class ProductGalleryScreen extends StatefulWidget {
  const ProductGalleryScreen({super.key});

  @override
  State<ProductGalleryScreen> createState() => _ProductGalleryScreenState();
}

class _ProductGalleryScreenState extends State<ProductGalleryScreen> {
  final PageController _pageController = PageController();

  int selectedIndex = 0;

  final List<String> images = [
    'assets/wallet1.png',
    'assets/wallet2.png',
    'assets/wallet3.png',
    'assets/wallet4.png',
  ];

  void changeImage(int index) {
    if (index < 0 || index >= images.length) return;

    setState(() {
      selectedIndex = index;
    });

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void showFullscreenImage() {
    showDialog(
      context: context,
      barrierColor: Colors.black,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(AppDimensions.spaceMD),
          child: Stack(
            children: [
              Center(
                child: InteractiveViewer(
                  minScale: 1,
                  maxScale: 4,
                  child: Image.asset(
                    images[selectedIndex],
                    fit: BoxFit.contain,
                    width: double.infinity,
                  ),
                ),
              ),
              Positioned(
                top: AppDimensions.spaceSM,
                right: AppDimensions.spaceSM,
                child: IconButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.surface,
                    size: 28,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            // APP BAR
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.screenPadding,
                vertical: AppDimensions.spaceSM,
              ),
              child: Row(
                children: [
                  const AppBackButton(),
                  const SizedBox(width: AppDimensions.spaceXL),
                  const Text(
                    'Image gallery',
                    style: AppTextStyles.bodyEmphasis,
                  ),
                  const Spacer(),
                  const Text(
                    'Bag · 2',
                    style: AppTextStyles.label,
                  ),
                ],
              ),
            ),

            // PRODUCT TITLE AND COUNTER
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppDimensions.screenPadding,
                AppDimensions.spaceMD,
                AppDimensions.screenPadding,
                AppDimensions.spaceSM,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Classic Bifold Wallet',
                    style: AppTextStyles.bodyEmphasis,
                  ),
                  Text(
                    '${selectedIndex + 1} / ${images.length}',
                    style: AppTextStyles.bodySmall,
                  ),
                ],
              ),
            ),

            // MAIN IMAGE GALLERY
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.screenPadding,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    AppDimensions.cardRadius,
                  ),
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        itemCount: images.length,
                        onPageChanged: (index) {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return Container(
                            width: double.infinity,
                            color: const Color(0xFFF4F0EC),
                            padding: const EdgeInsets.all(
                              AppDimensions.spaceMD,
                            ),
                            child: Image.asset(
                              images[index],
                              fit: BoxFit.contain,
                              alignment: Alignment.center,
                            ),
                          );
                        },
                      ),

                      // ZOOM BUTTON
                      Positioned(
                        top: AppDimensions.spaceSM,
                        right: AppDimensions.spaceSM,
                        child: Material(
                          color: AppColors.surface,
                          shape: const CircleBorder(),
                          child: IconButton(
                            onPressed: showFullscreenImage,
                            icon: const Icon(
                              Icons.fullscreen,
                              color: AppColors.darkBlue,
                              size: AppDimensions.iconSize,
                            ),
                          ),
                        ),
                      ),

                      // IMAGE COUNTER
                      Positioned(
                        bottom: AppDimensions.spaceSM,
                        right: AppDimensions.spaceSM,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimensions.spaceMD,
                            vertical: AppDimensions.spaceSM,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${selectedIndex + 1} / ${images.length}',
                            style: AppTextStyles.label,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppDimensions.spaceMD),

            // THUMBNAIL IMAGES
            SizedBox(
              height: 84,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.screenPadding,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  final isSelected = selectedIndex == index;

                  return GestureDetector(
                    onTap: () => changeImage(index),
                    child: Container(
                      width: 81,
                      margin: const EdgeInsets.only(
                        right: AppDimensions.spaceSM,
                      ),
                      padding: const EdgeInsets.all(
                        AppDimensions.spaceXS,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F0EC),
                        borderRadius: BorderRadius.circular(
                          AppDimensions.borderRadius,
                        ),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.border,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.spaceSM,
                        ),
                        child: Image.asset(
                          images[index],
                          fit: BoxFit.contain,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: AppDimensions.spaceMD),

            // PREVIOUS AND NEXT BUTTONS
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.screenPadding,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: selectedIndex > 0
                          ? () => changeImage(selectedIndex - 1)
                          : null,
                      child: const Text('← Previous'),
                    ),
                  ),
                  const SizedBox(width: AppDimensions.spaceMD),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: selectedIndex < images.length - 1
                          ? () => changeImage(selectedIndex + 1)
                          : null,
                      child: const Text('Next →'),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppDimensions.spaceMD),

            // BOTTOM HINT
            const Padding(
              padding: EdgeInsets.only(
                bottom: AppDimensions.spaceLG,
              ),
              child: Text(
                'Front view · Swipe for more',
                style: AppTextStyles.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}