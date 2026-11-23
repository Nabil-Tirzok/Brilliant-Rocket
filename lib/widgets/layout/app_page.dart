import 'package:material_ui/material_ui.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';

class AppPage extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;
  final bool scrollable;

  const AppPage({
    super.key,
    required this.child,
    this.backgroundColor = AppColors.surface,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppDimensions.screenPadding,
    ),
    this.scrollable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: scrollable
            ? SingleChildScrollView(
                padding: padding,
                child: child,
              )
            : Padding(
                padding: padding,
                child: child,
              ),
      ),
    );
  }
}
