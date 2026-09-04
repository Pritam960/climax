import 'package:flutter/material.dart';
import 'package:climax_app/core/themes/themes.dart';
import 'package:climax_app/core/themes/theme_preview_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Climax — Theme Preview',
      debugShowCheckedModeBanner: false,
      // Light theme only — psychology-based blue palette
      theme: AppTheme.light,
      themeMode: ThemeMode.light,
      home: const ThemePreviewPage(),
    );
  }
}

