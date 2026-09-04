import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/page/forgot_password_page.dart';
import '../../features/auth/page/login_page.dart';
import '../../features/auth/page/otp_page.dart';
import '../../features/auth/page/reset_password_page.dart';
import '../../features/auth/page/sign_up_page.dart';
import '../../features/auth/page/splash_page.dart';
import '../../features/collect/page/collect_page.dart';
import '../../features/home/page/home_page.dart';
import '../../features/more/page/more_page.dart' hide HomePage;
import '../../features/students/page/students_page.dart';
import 'app_routes.dart';
import 'main_shell.dart';

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
          // Branch 2: students
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(
              debugLabel: 'shellStudents',
            ),
            routes: [
              GoRoute(
                path: AppRoute.students.path,
                name: AppRoute.students.name,
                builder: (context, state) => const StudentsPage(),
              ),
            ],
          ),
          // Branch 3: collect
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'shellCollect'),
            routes: [
              GoRoute(
                path: AppRoute.collect.path,
                name: AppRoute.collect.name,
                builder: (context, state) => const CollectPage(),
              ),
            ],
          ),
          // Branch 3: more
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'shellMore'),
            routes: [
              GoRoute(
                path: AppRoute.more.path,
                name: AppRoute.more.name,
                builder: (context, state) => const MorePage(),
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
