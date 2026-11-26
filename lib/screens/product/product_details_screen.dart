import 'package:material_ui/material_ui.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/buttons/back_button.dart';
import '../../widgets/buttons/primary_button.dart';
import 'product_gallery_screen.dart';
import 'product_review_screen.dart';
import '../../config/app_config.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int selectedColor = 0;
  int quantity = 1;

  bool isFavorite = false;
  bool showProductDetails = false;
  bool showDeliveryDetails = false;

  String selectedArea = 'Choose an area';

  final List<Color> colors = [
    const Color(0xFF87502F),
    const Color(0xFFC18A50),
    const Color(0xFF292929),
  ];

  final List<String> colorNames = [
    'Brown',
    'Tan',
    'Black',
  ];

  final String productImage = 'assets/wallet1.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,

      // HEADER
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.only(left: AppDimensions.spaceSM),
          child: AppBackButton(),
        ),
        title: const Text(
          AppConfig.brandName,
          style: AppTextStyles.bodyEmphasis,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(
              right: AppDimensions.spaceLG,
            ),
            child: Center(
              child: Text(
                'Bag · 2',
                style: AppTextStyles.label,
              ),
            ),
          ),
        ],
      ),

      // PRODUCT CONTENT
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.screenPadding - 4,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // PRODUCT IMAGE
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const ProductGalleryScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 240,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3EAE1),
                        borderRadius: BorderRadius.circular(
                          AppDimensions.borderRadius,
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset(
                        productImage,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  // FAVORITE BUTTON
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Material(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(
                        AppDimensions.borderRadius - 1,
                      ),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        icon: Icon(
                          isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: isFavorite
                              ? AppColors.error
                              : AppColors.darkBlue,
                        ),
                      ),
                    ),
                  ),

                  // FULLSCREEN BUTTON
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Material(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(
                        AppDimensions.borderRadius - 1,
                      ),
                      child: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                backgroundColor: Colors.transparent,
                                insetPadding: const EdgeInsets.all(12),
                                child: GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: InteractiveViewer(
                                    child: Image.asset(
                                      productImage,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.fullscreen,
                          color: AppColors.darkBlue,
                        ),
                      ),
                    ),
                  ),

                  // IMAGE COUNTER
                  Positioned(
                    bottom: 8,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.spaceLG - 4,
                        vertical: AppDimensions.spaceSM - 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        '1 / 4',
                        style: AppTextStyles.bodySmall,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppDimensions.spaceLG),

              // PRODUCT NAME
              const Text(
                'Classic Bifold Wallet',
                style: AppTextStyles.sectionHeading,
              ),

              const SizedBox(height: AppDimensions.spaceMD),

              // RATING
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RatingsScreen(),
                    ),
                  );
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.orange,
                      size: 17,
                    ),
                    SizedBox(width: AppDimensions.spaceXS),
                    Text(
                      '4.8 (124 reviews)',
                      style: AppTextStyles.link,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppDimensions.spaceLG),

              // PRICE
              Text(
                '৳1,490',
                style: AppTextStyles.sectionHeading.copyWith(
                  fontSize: 27,
                ),
              ),

              const SizedBox(height: AppDimensions.spaceLG),

              // COLOR TITLE
              Text(
                'Colour · ${colorNames[selectedColor]}',
                style: AppTextStyles.label,
              ),

              const SizedBox(height: AppDimensions.spaceMD),

              // COLOR SELECTION
              Row(
                children: List.generate(colors.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColor = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                        right: AppDimensions.spaceMD,
                      ),
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: selectedColor == index
                              ? AppColors.primary
                              : AppColors.border,
                          width: selectedColor == index ? 2 : 1,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 19,
                        backgroundColor: colors[index],
                        child: selectedColor == index
                            ? const Icon(
                                Icons.check,
                                color: AppColors.surface,
                                size: 19,
                              )
                            : null,
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: AppDimensions.spaceMD),

              // STOCK STATUS
              const Text(
                'In stock',
                style: TextStyle(
                  color: Color(0xFF087B52),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: AppDimensions.spaceMD),

              const Divider(),

              // PRODUCT DETAILS
              sectionHeader(
                title: 'Product details',
                subtitle: 'Material, dimensions & care',
                expanded: showProductDetails,
                onTap: () {
                  setState(() {
                    showProductDetails = !showProductDetails;
                  });
                },
              ),

              if (showProductDetails) ...[
                const SizedBox(height: AppDimensions.spaceMD),

                detailRow('Material', 'Leather · sample'),
                detailRow('Style', 'Bifold'),
                detailRow('Dimensions', 'To be confirmed'),
                detailRow('Product code', 'TNX-W001 · sample'),

                const SizedBox(height: AppDimensions.spaceSM),

                const Text(
                  'Wipe gently with a dry cloth. Final care '
                  'instructions will follow the approved product '
                  'specification.',
                  style: AppTextStyles.bodySmall,
                ),
              ],

              const SizedBox(height: AppDimensions.spaceLG),

              const Divider(),

              // DELIVERY & RETURNS
              sectionHeader(
                title: 'Delivery & returns',
                subtitle: 'Enter your area for cost & estimate',
                expanded: showDeliveryDetails,
                onTap: () {
                  setState(() {
                    showDeliveryDetails = !showDeliveryDetails;
                  });
                },
              ),

              if (showDeliveryDetails) ...[
                const SizedBox(height: AppDimensions.spaceLG),

                const Text(
                  'Delivery area',
                  style: AppTextStyles.label,
                ),

                const SizedBox(height: AppDimensions.spaceSM),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.spaceMD,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.border,
                    ),
                    borderRadius: BorderRadius.circular(
                      AppDimensions.borderRadius - 2,
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedArea,
                      isExpanded: true,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.darkBlue,
                      ),
                      items: [
                        'Choose an area',
                        'Inside Dhaka',
                        'Outside Dhaka',
                      ].map((area) {
                        return DropdownMenuItem<String>(
                          value: area,
                          child: Text(
                            area,
                            style: AppTextStyles.body,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedArea = value;
                          });
                        }
                      },
                    ),
                  ),
                ),

                const SizedBox(height: AppDimensions.spaceLG),

                const Text(
                  'Delivery charges and dates depend on your address. '
                  'Final charges will be shown before placing an order.',
                  style: AppTextStyles.bodySmall,
                ),

                const SizedBox(height: AppDimensions.spaceLG),

                GestureDetector(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.only(
                      left: AppDimensions.spaceSM,
                    ),
                    child: Text(
                      'View return policy',
                      style: AppTextStyles.link,
                    ),
                  ),
                ),
              ],

              const SizedBox(height: AppDimensions.spaceXXL),
            ],
          ),
        ),
      ),

      // FIXED BOTTOM CART
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spaceLG,
          vertical: AppDimensions.spaceMD,
        ),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(
            top: BorderSide(
              color: AppColors.border,
              width: AppDimensions.borderWidth,
            ),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Row(
            children: [
              // QUANTITY SELECTOR
              Container(
                height: AppDimensions.compactButtonHeight,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.border,
                  ),
                  borderRadius: BorderRadius.circular(
                    AppDimensions.borderRadius - 2,
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: quantity > 1
                          ? () {
                              setState(() {
                                quantity--;
                              });
                            }
                          : null,
                      icon: const Icon(
                        Icons.remove,
                        size: 17,
                        color: AppColors.textSecondary,
                      ),
                    ),

                    Text(
                      '$quantity',
                      style: AppTextStyles.bodyEmphasis,
                    ),

                    IconButton(
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                      icon: const Icon(
                        Icons.add,
                        size: 17,
                        color: AppColors.darkBlue,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: AppDimensions.spaceMD),

              // ADD TO CART BUTTON
              Expanded(
                child: PrimaryButton(
                  text: 'Add to cart',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '$quantity wallet(s) added to cart',
                        ),
                        backgroundColor: AppColors.primary,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // EXPANDABLE SECTION HEADER
  Widget sectionHeader({
    required String title,
    required String subtitle,
    required bool expanded,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppDimensions.spaceXS - 1,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  expanded
                      ? Icons.arrow_drop_down
                      : Icons.arrow_right,
                  size: AppDimensions.iconSize - 7,
                  color: AppColors.darkBlue,
                ),
                Text(
                  title,
                  style: AppTextStyles.label,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: AppDimensions.spaceXS - 1,
              ),
              child: Text(
                subtitle,
                style: AppTextStyles.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // PRODUCT DETAIL ROW
  Widget detailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppDimensions.spaceLG,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.bodySmall,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.body,
            ),
          ),
        ],
      ),
    );
  }
}