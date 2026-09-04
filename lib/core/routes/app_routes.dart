/// Defines all the routes in the app with their paths and names.
/// Using an Enum is the safest way to prevent typos when navigating.
///
/// Usage:
/// ```dart
/// context.goNamed(AppRoute.login.name);
/// ```
enum AppRoute {
  splash(path: '/splash', name: 'splash'),
  login(path: '/login', name: 'login'),
  signup(path: '/signup', name: 'signup'),
  forgotPassword(path: '/forgot-password', name: 'forgotPassword'),
  otp(path: '/otp', name: 'otp'),
  resetPassword(path: '/reset-password', name: 'resetPassword'),
  themePreview(path: '/theme-preview', name: 'themePreview'),
  home(path: '/home', name: 'home'),
  transactions(path: '/transactions', name: 'transactions'),
  profile(path: '/profile', name: 'profile');

  final String path;
  final String name;

  const AppRoute({
    required this.path,
    required this.name,
  });
}
