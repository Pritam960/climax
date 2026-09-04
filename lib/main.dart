import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:climax_app/core/themes/themes.dart';
import 'package:climax_app/core/routes/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Wrapped MyApp in ProviderScope to enable Riverpod
  runApp(const ProviderScope(child: MyApp()));
}

// Changed to ConsumerWidget to watch Riverpod providers
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the GoRouter configuration from our provider
    final goRouter = ref.watch(goRouterProvider);

    // Use MaterialApp.router for GoRouter integration
    return MaterialApp.router(
      title: 'Climax',
      debugShowCheckedModeBanner: false,
      // Light theme only — psychology-based blue palette
      theme: AppTheme.light,
      themeMode: ThemeMode.light,
      routerConfig: goRouter,
    );
  }
}

