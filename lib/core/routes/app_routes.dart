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
  themePreview(path: '/theme-preview', name: 'themePreview'),
  home(path: '/', name: 'home');

  final String path;
  final String name;

  const AppRoute({
    required this.path,
    required this.name,
  });
}
