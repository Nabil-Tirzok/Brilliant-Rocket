import 'package:material_ui/material_ui.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/buttons/back_button.dart';
import 'widgets/search_history_view.dart';
import 'widgets/search_results_view.dart';

enum SearchState {
  history,
  results,
  empty,
  loading,
  offline,
  error,
}

class SearchScreen extends StatefulWidget {
  final SearchState state;
  final ValueChanged<String>? onSearchSubmitted;

  const SearchScreen({
    super.key,
    this.state = SearchState.history,
    this.onSearchSubmitted,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  late SearchState currentState;

  int selectedIndex = 0;

  final List<String> recentSearches = [
    'slim wallet',
    'leather wallet',
    'brown belt',
    'work bag',
  ];

  @override
  void initState() {
    super.initState();
    currentState = widget.state;
  }

  @override
  void didUpdateWidget(covariant SearchScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.state != widget.state) {
      currentState = widget.state;
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // REMOVE RECENT SEARCH
  void removeSearch(int index) {
    setState(() {
      recentSearches.removeAt(index);
    });
  }

  // CLEAR RECENT SEARCHES
  void clearSearches() {
    setState(() {
      recentSearches.clear();
    });
  }

  // SUBMIT SEARCH
  void submitSearch(String query) {
    if (query.trim().isEmpty) return;

    setState(() {
      currentState = SearchState.loading;
    });

    widget.onSearchSubmitted?.call(query);
  }

  // CHANGE SEARCH STATE
  void changeSearchState(SearchState state) {
    setState(() {
      currentState = state;
    });
  }

  // DYNAMIC SEARCH CONTENT
  Widget buildSearchContent() {
    switch (currentState) {
      case SearchState.history:
        return SearchHistoryView(
          recentSearches: recentSearches,
          onRemoveSearch: removeSearch,
          onClearSearches: clearSearches,
          onBrowseAllProducts: () {
            changeSearchState(SearchState.results);
          },
        );

      case SearchState.results:
        return SearchResultsView(
          onBack: () {
            changeSearchState(SearchState.history);
          },
        );

      case SearchState.empty:
        return const SizedBox.shrink();

      case SearchState.loading:
        return const SizedBox.shrink();

      case SearchState.offline:
        return const SizedBox.shrink();

      case SearchState.error:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.screenPadding,
              ),
              child: Column(
                children: [
                  const SizedBox(height: AppDimensions.spaceSM),

                  Row(
                    children: [
                      const AppBackButton(),
                      const SizedBox(width: AppDimensions.spaceLG),
                      const Text(
                        'Search',
                        style: AppTextStyles.sectionHeading,
                      ),
                      const Spacer(),
                      const Text(
                        'Bag · 2',
                        style: AppTextStyles.label,
                      ),
                    ],
                  ),

                  const SizedBox(height: AppDimensions.spaceMD),

                  // SEARCH BAR
                  Container(
                    height: AppDimensions.inputHeight,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(
                        AppDimensions.borderRadius,
                      ),
                      border: Border.all(
                        color: AppColors.border,
                      ),
                    ),
                    child: TextField(
                      controller: searchController,
                      style: AppTextStyles.body,
                      textInputAction: TextInputAction.search,
                      onSubmitted: submitSearch,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: AppColors.textSecondary,
                        ),
                        hintText: 'Search wallets, bags and more',
                        hintStyle: AppTextStyles.bodySmall,
                        suffixIcon: IconButton(
                          onPressed: searchController.clear,
                          icon: const Icon(
                            Icons.close,
                            color: AppColors.textSecondary,
                            size: AppDimensions.iconSize,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // DYNAMIC SEARCH CONTENT
            Expanded(
              child: buildSearchContent(),
            ),
          ],
        ),
      ),

      // BOTTOM NAVIGATION BAR
      bottomNavigationBar: Container(
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
          child: SizedBox(
            height: 64,
            child: Row(
              children: [
                bottomNavItem(Icons.search, 'Search', 0),
                bottomNavItem(Icons.bookmark_border, 'Saved', 1),
                bottomNavItem(Icons.shopping_cart_outlined, 'Cart', 2),
                bottomNavItem(Icons.person_outline, 'Account', 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // BOTTOM NAVIGATION ITEM
  Widget bottomNavItem(
    IconData icon,
    String title,
    int index,
  ) {
    final bool isSelected = selectedIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: SizedBox(
          height: 64,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 22,
                color: isSelected
                    ? AppColors.primary
                    : AppColors.textSecondary,
              ),
              const SizedBox(height: AppDimensions.spaceXS),
              Text(
                title,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isSelected
                      ? FontWeight.w700
                      : FontWeight.w400,
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}