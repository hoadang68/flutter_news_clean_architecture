import 'package:news/core/usercase/usercase.dart';
import 'package:news/features/data/model/result_request.dart';
import 'package:news/features/domain/repository/news_repo.dart';

class SearchNewsUseCase implements UserCase<ResultRequest, Param>{
  final NewsRepo _newsRepo;
  SearchNewsUseCase(this._newsRepo);
  @override
  Future<ResultRequest> call(Param params) {
    return _newsRepo.searchNewsByKeyword(params.keyword, params.nextPageId);
  }
}
class Param{
  final String keyword;
  final String? nextPageId;

  Param(this.keyword, this.nextPageId);
}