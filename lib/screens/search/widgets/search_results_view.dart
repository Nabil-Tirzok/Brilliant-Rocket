import 'package:material_ui/material_ui.dart';

import '../../../theme/app_dimensions.dart';
import '../../../theme/app_text_styles.dart';
import '../../../widgets/buttons/back_button.dart';
import '../../../widgets/product/product_card.dart';

class SearchResultsView extends StatefulWidget {
  final VoidCallback onBack;

  const SearchResultsView({
    super.key,
    required this.onBack,
  });

  @override
  State<SearchResultsView> createState() => _SearchResultsViewState();
}

class _SearchResultsViewState extends State<SearchResultsView> {
  String selectedSort = 'Featured';

  final List<Map<String, dynamic>> products = [
    {
      'name': 'Classic Bifold',
      'price': '৳1,490',
      'rating': '4.8',
      'reviews': '124',
      'stock': 'In stock',
    },
    {
      'name': 'Heritage Belt',
      'price': '৳1,790',
      'rating': '4.7',
      'reviews': '86',
      'stock': 'In stock',
    },
    {
      'name': 'Leather Wallet',
      'price': '৳1,290',
      'rating': '4.9',
      'reviews': '98',
      'stock': 'In stock',
    },
    {
      'name': 'Classic Card Holder',
      'price': '৳990',
      'rating': '4.6',
      'reviews': '52',
      'stock': 'In stock',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.screenPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppDimensions.spaceLG),

          // PAGE HEADER
          Row(
            children: [
              AppBackButton(
                onPressed: widget.onBack,
              ),
              const SizedBox(width: AppDimensions.spaceMD),
              const Text(
                'All products',
                style: AppTextStyles.bodyEmphasis,
              ),
            ],
          ),

          const SizedBox(height: AppDimensions.spaceSM),

          Text(
            '${products.length} products',
            style: AppTextStyles.bodySmall,
          ),

          const SizedBox(height: AppDimensions.spaceLG),

          // FILTER AND SORT CONTROLS
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Filter action can be implemented here.
                  },
                  icon: const Icon(Icons.tune),
                  label: const Text('Filter'),
                ),
              ),
              const SizedBox(width: AppDimensions.spaceSM),
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: selectedSort,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                  ),
                  items: [
                    'Featured',
                    'Price: Low to High',
                    'Price: High to Low',
                    'Top Rated',
                  ].map((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedSort = value;
                        sortProducts();
                      });
                    }
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: AppDimensions.spaceLG),

          // PRODUCT GRID
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.only(
                bottom: AppDimensions.spaceLG,
              ),
              itemCount: products.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppDimensions.spaceMD,
                mainAxisSpacing: AppDimensions.spaceMD,
                childAspectRatio: 0.55,
              ),
              itemBuilder: (context, index) {
                final product = products[index];

                return ProductCard(
                  name: product['name'],
                  price: product['price'],
                  rating: product['rating'],
                  reviewCount: product['reviews'],
                  stockText: product['stock'],
                  onPressed: () {
                    // TODO: Navigate to product details.
                  },
                  onFavoriteChanged: (isFavorite) {
                    debugPrint(
                      '${product['name']} favorite: $isFavorite',
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // SORT PRODUCTS
  void sortProducts() {
    switch (selectedSort) {
      case 'Price: Low to High':
        products.sort(
          (a, b) => getPrice(a).compareTo(getPrice(b)),
        );
        break;

      case 'Price: High to Low':
        products.sort(
          (a, b) => getPrice(b).compareTo(getPrice(a)),
        );
        break;

      case 'Top Rated':
        products.sort(
          (a, b) => double.parse(b['rating'])
              .compareTo(double.parse(a['rating'])),
        );
        break;

      default:
        break;
    }
  }

  int getPrice(Map<String, dynamic> product) {
    return int.parse(
      product['price'].replaceAll(RegExp(r'[^0-9]'), ''),
    );
  }
}