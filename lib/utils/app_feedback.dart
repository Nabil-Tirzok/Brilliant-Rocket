import 'package:material_ui/material_ui.dart';

class AppFeedback {
  AppFeedback._();

  static void showMessage(
    BuildContext context,
    String message, {
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: action,
      ),
    );
  }
}
