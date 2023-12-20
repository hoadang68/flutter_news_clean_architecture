import 'package:news/features/data/model/news.dart';
import 'package:news/features/data/model/result_request.dart';
import 'package:news/features/data/repository/news_repo_impl.dart';
import 'package:news/features/domain/usecases/get_news.dart';
import 'package:news/features/domain/usecases/get_news_by_cate.dart';
import 'package:news/features/domain/usecases/search_news.dart';
import 'package:rxdart/rxdart.dart';

class NewsBloc{
  NewsBloc({required this.repository});

  final NewsRepoImpl repository;
  final _trendingNewsFetcher = BehaviorSubject<List<News>>();
  final _techNewsFetcher = BehaviorSubject<List<News>>();
  final _bussNewsFetcher = BehaviorSubject<List<News>>();
  final _searchNewsFetcher = BehaviorSubject<List<News>>();
  final _lastestPageSearched = BehaviorSubject<ResultRequest>();

  BehaviorSubject<List<News>> get trendingNewsFetcher => _trendingNewsFetcher;
  BehaviorSubject<List<News>> get techNewsFetcher => _techNewsFetcher;
  BehaviorSubject<List<News>> get bussNewsFetcher => _bussNewsFetcher;
  BehaviorSubject<List<News>> get searchNewsFetcher => _searchNewsFetcher;
  BehaviorSubject<ResultRequest> get lastestPageSearched => _lastestPageSearched;

  void fetchNews() async{
    final List<News> modelApi = await GetNewsUseCase(repository).call(null);
    _trendingNewsFetcher.sink.add(modelApi);
  }
  void fetchTechNews() async{
    final List<News> modelApi = await GetNewsByCateUseCase(repository).call("Tech");
    _techNewsFetcher.sink.add(modelApi);
  }
  void fetchBussNews() async{
    final List<News> modelApi = await GetNewsByCateUseCase(repository).call("Bus");
    _bussNewsFetcher.sink.add(modelApi);
  }
  void search(String keyword) async{
    ResultRequest?  lastestPage = lastestPageSearched.valueOrNull;
    List<News> listNewsCurrent = searchNewsFetcher.valueOrNull ?? [];
    String? nextPageId = lastestPage?.nextPage;
    final ResultRequest nextPageResult = await SearchNewsUseCase(repository).call(Param(keyword,nextPageId));
    _lastestPageSearched.sink.add(nextPageResult);
    listNewsCurrent.addAll(nextPageResult.results);
    _searchNewsFetcher.sink.add(listNewsCurrent);
  }
  void dispose(){
    _trendingNewsFetcher.close();
    _techNewsFetcher.close();
    _bussNewsFetcher.close();
    _lastestPageSearched.close();
    _searchNewsFetcher.close();
  }
}