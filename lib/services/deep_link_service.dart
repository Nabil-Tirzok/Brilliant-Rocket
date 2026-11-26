import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';

import 'package:brilliant_rocket/config/app_routes.dart';

class DeepLinkService {
  static final AppLinks _appLinks = AppLinks();

  static StreamSubscription<Uri>? _subscription;

  static GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Future<void> initialize() async {
    _subscription = _appLinks.uriLinkStream.listen(
      (uri) {
        if (uri.scheme == 'brilliantrocket' &&
            uri.host == 'reset-password') {
          final token = uri.queryParameters['token'];

          if (token != null && token.isNotEmpty) {
            navigatorKey.currentState?.pushNamed(
              AppRoutes.resetPassword,
              arguments: token,
            );
          }
        }
      },
      onError: (error) {
        debugPrint('Deep link error: $error');
      },
    );
  }
}