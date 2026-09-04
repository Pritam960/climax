import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'app_routes.dart';

// Create a GlobalKey for the root navigator so we can access context anywhere if needed
final rootNavigatorKey = GlobalKey<NavigatorState>();

/// Provider for GoRouter (Riverpod 2.x syntax)
/// This allows us to inject auth state or other dependencies into our router later.
final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation:
        AppRoute.themePreview.path, // Start at theme preview for now
    debugLogDiagnostics: true, // Helpful for debugging routes
    // Define all app routes here
    routes: [
      // We will add more routes here later (e.g. Login, Home)
      // GoRoute(
      //   path: AppRoute.splash.path,
      //   name: AppRoute.splash.name,
      //   builder: (context, state) => const SplashPage(),
      // ),
    ],

    // Optional: Add redirect logic here later for Authentication
    // redirect: (context, state) { ... },
  );
});
