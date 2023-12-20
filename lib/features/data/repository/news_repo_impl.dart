import 'package:news/features/data/data_sources/news_service.dart';
import 'package:news/features/data/model/news.dart';
import 'package:news/features/data/model/result_request.dart';
import 'package:news/features/domain/repository/news_repo.dart';

class NewsRepoImpl implements NewsRepo{
  NewsRepoImpl(this.webService);
  final NewsService webService;

  @override
  Future<List<News>> getNews() async {
    try {
      dynamic response = await webService.getNews();
      return response;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<List<News>> getNewsByCate(String cat) async{
    try {
      dynamic response;
      switch (cat){
        case 'Tech':
          response = await webService.getNewsByTechnologyCat();
        case 'Bus':
          response = await webService.getNewsByBusinessCat();
        case 'Ent':
          response = await webService.getNewsByEntertainmentCat();
      }

      return response;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<ResultRequest> searchNewsByKeyword(String keyword, String? nextPageId) async{
    try {
      dynamic response = await webService.search(keyword, nextPageId);
      return response;
    } catch (e) {
      throw e;
    }
  }

}