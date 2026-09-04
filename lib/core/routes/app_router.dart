import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/page/splash_page.dart';
import '../../features/auth/page/login_page.dart';
import '../../features/auth/page/sign_up_page.dart';
import '../../features/auth/page/forgot_password_page.dart';
import '../../features/auth/page/otp_page.dart';
import '../../features/auth/page/reset_password_page.dart';
import '../../features/home/page/home_page.dart';
import '../../features/transactions/page/transactions_page.dart';
import '../../features/profile/page/profile_page.dart';
import 'main_shell.dart';
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
      GoRoute(
        path: AppRoute.forgotPassword.path,
        name: AppRoute.forgotPassword.name,
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: AppRoute.otp.path,
        name: AppRoute.otp.name,
        builder: (context, state) => const OtpPage(),
      ),
      GoRoute(
        path: AppRoute.resetPassword.path,
        name: AppRoute.resetPassword.name,
        builder: (context, state) => const ResetPasswordPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          // the UI shell
          return MainShell(navigationShell: navigationShell);
        },
        branches: [
          // Branch 1: Home
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'shellHome'),
            routes: [
              GoRoute(
                path: AppRoute.home.path,
                name: AppRoute.home.name,
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          // Branch 2: Transactions
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'shellTransactions'),
            routes: [
              GoRoute(
                path: AppRoute.transactions.path,
                name: AppRoute.transactions.name,
                builder: (context, state) => const TransactionsPage(),
              ),
            ],
          ),
          // Branch 3: Profile
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'shellProfile'),
            routes: [
              GoRoute(
                path: AppRoute.profile.path,
                name: AppRoute.profile.name,
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
    ],

    // Optional: Add redirect logic here later for Authentication
    // redirect: (context, state) { ... },
  );
});

// Create a GlobalKey for the root navigator so we can access context anywhere if needed
final rootNavigatorKey = GlobalKey<NavigatorState>();
