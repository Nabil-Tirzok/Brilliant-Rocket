import 'package:material_ui/material_ui.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_dimensions.dart';
import '../../../theme/app_text_styles.dart';
import '../../../widgets/buttons/app_text_button.dart';
import '../../../widgets/buttons/primary_button.dart';

class SearchHistoryView extends StatelessWidget {
  final List<String> recentSearches;
  final ValueChanged<int> onRemoveSearch;
  final VoidCallback onClearSearches;
  final VoidCallback onBrowseAllProducts;

  const SearchHistoryView({
    super.key,
    required this.recentSearches,
    required this.onRemoveSearch,
    required this.onClearSearches,
    required this.onBrowseAllProducts,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.screenPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppDimensions.spaceXXL),

                // MAIN HEADING
                const Text(
                  'Find your everyday carry.',
                  style: AppTextStyles.sectionHeading,
                ),

                const SizedBox(height: AppDimensions.spaceSM),

                const Text(
                  'Search by product, colour or material.',
                  style: AppTextStyles.bodySmall,
                ),

                const SizedBox(height: AppDimensions.spaceXXL),

                // RECENT SEARCHES
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recent searches',
                      style: AppTextStyles.bodyEmphasis,
                    ),
                    if (recentSearches.isNotEmpty)
                      AppTextButton(
                        text: 'Clear all',
                        onPressed: onClearSearches,
                        textStyle: AppTextStyles.link,
                      ),
                  ],
                ),

                const SizedBox(height: AppDimensions.spaceSM),

                // RECENT SEARCHES LIST
                if (recentSearches.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppDimensions.spaceLG,
                    ),
                    child: Text(
                      'No recent searches',
                      style: AppTextStyles.bodySmall,
                    ),
                  )
                else
                  ...List.generate(
                    recentSearches.length,
                    (index) => recentSearchItem(index),
                  ),

                const SizedBox(height: AppDimensions.spaceXL),

                // POPULAR SEARCHES
                const Text(
                  'Popular searches',
                  style: AppTextStyles.bodyEmphasis,
                ),

                const SizedBox(height: AppDimensions.spaceMD),

                Wrap(
                  spacing: AppDimensions.spaceSM,
                  runSpacing: AppDimensions.spaceSM,
                  children: [
                    popularChip('Slim wallets'),
                    popularChip('Leather belts'),
                    popularChip('Work bags'),
                  ],
                ),

                const SizedBox(height: AppDimensions.spaceXL),

                // SHOP BY CATEGORY
                const Text(
                  'Shop by category',
                  style: AppTextStyles.bodyEmphasis,
                ),

                const SizedBox(height: AppDimensions.spaceMD),

                Row(
                  children: [
                    Expanded(
                      child: categoryButton('Wallets'),
                    ),
                    const SizedBox(width: AppDimensions.spaceSM),
                    Expanded(
                      child: categoryButton('Bags'),
                    ),
                  ],
                ),

                const SizedBox(height: AppDimensions.spaceXL),
              ],
            ),
          ),
        ),

        // BROWSE ALL PRODUCTS BUTTON
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.screenPadding,
            vertical: AppDimensions.spaceSM,
          ),
          child: SizedBox(
            width: double.infinity,
            child: _BrowseProductsButton(
              onPressed: onBrowseAllProducts,
            ),
          ),
        ),
      ],
    );
  }

  // RECENT SEARCH ITEM
  Widget recentSearchItem(int index) {
    return Container(
      height: 54,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.border,
            width: AppDimensions.borderWidth,
          ),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.access_time,
            size: 18,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: AppDimensions.spaceLG),
          Expanded(
            child: Text(
              recentSearches[index],
              style: AppTextStyles.body,
            ),
          ),
          IconButton(
            onPressed: () => onRemoveSearch(index),
            icon: const Icon(
              Icons.close,
              size: 18,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  // POPULAR SEARCH CHIP
  Widget popularChip(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spaceLG,
        vertical: AppDimensions.spaceMD,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(
          color: AppColors.border,
        ),
        borderRadius: BorderRadius.circular(
          AppDimensions.borderRadius,
        ),
      ),
      child: Text(
        title,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  // CATEGORY BUTTON
  Widget categoryButton(String title) {
    return Container(
      height: AppDimensions.buttonHeight,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        border: Border.all(
          color: AppColors.border,
        ),
        borderRadius: BorderRadius.circular(
          AppDimensions.borderRadius,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppTextStyles.bodyEmphasis,
          ),
          const SizedBox(width: AppDimensions.spaceSM),
          const Icon(
            Icons.arrow_forward,
            size: 18,
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }
}

// BROWSE ALL PRODUCTS BUTTON
class _BrowseProductsButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _BrowseProductsButton({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      text: 'Browse all products',
      onPressed: onPressed,
    );
  }
}