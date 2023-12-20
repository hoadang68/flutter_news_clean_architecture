import 'package:news/core/usercase/usercase.dart';
import 'package:news/features/data/model/news.dart';
import 'package:news/features/domain/repository/news_repo.dart';

class GetNewsByCateUseCase implements UserCase<List<News>, String>{
  final NewsRepo _newsRepo;
  GetNewsByCateUseCase(this._newsRepo);
  @override
  Future<List<News>> call(String params) {
    return _newsRepo.getNewsByCate(params);
  }
}