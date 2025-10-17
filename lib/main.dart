import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/app_colors.dart';
import 'features/navigation/presentation/pages/main_navigation_page.dart';

void main() {
  runApp(const ProviderScope(child: NayafitsApp()));
}

class NayafitsApp extends StatelessWidget {
  const NayafitsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nayafits',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: const MainNavigationPage(),
    );
  }
}
