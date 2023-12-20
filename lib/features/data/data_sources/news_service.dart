import 'package:dio/dio.dart';
import 'package:news/features/data/model/news.dart';
import 'package:news/features/data/model/result_request.dart';

class NewsService {
  NewsService(this.dio);
  final Dio dio;
  String endpoint = 'https://newsdata.io/api/1/news?apikey=pub_337710e145071e905e290eb424f84d59c039e&country=us';
  String urlCategory = 'https://newsdata.io/api/1/news?apikey=pub_337710e145071e905e290eb424f84d59c039e&country=us&category=';
  String searchUrl = 'https://newsdata.io/api/1/news?apikey=pub_337710e145071e905e290eb424f84d59c039e&q=';
  Future<List<News>> getNews() async {
    Response response = await dio.get(endpoint);
    if (response.statusCode == 200) {
      final List result = response.data['results'] as List;
      return result.map(((e) => News.fromMap(e))).toList();
    } else {
      throw Exception(response.statusMessage);
    }
  }
  Future<List<News>> getNewsByTechnologyCat() async {
    Response response = await dio.get(urlCategory + 'technology');
    if (response.statusCode == 200) {
      final List result = response.data['results'] as List;
      return result.map(((e) => News.fromMap(e))).toList();
    } else {
      throw Exception(response.statusMessage);
    }
  }
  Future<List<News>> getNewsByBusinessCat() async {
    Response response = await dio.get(urlCategory + 'business');
    if (response.statusCode == 200) {
      final List result = response.data['results'] as List;
      return result.map(((e) => News.fromMap(e))).toList();
    } else {
      throw Exception(response.statusMessage);
    }
  }
  Future<List<News>> getNewsByEntertainmentCat() async {
    Response response = await dio.get(urlCategory + 'entertainment');
    if (response.statusCode == 200) {
      final List result = response.data['results'] as List;
      return result.map(((e) => News.fromMap(e))).toList();
    } else {
      throw Exception(response.statusMessage);
    }
  }
  /*
  Future<List<News>> searchNews(String key, String? nextPageId) async {

    String urlQuerty = "";
    if (nextPageId != null){
      urlQuerty = searchUrl + '$key&page=$nextPageId';
    } else {
      urlQuerty = searchUrl + '$key';
    }
    print("search trong service");

    Response response = await dio.get(urlQuerty);

    if (response.statusCode == 200) {
      final List result = response.data['results'] as List;
      return result.map(((e) => News.fromMap(e))).toList();
    } else {
      throw Exception(response.statusMessage);
    }
  }

   */

  Future<ResultRequest> search(String key, String? nextPageId) async{
    String urlQuerty = "";
    if (nextPageId != null){
      urlQuerty = searchUrl + '$key&page=$nextPageId';
    } else {
      urlQuerty = searchUrl + '$key';
    }
    print("search trong service");
    print(urlQuerty);

    Response response = await dio.get(urlQuerty);
    ResultRequest resultRequest = ResultRequest.fromMap(response.data);
    return resultRequest;
  }
}