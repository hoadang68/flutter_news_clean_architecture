import 'package:news/core/usercase/usercase.dart';
import 'package:news/features/data/model/news.dart';
import 'package:news/features/domain/repository/news_repo.dart';

class GetNewsUseCase implements UserCase<List<News>, void>{
  final NewsRepo _newsRepo;
  GetNewsUseCase(this._newsRepo);
  @override
  Future<List<News>> call(void params) {
    return _newsRepo.getNews();
  }
}