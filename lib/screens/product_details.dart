import 'package:material_ui/material_ui.dart';


class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int selectedColor = 0;
  bool isFavorite = false;

  bool productDetailsExpanded = true;
  bool deliveryExpanded = true;

  String selectedArea = 'Choose an area';

  final List<Color> colors = [
    const Color(0xFF87502F),
    const Color(0xFFC18A50),
    const Color(0xFF292929),
  ];

  final List<String> areas = [
    'Choose an area',
    'Dhaka',
    'Outside Dhaka',
  ];

  final Color navy = const Color(0xFF091F52);
  final Color muted = const Color(0xFF586987);
  final Color blue = const Color(0xFF0866E8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),

            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProductImage(),

                    _buildProductInfo(),

                    const SizedBox(height: 12),

                    _buildColorSelector(),

                    const SizedBox(height: 15),

                    _buildStockStatus(),

                    const SizedBox(height: 14),

                    _buildDivider(),

                    _buildProductDetails(),

                    _buildDivider(),

                    _buildDeliverySection(),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // APP BAR

  Widget _buildAppBar() {
    return Container(
      height: 49,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Icon(
            Icons.arrow_back,
            color: navy,
            size: 21,
          ),

          const SizedBox(width: 22),

          Expanded(
            child: Text(
              'Tannix Leather',
              style: TextStyle(
                color: navy,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Text(
            'Bag · 2',
            style: TextStyle(
              color: navy,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // PRODUCT IMAGE

  Widget _buildProductImage() {
    return Container(
      height: 230,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFF3EEE9),
        borderRadius: BorderRadius.circular(14),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/wallet.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Icon(
                  Icons.image,
                  size: 70,
                  color: Colors.grey,
                ),
              );
            },
          ),

          // Favorite button

          Positioned(
            top: 0,
            left: 0,
            child: _imageButton(
              child: Icon(
                isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: navy,
                size: 22,
              ),
              onTap: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
            ),
          ),

          // Fullscreen button

          Positioned(
            top: 0,
            right: 0,
            child: _imageButton(
              child: Icon(
                Icons.fullscreen,
                color: navy,
                size: 25,
              ),
              onTap: () {},
            ),
          ),

          // Image counter

          Positioned(
            bottom: 0,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 5,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(15),
                ),
              ),
              child: Text(
                '1 / 4',
                style: TextStyle(
                  color: navy,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _imageButton({
    required Widget child,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 53,
        height: 45,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(14),
          ),
        ),
        child: Center(child: child),
      ),
    );
  }

  // PRODUCT INFORMATION

  Widget _buildProductInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Classic Bifold Wallet',
            style: TextStyle(
              color: navy,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              const Icon(
                Icons.star,
                color: Color(0xFFE99A00),
                size: 15,
              ),

              const SizedBox(width: 3),

              Text(
                '4.8 (124 reviews)',
                style: TextStyle(
                  color: blue,
                  fontSize: 14,
                ),
              ),
            ],
          ),

          const SizedBox(height: 17),

          Text(
            '৳1,490',
            style: TextStyle(
              color: navy,
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          Text(
            'Colour · ${['Brown', 'Tan', 'Black'][selectedColor]}',
            style: TextStyle(
              color: navy,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // COLOR SELECTOR

  Widget _buildColorSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19),
      child: Row(
        children: List.generate(colors.length, (index) {
          bool selected = selectedColor == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedColor = index;
              });
            },
            child: Container(
              width: 47,
              height: 47,
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? blue : const Color(0xFFD8DEE8),
                  width: selected ? 2 : 1,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: colors[index],
                  shape: BoxShape.circle,
                ),
                child: selected
                    ? const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 20,
                      )
                    : null,
              ),
            ),
          );
        }),
      ),
    );
  }

  // STOCK STATUS

  Widget _buildStockStatus() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        'In stock',
        style: TextStyle(
          color: Colors.green.shade800,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // DIVIDER

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Divider(
        height: 1,
        thickness: 0.8,
        color: const Color(0xFFD8E0EB),
      ),
    );
  }

  // PRODUCT DETAILS

  Widget _buildProductDetails() {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              productDetailsExpanded =
                  !productDetailsExpanded;
            });
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 17, 20, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      productDetailsExpanded
                          ? Icons.arrow_drop_down
                          : Icons.arrow_right,
                      color: navy,
                      size: 18,
                    ),
                    Text(
                      'Product details',
                      style: TextStyle(
                        color: navy,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Text(
                    'Material, dimensions & care',
                    style: TextStyle(
                      color: muted,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        if (productDetailsExpanded)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 25),
            child: Column(
              children: [
                _detailRow('Material', 'Leather · sample'),
                _detailRow('Style', 'Bifold'),
                _detailRow('Dimensions', 'To be confirmed'),
                _detailRow('Product code', 'TNX-W001 · sample'),

                const SizedBox(height: 5),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Wipe gently with a dry cloth. Final care '
                    'instructions will follow the approved '
                    'product specification.',
                    style: TextStyle(
                      color: muted,
                      fontSize: 12,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _detailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 17),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: muted,
                fontSize: 14,
              ),
            ),
          ),

          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: navy,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // DELIVERY AND RETURNS

  Widget _buildDeliverySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              deliveryExpanded = !deliveryExpanded;
            });
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 17, 20, 17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      deliveryExpanded
                          ? Icons.arrow_drop_down
                          : Icons.arrow_right,
                      color: navy,
                      size: 18,
                    ),

                    Text(
                      'Delivery & returns',
                      style: TextStyle(
                        color: navy,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                Text(
                  'Enter your area for cost & estimate',
                  style: TextStyle(
                    color: muted,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),

        if (deliveryExpanded)
          Padding(
            padding: const EdgeInsets.fromLTRB(19, 0, 20, 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Delivery area',
                  style: TextStyle(
                    color: navy,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                // Area Dropdown

                Container(
                  height: 46,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFBAC8DD),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedArea,
                      isExpanded: true,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: navy,
                      ),
                      style: TextStyle(
                        color: navy,
                        fontSize: 14,
                      ),
                      items: areas.map((area) {
                        return DropdownMenuItem(
                          value: area,
                          child: Text(area),
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

                const SizedBox(height: 16),

                Text(
                  'Delivery charges and dates depend on your '
                  'address. Final charges will be shown before '
                  'placing an order.',
                  style: TextStyle(
                    color: muted,
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 23),

                GestureDetector(
                  onTap: () {
                    // Navigate to return policy page
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 7),
                    child: Text(
                      'View return policy',
                      style: TextStyle(
                        color: blue,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
