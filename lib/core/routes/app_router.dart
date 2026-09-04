import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/page/splash_page.dart';
import '../../features/auth/page/login_page.dart';
import '../../features/auth/page/sign_up_page.dart';
import 'app_routes.dart';

/// Provider for GoRouter (Riverpod 2.x syntax)
/// This allows us to inject auth state or other dependencies into our router later.
final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoute.splash.path, // Start at splash screen
    debugLogDiagnostics: true, // Helpful for debugging routes
    // Define all app routes here
    routes: [
      GoRoute(
        path: AppRoute.splash.path,
        name: AppRoute.splash.name,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoute.login.path,
        name: AppRoute.login.name,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoute.signup.path,
        name: AppRoute.signup.name,
        builder: (context, state) => const SignUpPage(),
      ),
    ],

    // Optional: Add redirect logic here later for Authentication
    // redirect: (context, state) { ... },
  );
});

// Create a GlobalKey for the root navigator so we can access context anywhere if needed
final rootNavigatorKey = GlobalKey<NavigatorState>();
