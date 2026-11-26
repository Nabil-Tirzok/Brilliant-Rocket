import 'package:material_ui/material_ui.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/buttons/back_button.dart';

class RatingsScreen extends StatefulWidget {
  const RatingsScreen({super.key});

  @override
  State<RatingsScreen> createState() => _RatingsScreenState();
}

class _RatingsScreenState extends State<RatingsScreen> {
  String selectedRating = 'All ratings';
  String selectedSort = 'Most recent';

  final List<Map<String, dynamic>> ratingData = [
    {'star': 5, 'count': 105, 'percentage': 0.80},
    {'star': 4, 'count': 14, 'percentage': 0.10},
    {'star': 3, 'count': 3, 'percentage': 0.02},
    {'star': 2, 'count': 1, 'percentage': 0.01},
    {'star': 1, 'count': 1, 'percentage': 0.01},
  ];

  final List<Map<String, String>> reviews = [
    {
      'initials': 'RH',
      'name': 'Rafiq H.',
      'rating': '★★★★★',
      'title': 'Great everyday wallet',
      'description': 'Slim, well finished and easy to carry.',
      'color': 'Brown',
    },
    {
      'initials': 'NS',
      'name': 'Nadia S.',
      'rating': '★★★★☆',
      'title': 'Beautiful leather',
      'description': 'Lovely texture. The card slots felt snug at first.',
      'color': 'Brown',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
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
                    'Ratings & reviews',
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

            // MAIN CONTENT
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.screenPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // RATING SUMMARY
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '4.8',
                                style: AppTextStyles.heading.copyWith(
                                  fontSize: 46,
                                ),
                              ),
                              const Text(
                                '★★★★★',
                                style: TextStyle(
                                  fontSize: 21,
                                  letterSpacing: 1,
                                  color: Color(0xFFE58B00),
                                ),
                              ),
                              const SizedBox(
                                height: AppDimensions.spaceMD,
                              ),
                              const Text(
                                '124 reviews',
                                style: AppTextStyles.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Column(
                            children: ratingData.map((item) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  bottom: AppDimensions.spaceMD,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      '${item['star']}',
                                      style: AppTextStyles.bodySmall.copyWith(
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: AppDimensions.spaceXS,
                                    ),
                                    const Icon(
                                      Icons.star,
                                      size: 20,
                                      color: Color(0xFFE58B00),
                                    ),
                                    const SizedBox(
                                      width: AppDimensions.spaceSM,
                                    ),
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          AppDimensions.borderRadius,
                                        ),
                                        child: LinearProgressIndicator(
                                          value: item['percentage'],
                                          minHeight: 8,
                                          backgroundColor: AppColors.border,
                                          valueColor:
                                              const AlwaysStoppedAnimation<
                                                Color
                                              >(AppColors.primary),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: AppDimensions.spaceSM,
                                    ),
                                    SizedBox(
                                      width: 24,
                                      child: Text(
                                        '${item['count']}',
                                        textAlign: TextAlign.right,
                                        style: AppTextStyles.bodySmall,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: AppDimensions.spaceXL,
                    ),

                    // DROPDOWN FILTERS
                    Row(
                      children: [
                        Expanded(
                          child: dropdownFilter(
                            selectedRating,
                            [
                              'All ratings',
                              '5 stars',
                              '4 stars',
                              '3 stars',
                              '2 stars',
                              '1 star',
                            ],
                            (value) {
                              if (value == null) return;

                              setState(() {
                                selectedRating = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          width: AppDimensions.spaceMD,
                        ),
                        Expanded(
                          child: dropdownFilter(
                            selectedSort,
                            [
                              'Most recent',
                              'Oldest',
                              'Highest rated',
                              'Lowest rated',
                            ],
                            (value) {
                              if (value == null) return;

                              setState(() {
                                selectedSort = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: AppDimensions.spaceLG,
                    ),

                    // WRITE REVIEW BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: AppDimensions.compactButtonHeight,
                      child: OutlinedButton(
                        onPressed: () {
                          showWriteReviewDialog(context);
                        },
                        child: const Text('Write a review'),
                      ),
                    ),

                    const SizedBox(
                      height: AppDimensions.spaceMD,
                    ),

                    // REVIEW CARDS
                    ...reviews.map((review) => reviewCard(review)),

                    const SizedBox(
                      height: AppDimensions.spaceXL,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // DROPDOWN FILTER
  Widget dropdownFilter(
    String value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return Container(
      height: AppDimensions.compactButtonHeight,
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spaceSM,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.border,
        ),
        borderRadius: BorderRadius.circular(
          AppDimensions.borderRadius,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            size: 19,
            color: AppColors.textSecondary,
          ),
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textPrimary,
          ),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  // REVIEW CARD
  Widget reviewCard(Map<String, String> review) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        bottom: AppDimensions.spaceMD,
      ),
      padding: const EdgeInsets.all(
        AppDimensions.cardPadding,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(
          color: AppColors.border,
        ),
        borderRadius: BorderRadius.circular(
          AppDimensions.cardRadius,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.lightBlue,
                child: Text(
                  review['initials']!,
                  style: AppTextStyles.label.copyWith(
                    color: AppColors.darkBlue,
                  ),
                ),
              ),
              const SizedBox(
                width: AppDimensions.spaceSM,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review['name']!,
                    style: AppTextStyles.bodyEmphasis,
                  ),
                  const SizedBox(
                    height: AppDimensions.spaceXS,
                  ),
                  Text(
                    'Verified purchase',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(
            height: AppDimensions.spaceMD,
          ),

          // STAR RATING
          Text(
            review['rating']!,
            style: const TextStyle(
              color: Color(0xFFE58B00),
              fontSize: 14,
              letterSpacing: 1,
            ),
          ),

          const SizedBox(
            height: AppDimensions.spaceMD,
          ),

          // REVIEW TITLE
          Text(
            review['title']!,
            style: AppTextStyles.bodyEmphasis,
          ),

          const SizedBox(
            height: AppDimensions.spaceMD,
          ),

          // REVIEW DESCRIPTION
          Text(
            review['description']!,
            style: AppTextStyles.body,
          ),

          const SizedBox(
            height: AppDimensions.spaceMD,
          ),

          // PRODUCT COLOUR
          Text(
            review['color']!,
            style: AppTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }

  // WRITE REVIEW DIALOG
  void showWriteReviewDialog(BuildContext context) {
    int rating = 5;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Write a review'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Rate this product'),
                  const SizedBox(
                    height: AppDimensions.spaceMD,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        onPressed: () {
                          setDialogState(() {
                            rating = index + 1;
                          });
                        },
                        icon: Icon(
                          index < rating
                              ? Icons.star
                              : Icons.star_border,
                          color: const Color(0xFFE58B00),
                          size: 30,
                        ),
                      );
                    }),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'Review title',
                    ),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'Write your review...',
                    ),
                    maxLines: 3,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Submit'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}