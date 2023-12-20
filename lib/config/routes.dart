import 'package:flutter/material.dart';
import 'package:news/features/data/model/news.dart';
import 'package:news/features/presentation/pages/detail_feed/news_detail.dart';
import 'package:news/features/presentation/pages/feed/news_scr.dart';
import 'package:news/features/presentation/pages/search/search_scr.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(NewsScreen());
      case '/NewsDetails':
        return _materialRoute(NewsDetailScr(news: settings.arguments as News));
      case '/Search':
        return _materialRoute(SearchScr(keyword: settings.arguments as String));
      default:
        return _materialRoute(NewsScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}