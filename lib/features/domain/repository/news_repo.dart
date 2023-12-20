import 'package:news/features/data/model/news.dart';
import 'package:news/features/data/model/result_request.dart';

abstract class NewsRepo{
  Future<List<News>> getNews();
  Future<List<News>> getNewsByCate(String cat);
  Future<ResultRequest> searchNewsByKeyword(String keyword, String? nextPageId);
}