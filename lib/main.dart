import 'package:flutter/material.dart';
import 'package:news/config/routes.dart';
import 'package:news/config/theme.dart';
import 'package:news/features/presentation/pages/feed/news_scr.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.mTheme(),
      onGenerateRoute: AppRoutes.onGenerateRoutes,
      home: const NewsScreen(),
    );
  }
}


